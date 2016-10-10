//
//  KLineView.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/26.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "KLineView.h"
#import "KLineXView.h"
#import "KLineYView.h"
#import "KLine.h"
#import "ColumnarLineDataModel.h"
#import "StockKLine.h"

static const char * ContentOffsetFlag;

@interface KLineView () <UIScrollViewDelegate , KlineProtocol>

@property (nonatomic ,strong)UIScrollView *scrollView;

@property (nonatomic ,strong)KLineXView *xView;

@property (nonatomic ,strong)KLineYView *yView;

@property (nonatomic ,strong)KLine *kView;

@property (nonatomic , assign)CGRect kViewF;

@property (nonatomic , assign)CGFloat maxValue;

@property (nonatomic , assign)CGFloat minValue;

@property (nonatomic , assign)CGPoint focusPoint;

@property (nonatomic ,strong)NSArray *kViewArray;

@property (nonatomic ,weak)UIPanGestureRecognizer *panGes;

@end

@implementation KLineView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.focusPoint = CGPointMake(0, 0);
        
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 1.0f;
        _scrollView.alwaysBounceHorizontal = YES;
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 20, 0, -20);
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        _scrollView.frame = (CGRect){{0,0},frame.size};
        [self layoutIfNeeded];
        
        //添加长按手势
        UILongPressGestureRecognizer *longPre = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesAction:)];
        [self.scrollView addGestureRecognizer:longPre];
        
        //添加拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
        pan.enabled = NO;
        [self.scrollView addGestureRecognizer:pan];
        self.panGes = pan;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:&ContentOffsetFlag];
        
        //图
        self.kView = [[KLine alloc] initWithFrame:CGRectMake(0, 0, WIDTH, frame.size.height)];
        self.kViewF = self.kView.frame;
        self.kView.delegate = self;
        [self.scrollView addSubview:self.kView];
        
        //画X值轴
        self.xView = [[KLineXView alloc] init];
        self.xView.type = KLineGapTypeDay;
        [self.scrollView addSubview:self.xView];
        
        //画Y轴
        self.yView = [[KLineYView alloc] initWithFrame:(CGRect){{0,0},frame.size}];
        
        [self addSubview:self.yView];
        
        self.maxValue = 0;
        self.minValue = 0;
        
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)]];
        
    }
    return  self;
}

- (void)setKArray:(NSMutableArray *)kArray
{
    _kArray = kArray;
    NSLog(@"开始%f",[[NSDate date] timeIntervalSince1970]);
    //看可以画出多少个数据
    NSInteger count = self.frame.size.width/(kKLineWidth + kKLineGapWidth);
    
    [self resetPropertyByKArray:[NSMutableArray arrayWithArray:[kArray subarrayWithRange:NSMakeRange(0, count)]]];
    
    //设置scrollView的contentSize
    _scrollView.contentSize = CGSizeMake(kArray.count * kKLineWidth + (kArray.count - 1) * kKLineGapWidth + 20, 0);

    //画X轴
    self.xView.frame = CGRectMake(0, 0,  _scrollView.contentSize.width, _scrollView.frame.size.height);
    self.xView.XArray = self.kArray;
    [self.xView draw];
    
    //画Y轴
    self.yView.YRow = 5;
    [self.yView drawViewWithMax:self.maxValue Min:self.minValue];
    
    //画K图
    self.kView.drawModels = [NSMutableArray arrayWithArray:[kArray subarrayWithRange:NSMakeRange(0, count)]];
    [self.kView resetDrawViewOfMax:self.maxValue Min:self.minValue];
    
    NSLog(@"结束%f",[[NSDate date] timeIntervalSince1970]);
    
}

//Y轴的View挡住了ScrollView的触发事件  做了响应事件转移
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *result = [super hitTest:point withEvent:event];
    
    CGPoint buttonPoint = [self.yView convertPoint:point fromView:self];
    
    if ([self.yView pointInside:buttonPoint withEvent:event]) {
        
        return self.scrollView;
    }
    return result;
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, UIColorFromRGB(0x20222e, 1.0).CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    
    
    //画十字线
    if (!CGPointEqualToPoint(self.focusPoint, CGPointZero)) {
        
        //画横线
        CGContextSetLineWidth(context, StockLineUnitWidth);
        CGContextSetStrokeColorWithColor(context, StockLineUnitColor.CGColor);
        CGContextMoveToPoint(context, 0, self.focusPoint.y);
        CGContextAddLineToPoint(context, self.frame.size.width, self.focusPoint.y);
        CGContextStrokePath(context);
        
        //画竖线
        CGContextMoveToPoint(context,  self.focusPoint.x, 0);
        CGContextAddLineToPoint(context,self.focusPoint.x,self.frame.size.height);
        CGContextStrokePath(context);
        
    }
    
    [super drawRect:rect];
    
}

