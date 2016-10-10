//
//  ColumnarXYLine.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "ColumnarXYLine.h"

@interface ColumnarXYLine ()

@end

@implementation ColumnarXYLine

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.type = ColumnarLineGapTypeNone;
        
    }
    return self;
}

- (void)draw
{
    //画X线
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
//    CGContextSetStrokeColorWithColor(context, StockLineUnitColor.CGColor);
//    CGContextSetLineWidth(context, StockLineUnitWidth);
    
    NSAssert(self.type != ColumnarLineGapTypeNone, @"线类型不能为空");
    
    
    //获取X值的坐标值
    NSArray *XValues = [self getXTitle];
    
    //画垂直线
    CGFloat x = 0;
    int index = 0;
    while (rect.size.width >= x) {
        
        CGContextSetStrokeColorWithColor(context, StockLineUnitColor.CGColor);
        CGContextSetLineWidth(context, StockLineUnitWidth);
        
        CGContextMoveToPoint(context, x, 0);
        CGContextAddLineToPoint(context, x, self.frame.size.height);
        CGContextStrokePath(context);
        
        if (index == 0) {
            
            [self drawTitleWithTitle:XValues[index] Point:CGPointMake(x, self.frame.size.height - 14) Font:14 Color:ColumnarLineGreenColor];
     
            
        }else if (index == XValues.count - 1){
            
            [self drawTitleWithTitle:XValues[index] Point:CGPointMake(x - [self getWidth:XValues[index] Font:14], self.frame.size.height - 14) Font:14 Color:ColumnarLineGreenColor];
            
            
        }else{
            
            [self drawTitleWithTitle:XValues[index] Point:CGPointMake(x - [self getWidth:XValues[index] Font:14]/2, self.frame.size.height - 14) Font:14 Color:ColumnarLineGreenColor];
        }
        
        x += self.type * (kColumnarLineWidth + kColumnarGapValue) - kColumnarGapValue;
        index ++;
    }
    
    [super drawRect:rect];
}

- (NSArray *)getXTitle
{
    NSMutableArray *temp = [NSMutableArray array];
    int i = 0;
    while (i < self.columnarModel.count) {
        [temp addObject:[self.columnarModel[i] t]];
        
        i += self.type;
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
