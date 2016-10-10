//
//  ColumnarYValueAxle.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/24.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "ColumnarYValueAxle.h"
#import "ColumnarLineDataModel.h"

@implementation ColumnarYValueAxle


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)draw
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    //Y线
    //获取Y值的坐标值
        NSArray *YValues = [self getYValue];
    
        CGFloat VH = self.frame.size.height/(3 - 1);
    
        for (int i = 0; i < 3; i++) {
    
            
            CGContextSetStrokeColorWithColor(context, StockLineUnitColor.CGColor);
            CGContextSetLineWidth(context, StockLineUnitWidth);
            
            if (i == 0) {
    
                CGContextMoveToPoint(context, 0, VH * i + StockLineUnitWidth);
                CGContextAddLineToPoint(context, self.frame.size.width, VH * i + StockLineUnitWidth);
                CGContextStrokePath(context);
    
                [self drawTitleWithTitle:YValues[i] Point:CGPointMake(0, VH * i) Font:14 Color:ColumnarLineGreenColor];
    
                continue;
            }
    
            if (i == 3 - 1) {
    
                CGContextMoveToPoint(context, 0, VH * i - StockLineUnitWidth);
                CGContextAddLineToPoint(context, self.frame.size.width , VH * i - StockLineUnitWidth);
                CGContextStrokePath(context);
    
                [self drawTitleWithTitle:YValues[i] Point:CGPointMake(0, VH * i - 28) Font:14 Color:ColumnarLineGreenColor];
                continue;
            }
    
            CGContextMoveToPoint(context, 0, VH * i);
            CGContextAddLineToPoint(context, self.frame.size.width, VH * i);
            CGContextStrokePath(context);
    
               [self drawTitleWithTitle:YValues[i] Point:CGPointMake(0, VH * i) Font:14 Color:ColumnarLineGreenColor];
        }
    [super drawRect:rect];
    
    
}

- (NSArray *)getYValue
{
    
    //获取Y最高值和最小值
    CGFloat maxYPrice = [[[self.showModels firstObject] c] floatValue];
    CGFloat minYPrice = [[[self.showModels firstObject] c] floatValue];
    
    for (ColumnarLineDataModel *positon in self.showModels) {
        if (maxYPrice < [positon.c floatValue])maxYPrice = [positon.c floatValue];
        if (minYPrice > [positon.c floatValue])minYPrice = [positon.c floatValue];
    }
    
    CGFloat Yunit = (maxYPrice - minYPrice)/3;
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        
        if (i == 3 -1) {
            [temp addObject:[NSString stringWithFormat:@"%f",minYPrice]];
            continue;
        }
        
        [temp addObject:[NSString stringWithFormat:@"%f",(maxYPrice - i * Yunit <= minYPrice)? minYPrice:(maxYPrice - i * Yunit)]];
    }
    
    return temp;
}


- (void)drawTitleWithTitle:(NSString *)title Point:(CGPoint)point Font:(CGFloat)font  Color:(UIColor *)color
{
    [title drawAtPoint:point withAttributes:@{
                                              NSFontAttributeName : [UIFont systemFontOfSize:font],
                                              NSForegroundColorAttributeName : color
                                              }];
}

- (CGFloat)getWidth:(NSString *)string Font:(CGFloat) font{
    
    return [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size.width;
}

@end