- (void)resetPropertyByKArray:(NSMutableArray *)karray
{
    CGFloat maxValue = [[[karray firstObject] c] floatValue];
    CGFloat minValue = [[[karray firstObject] c] floatValue];
    
    for (ColumnarLineDataModel *positon in karray) {
        if (maxValue < [positon.c floatValue])maxValue = [positon.c floatValue];
        if (minValue > [positon.c floatValue])minValue = [positon.c floatValue];
    }
    
    self.minValue = minValue - kKLineTopBottomGap;
    self.maxValue = maxValue + kKLineTopBottomGap - 100;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == &ContentOffsetFlag) {
        
        CGRect oldF = self.kViewF;
        oldF.origin.x += self.scrollView.contentOffset.x > 0 ? self.scrollView.contentOffset.x : 0;
        self.kView.frame = oldF;
        
        NSInteger count = self.frame.size.width/(kKLineWidth + kKLineGapWidth);
        
        NSInteger leftCount = self.scrollView.contentOffset.x/(kKLineWidth + kKLineGapWidth);
        NSMutableArray *showArray = [NSMutableArray array];
        
        if (leftCount <= -1) {
            
            return ;
        }else{
            
            if (leftCount >= self.kArray.count - 1) {
                return ;
            }
            
            if (leftCount >= self.kArray.count - count) {
                
                showArray = [NSMutableArray arrayWithArray:[self.kArray subarrayWithRange:NSMakeRange(leftCount, self.kArray.count - leftCount - 1)]];
                
            }else{
                
                showArray = [NSMutableArray arrayWithArray:[self.kArray subarrayWithRange:NSMakeRange(leftCount, count)]];
                
            }
            
            //重绘Y值轴
            [self resetPropertyByKArray:showArray];
            [self.yView drawViewWithMax:self.maxValue Min:self.minValue];
            
            //重绘K
            self.kView.drawModels = showArray;
            [self.kView resetDrawViewOfMax:self.maxValue Min:self.minValue];
            
        }
        
    }
}

- (void)hideFocusLine
{
    if (!CGPointEqualToPoint(self.focusPoint, CGPointZero)) {
        self.focusPoint = CGPointZero;
        [self setNeedsDisplay];
    }
}

- (void)longPressGesAction:(UIGestureRecognizer *)longGes
{
    NSLog(@"我长按了.....");
    
    CGPoint lpo = [longGes locationInView:self];
    
    NSLog(@"%@",NSStringFromCGPoint(lpo));
    
    switch (longGes.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            self.focusPoint = [self toObtainPreciseCoordinatesOf:lpo];
            self.panGes.enabled = NO;
            
            break;
        case UIGestureRecognizerStateEnded:
            self.focusPoint = [self toObtainPreciseCoordinatesOf:lpo];
            self.panGes.enabled = YES;
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            self.focusPoint = CGPointZero;
            break;
        default:
            break;
    }
    
    
    [self setNeedsDisplay];
    
}
//获取精确坐标
- (CGPoint)toObtainPreciseCoordinatesOf:(CGPoint)eventPoint
{
    //倒叙遍历 效率高
    __block NSUInteger index = 0;
    [self.kViewArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj kstartPoint].x < eventPoint.x) {
             index = idx;
            
             *stop = YES;
           }
    }];
    
    CGFloat xPosition = 0;
    CGFloat yPosition = 0;
    
    yPosition = eventPoint.y;
    
    if (index < self.kViewArray.count - 1) {
        
        if (ABS(eventPoint.x - [self.kViewArray[index] kstartPoint].x) >= ABS(eventPoint.x - [self.kViewArray[index + 1] kstartPoint].x)) {
            
            StockKLineModel *model = self.kViewArray[index + 1];
            xPosition = model.kstartPoint.x;
            
        }else{
            
            StockKLineModel *model = self.kViewArray[index];
            xPosition = model.kstartPoint.x;
        }
        
    }else{//最后一个
        
        StockKLineModel *model = [self.kViewArray lastObject];
        
        xPosition = model.kstartPoint.x;
        
    }
    return CGPointMake(xPosition, yPosition);
}

- (void)panGestureRecognizerAction:(UIGestureRecognizer *)ges
{
    NSLog(@"我拖动了");
    
    CGPoint lpo = [ges locationInView:self];
    self.focusPoint = [self toObtainPreciseCoordinatesOf:lpo];
    [self setNeedsDisplay];
}

- (void)tapGestureAction:(UIGestureRecognizer *)ges
{
    self.panGes.enabled = NO;
    [self hideFocusLine];
}

-(void)kLineWillDrawView:(NSArray *)drawArray
{
    self.kViewArray = drawArray;
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
