//
//  KLineYView.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/26.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "KLineYView.h"

@interface KLineYView ()

@property (nonatomic , assign)CGFloat maxValue;

@property (nonatomic , assign)CGFloat minValue;

@end


@implementation KLineYView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawViewWithMax:(CGFloat)max Min:(CGFloat)min
{
    self.minValue = min;
    self.maxValue = max;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    NSMutableArray *YValues = [self getValues];
    
    CGFloat VH = self.frame.size.height/(self.YRow - 1);
    
    for (int i = 0; i < self.YRow; i++) {
        
        CGContextSetStrokeColorWithColor(context, StockLineUnitColor.CGColor);
        CGContextSetLineWidth(context, StockLineUnitWidth);
        
        if (i == 0) {
            
            CGContextMoveToPoint(context, 0, VH * i + StockLineUnitWidth);
            CGContextAddLineToPoint(context, self.frame.size.width, VH * i + StockLineUnitWidth);
            CGContextStrokePath(context);
            
            [self drawTitleWithTitle:YValues[i] Point:CGPointMake(0, VH * i) Font:14 Color:ColumnarLineGreenColor];
            
            continue;
        }
        
        if (i == self.YRow - 1) {
            
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

- (NSMutableArray *)getValues
{
    CGFloat Yunit = (self.maxValue - self.minValue)/self.YRow;
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (int i = 0; i < self.YRow; i++) {
        
        if (i == self.YRow -1) {
            [temp addObject:[NSString stringWithFormat:@"%f",self.minValue]];
            continue;
        }
        
        [temp addObject:[NSString stringWithFormat:@"%f",(self.maxValue - i * Yunit <= self.minValue)? self.minValue:(self.maxValue - i * Yunit)]];
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
