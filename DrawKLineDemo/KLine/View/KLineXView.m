//
//  KLineXView.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/26.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "KLineXView.h"
#import "ColumnarLineDataModel.h"

@implementation KLineXView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.type = KLineGapTypeNone;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    
    CGContextSetLineWidth(context, StockLineUnitWidth);
    
    NSAssert(self.type != KLineGapTypeNone, @"线类型不能为空");
    
    //获取X值的坐标值
    NSArray *XValues = [self getXTitle];
    
    //画垂直线
    CGFloat x = kKLineWidth/2;
    int index = 0;
    while (rect.size.width >= x && index < XValues.count) {
        
        CGContextSetStrokeColorWithColor(context, StockLineUnitColor.CGColor);

        CGContextMoveToPoint(context, x, 0);
        CGContextAddLineToPoint(context, x, self.frame.size.height);
        CGContextStrokePath(context);
        
        if (index == 0) {
            
            [self drawTitleWithTitle:XValues[index] Point:CGPointMake(x, self.frame.size.height - 14) Font:14 Color:ColumnarLineGreenColor];
            
            
        }else if (index == XValues.count - 1){
            
            if (rect.size.width - x >= 50) {
                [self drawTitleWithTitle:XValues[index] Point:CGPointMake(x - [self getWidth:XValues[index] Font:14]/2, self.frame.size.height - 14) Font:14 Color:ColumnarLineGreenColor];
            }else{
            
            [self drawTitleWithTitle:XValues[index] Point:CGPointMake(x - [self getWidth:XValues[index] Font:14], self.frame.size.height - 14) Font:14 Color:ColumnarLineGreenColor];
            }
            
        }else{
            
            [self drawTitleWithTitle:XValues[index] Point:CGPointMake(x - [self getWidth:XValues[index] Font:14]/2, self.frame.size.height - 14) Font:14 Color:ColumnarLineGreenColor];
        }
        
        x += (self.type) * (kKLineWidth + kKLineGapWidth);
        
        index ++;
    }
    
    [super drawRect:rect];
    
}

- (void)draw
{
    [self setNeedsDisplay];
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

- (NSArray *)getXTitle
{
    NSMutableArray *temp = [NSMutableArray array];
    int i = 0;
    while (i < self.XArray.count) {
        
        [temp addObject:[self.XArray[i] t]];
        
        i += self.type;
    }
    return temp;
}


@end
