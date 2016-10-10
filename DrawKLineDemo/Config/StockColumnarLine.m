//
//  StockColumnarLine.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StockColumnarLine.h"


@implementation StockColumnarModel


@end


@interface StockColumnarLine ()

@property (nonatomic , assign)CGContextRef context;

@end


@implementation StockColumnarLine

- (instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if (self) {
        self.context = context;
        
    }
    return self;
}

- (void)draw
{
    CGContextRef context = self.context;
    CGContextSetStrokeColorWithColor(self.context, ColumnarLineRedColor.CGColor);
    
    CGContextSetLineWidth(self.context, kColumnarLineWidth);
    for (StockColumnarModel *positionModel in self.positionModels) {
        //画实体线
        
        const CGPoint solidPoints[] = {positionModel.startPoint,positionModel.endPoint};
        CGContextStrokeLineSegments(context, solidPoints, 2);
    }
    
    
}

@end
