//
//  ColumnarView.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/22.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "ColumnarView.h"
#import "ColumnarLineDataModel.h"
#import "StockColumnarLine.h"

@interface ColumnarView ()

@property (nonatomic ,strong)NSArray *positionArray;

@end

@implementation ColumnarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    StockColumnarLine *col = [[StockColumnarLine alloc] initWithContext:context];
    col.positionModels = self.positionArray;
    [col draw];
}


-(void)resetDrawView
{
    //把元数据 换算成XY值
    self.positionArray = [self private_convertColumnarLineModlesToPositionModel];
    
    [self setNeedsDisplay];
}


/**
 *  将self.timeModel 变成{0,0} {0,1}形式
 *  固定宽度 整宽
 */
- (NSArray *)private_convertColumnarLineModlesToPositionModel
{
    
    NSAssert(self.drawModels, @"drawModels不能为空!");
    
    [self.drawModels sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [[(ColumnarLineDataModel *)obj1 t] compare:[(ColumnarLineDataModel *)obj2 t]];
        
    }];
    
    //获取Y最高值和最小值
    CGFloat maxYPrice = [[[self.drawModels firstObject] c] floatValue];
    CGFloat minYPrice = [[[self.drawModels firstObject] c] floatValue];
    
    for (ColumnarLineDataModel *positon in self.drawModels) {
        if (maxYPrice < [positon.c floatValue])maxYPrice = [positon.c floatValue];
        if (minYPrice > [positon.c floatValue])minYPrice = [positon.c floatValue];
    }
    
    
    CGFloat drawViewHeight = self.frame.size.height;
    //Y值单位元
    // 想要的是吧高度按价差平分  得到一个单位的钱占多少高度
    CGFloat Yunit = drawViewHeight/(maxYPrice - minYPrice);
    
    // 2.算出x轴的单元值
    // 因为X周是时间戳
    CGFloat Xunit = kColumnarGapValue + kColumnarLineWidth;//一个单位占多宽
    
    //转换成posisiton的模型，
    NSMutableArray *positionArray = [NSMutableArray array];
    
    for (int i = 0; i<self.drawModels.count; i++) {

        ColumnarLineDataModel *model = self.drawModels[i];
        StockColumnarModel *positionModel = [StockColumnarModel new];
        
        CGFloat X = i * Xunit + kColumnarLineWidth/2;
        CGFloat Y = self.frame.size.height - (([model.c floatValue] - minYPrice) * Yunit);
        
        positionModel.startPoint = CGPointMake(X, self.frame.size.height);
        positionModel.endPoint = CGPointMake(X,Y);

        [positionArray addObject:positionModel];
    }

    return positionArray;
}


@end
