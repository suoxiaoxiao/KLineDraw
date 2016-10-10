//
//  ColumnarLineView.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/22.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "ColumnarLineView.h"
#import "ColumnarView.h"
#import "ColumnarXYLine.h"
#import "StockLinearScaledUnit.h"
#import "ColumnarYValueAxle.h"

static const char * ContentOffsetFlag;

@interface ColumnarLineView ()<UIScrollViewDelegate>

@property (nonatomic ,strong)NSMutableArray *showArray;

@property (nonatomic ,strong)UIScrollView *scrollView;

@property (nonatomic ,strong)ColumnarView *coluView;

@property (nonatomic ,strong)ColumnarXYLine *drawXLine;

@property (nonatomic ,strong)ColumnarYValueAxle *drawYAxle;

@property (nonatomic ,strong)StockLinearScaledUnit *drawYLine;

@property (nonatomic , assign)CGRect colF;

@end



@implementation ColumnarLineView

- (NSMutableArray *)showArray
{
    if (!_showArray) {
        _showArray = [NSMutableArray array];
    }
    return _showArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 1.0f;
        _scrollView.alwaysBounceHorizontal = YES;
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _scrollView.delegate = self;
         [self addSubview:_scrollView];
        _scrollView.frame = (CGRect){{0,0},frame.size};
        [self layoutIfNeeded];
        
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:&ContentOffsetFlag];
        
        //图
        self.coluView = [[ColumnarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, frame.size.height)];
        self.colF = self.coluView.frame;
        [self.scrollView addSubview:self.coluView];
        
        //画X值轴
        self.drawXLine = [[ColumnarXYLine alloc] init];
        self.drawXLine.type = ColumnarLineGapTypeOneMin;
        [self.scrollView addSubview:self.drawXLine];
        
        //画Y轴
        self.drawYAxle = [[ColumnarYValueAxle alloc] initWithFrame:(CGRect){{0,0},frame.size}];
        
        [self addSubview:self.drawYAxle];
        
        
    }
    return self;
}

//Y轴的View挡住了ScrollView的触发事件  做了响应事件转移
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *result = [super hitTest:point withEvent:event];
    
    CGPoint buttonPoint = [self.drawYAxle convertPoint:point fromView:self];
    
    if ([self.drawYAxle pointInside:buttonPoint withEvent:event]) {
        
        return self.scrollView;
    }
    return result;
}

- (void)setColumnarModel:(NSMutableArray *)columnarModel
{
    _columnarModel = columnarModel;
    
    //设置ScrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(columnarModel.count * kColumnarLineWidth + (columnarModel.count - 1) * kColumnarGapValue + 20, 0);
    
    //绘制
    //X线
    self.drawXLine.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.frame.size.height);
    
    self.drawXLine.columnarModel = columnarModel;
    
    [self.drawXLine draw];
    
    //看可以画出多少个数据
    NSInteger count = self.frame.size.width/(kColumnarLineWidth + kColumnarGapValue);
    //Y值轴
    self.drawYAxle.showModels = [NSMutableArray arrayWithArray:[columnarModel subarrayWithRange:NSMakeRange(0, count)]];
    [self.drawYAxle draw];
    
    
    //绘图
    self.coluView.drawModels = [NSMutableArray arrayWithArray:[columnarModel subarrayWithRange:NSMakeRange(0, count)]];
    
    [self.coluView resetDrawView];
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, UIColorFromRGB(0x1d2227, 1.0).CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    
    [super drawRect:rect];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"dd");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == &ContentOffsetFlag) {
        
        if (self.scrollView.contentOffset.x < 0) {
            
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            return ;
        }
        
        NSLog(@"%@",NSStringFromCGPoint(self.scrollView.contentOffset));
        
        CGRect oldF = self.colF;
        oldF.origin.x += self.scrollView.contentOffset.x;
        self.coluView.frame = oldF;
        
        NSInteger count = self.frame.size.width/(kColumnarLineWidth + kColumnarGapValue);
        
        NSInteger leftCount = self.scrollView.contentOffset.x/(kColumnarLineWidth + kColumnarGapValue);
        
        if (leftCount <= -1) {
            return ;
        }
//        NSLog(@"全部的数据数量%ld",self.columnarModel.count);
//        NSLog(@"数量 = %ld",count);
//        NSLog(@"从第%ld开始",leftCount);
        
        if (leftCount >= self.columnarModel.count - count) {
            
            self.showArray = [NSMutableArray arrayWithArray:[self.columnarModel subarrayWithRange:NSMakeRange(leftCount, self.columnarModel.count - leftCount - 1)]];
            
        }else{
            
            self.showArray = [NSMutableArray arrayWithArray:[self.columnarModel subarrayWithRange:NSMakeRange(leftCount, count)]];
            
        }
        //重绘Y值轴
        self.drawYAxle.showModels = self.showArray;
        [self.drawYAxle draw];
        //重绘柱状图
        self.coluView.drawModels = self.showArray;
        [self.coluView resetDrawView];
        
    }
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}


@end
