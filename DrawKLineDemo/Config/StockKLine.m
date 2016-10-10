//
//  StockKLine.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StockKLine.h"

@implementation StockKLineModel



@end

@interface StockKLine ()

@property (nonatomic , assign)CGContextRef context;
@end

@implementation StockKLine

//开盘价>收盘价   显示绿色 否则红色
//最高价 -> 最低价  这是中间那条线的长度  颜色和上面颜色一样

- (instancetype)initWithContext:(CGContextRef)context
{
    if (self = [super init]) {
        self.context = context;
    }
    return self;
}

- (void)draw
{
    CGContextRef context = self.context;
    
    ////画中间的开收盘线
    for (StockKLineModel *positionModel in self.positionModels) {
        
         CGContextSetStrokeColorWithColor(self.context, positionModel.color.CGColor);
        CGContextSetLineWidth(self.context, kKLineWidth);
        
        //画实体线
        const CGPoint solidPoints[] = {positionModel.kstartPoint,positionModel.kendPoint};
        CGContextStrokeLineSegments(context, solidPoints, 2);
        
        //画影线图
        CGContextSetLineWidth(context, kKShodowWidth);
        const CGPoint shadowPoints[] = {positionModel.shadowStartPoint,positionModel.shadowEndPoint};
        CGContextStrokeLineSegments(context, shadowPoints, 2);
        
    }
    
}

@end
