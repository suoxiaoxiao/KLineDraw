//
//  KLine.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/26.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "KLine.h"
#import "ColumnarLineDataModel.h"
#import "StockKLine.h"

@interface KLine ()

@property (nonatomic , assign)CGFloat maxValue;

@property (nonatomic , assign)CGFloat minValue;

@property (nonatomic ,strong)NSArray *positionArray;

@end

@implementation KLine

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)resetDrawViewOfMax:(CGFloat)maxValue Min:(CGFloat)minValue
{
    self.maxValue = maxValue;
    self.minValue = minValue;
    
    self.positionArray = [self private_convertKLineModlesToPositionModel];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(kLineWillDrawView:)]) {
        [self.delegate kLineWillDrawView:self.positionArray];
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    StockKLine *kk = [[StockKLine alloc] initWithContext:context];
    kk.positionModels = self.positionArray;
    [kk draw];
    
}

- (NSArray *)private_convertKLineModlesToPositionModel
{
    NSAssert(self.drawModels, @"drawModels不能为空!");
    
    [self.drawModels sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [[(ColumnarLineDataModel *)obj1 t] compare:[(ColumnarLineDataModel *)obj2 t]];
        
    }];
    
    CGFloat max = self.maxValue;
    CGFloat min = self.minValue;
    
    //Y值单位元
    CGFloat yUnit = self.frame.size.height/(max - min);
    
    // 2.算出x轴的单元值
    // 因为X周是时间戳
    CGFloat Xunit = kKLineGapWidth + kKLineWidth;//一个单位占多宽
    
    //转换成posisiton的模型，
    NSMutableArray *positionArray = [NSMutableArray array];
    
    for (int i = 0; i<self.drawModels.count; i++) {
        
        ColumnarLineDataModel *model = self.drawModels[i];
        
        StockKLineModel *positionModel = [StockKLineModel new];
        
        CGFloat xPosition = i * Xunit + kKLineWidth/2;
        
        positionModel.kstartPoint = CGPointMake(xPosition, self.frame.size.height - (ABS([model.o floatValue] - min)) * yUnit);
        positionModel.kendPoint = CGPointMake(xPosition ,self.frame.size.height - (ABS([model.c floatValue] - min)) * yUnit);
        positionModel.shadowEndPoint = CGPointMake(xPosition,self.frame.size.height - (ABS([model.l floatValue] - min)) * yUnit);
        positionModel.shadowStartPoint = CGPointMake(xPosition,self.frame.size.height - (ABS([model.h floatValue] - min)) * yUnit);
        
        if ([model.c floatValue] > [model.o floatValue]) {
            positionModel.color = KLineRedColor;
        }else
            positionModel.color = KLineGreenColor;
        
        [positionArray addObject:positionModel];
    }
    
    
    
    return positionArray;
    
}

@end
