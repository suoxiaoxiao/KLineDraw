//
//  StockBrokenLine.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StockBrokenLine.h"

@implementation BrokenLinePositionModel

@end



@interface StockBrokenLine()

@property(nonatomic,assign) CGContextRef context;

@end

@implementation StockBrokenLine

-(instancetype)initWithContext:(CGContextRef)context
{
    if (self = [super init]) {
        
        self.context = context;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSAssert(self.context && self.positionModels, @"context或者positionModel不能为空!");
    NSInteger count = self.positionModels.count;
    NSArray *positionModels = self.positionModels;
    CGContextSetLineWidth(self.context, TimeLineWidth);
    
    CGContextSetStrokeColorWithColor(self.context, TimeLineColor.CGColor);
    
    
//    BrokenLinePositionModel *positionModel = (BrokenLinePositionModel *)positionModels[0];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, 0, rect.size.height);
    
    
    for (NSInteger index = 0; index < count; index++) {
        
        BrokenLinePositionModel *positionModel = (BrokenLinePositionModel *)positionModels[index];
        
        if (isnan(positionModel.currentPoint.x) || isnan(positionModel.currentPoint.y)) {
            continue;
        }
        NSAssert(!isnan(positionModel.currentPoint.x) && !isnan(positionModel.currentPoint.y) && !isinf(positionModel.currentPoint.x) && !isinf(positionModel.currentPoint.y), @"不符合要求的点！");
        
        CGContextMoveToPoint(self.context, positionModel.currentPoint.x, positionModel.currentPoint.y);
        
        CGPathAddLineToPoint(path, &CGAffineTransformIdentity, positionModel.currentPoint.x, positionModel.currentPoint.y);
        
        if (index+1 < count) {
            BrokenLinePositionModel *nextPositionModel = (BrokenLinePositionModel *)positionModels[index+1];
            CGContextAddLineToPoint(self.context, nextPositionModel.currentPoint.x, nextPositionModel.currentPoint.y);
            
            CGPathAddLineToPoint(path, &CGAffineTransformIdentity, nextPositionModel.currentPoint.x, nextPositionModel.currentPoint.y);
        }else{
            
            CGPathAddLineToPoint(path, &CGAffineTransformIdentity, positionModel.currentPoint.x, rect.size.height);
            
        }
        
        CGContextStrokePath(self.context);
    }
    //        画阴影
    CGContextSetFillColorWithColor(self.context, TimeShodowColor.CGColor);
    CGContextAddPath(self.context, path);
    CGContextDrawPath(self.context, kCGPathFill);
    CGPathRelease(path);
}


@end
