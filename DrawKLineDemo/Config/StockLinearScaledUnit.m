//
//  StockLinearScaledUnit.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/21.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StockLinearScaledUnit.h"


@interface StockLinearScaledUnit ()

@property (nonatomic , assign)CGContextRef content;
@property (nonatomic , assign)CGSize size;

@end

@implementation StockLinearScaledUnit


-(instancetype)initWithContext:(CGContextRef)context withSize:(CGSize)size
{
    if (self = [super init]) {
        self.content = context;
        self.size = size;
    }
    return self;
}

-(void)draw
{
    //画水平线
    CGFloat HW = self.size.height/(self.HRow - 1);
    CGContextSetStrokeColorWithColor(self.content, StockLineUnitColor.CGColor);
    CGContextStrokeRect(self.content, CGRectMake(0, StockLineUnitWidth, self.size.width, self.size.height - StockLineUnitWidth * 2));
    CGContextSetLineWidth(self.content, StockLineUnitWidth);
    
    for (int i = 1; i < self.HRow - 1; i++) {
        
        CGContextMoveToPoint(self.content, 0, i * HW);
        CGContextAddLineToPoint(self.content, self.size.width, i * HW);
        CGContextStrokePath(self.content);
    }

    //画垂直线
    CGFloat VH = self.size.width/(self.Vrow - 1);
    CGContextSetStrokeColorWithColor(self.content, StockLineUnitColor.CGColor);
    CGContextSetLineWidth(self.content, StockLineUnitWidth);
    
    for (int i = 1; i < self.Vrow - 1; i++) {
        
        CGContextMoveToPoint(self.content, i * VH , 0);
        CGContextAddLineToPoint(self.content, i * VH, self.size.height);
        CGContextStrokePath(self.content);
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(stockLinearFromMinTOMaxXShowText:)]) {
        
        //绘制X轴显示
        NSArray *XTextArray = [self.dataSource stockLinearFromMinTOMaxXShowText:self];
        
        NSAssert(XTextArray, @"X轴显示数据不能为空");
        
        for (int i = 0; i < XTextArray.count; i++) {
            
            if (i == 0) {
                
                [self drawTitleWithTitle:XTextArray[i] Point:CGPointMake(0, self.size.height - 14) Font:14 Color:StockLineUnitColor];
                
//                drawTitle(XTextArray[i], CGPointMake(0, self.size.height - 14), 14, StockLineUnitColor);
                continue;
            }
            if (i == XTextArray.count - 1) {
                
                [self drawTitleWithTitle:XTextArray[i] Point:CGPointMake(i * VH - [self getWidth:XTextArray[i] Font:14], self.size.height - 14) Font:14 Color:StockLineUnitColor];
                
//                 [self drawTitleWithTitle:XTextArray[i] Point:CGPointMake(i * VH - getWidth(XTextArray[i], 14) Font:14 Color:StockLineUnitColor];
                
//                drawTitle(XTextArray[i], CGPointMake(i * VH - getWidth(XTextArray[i], 14), self.size.height - 14), 14, StockLineUnitColor);
                continue;
            }
            [self drawTitleWithTitle:XTextArray[i] Point:CGPointMake(i * VH - [self getWidth:XTextArray[i] Font:14]/2, self.size.height - 14) Font:14 Color:StockLineUnitColor];
                                                                          
//            drawTitle(XTextArray[i], CGPointMake(i * VH - getWidth(XTextArray[i], 14)/2, self.size.height - 14), 14, StockLineUnitColor);
                                                                          
        }
        
        
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(stockLinearFromMaxTOMinYShowText:)]) {
        
        //绘制Y轴显示
        //绘制X轴显示
        NSArray *YTextArray = [self.dataSource stockLinearFromMaxTOMinYShowText:self];
        
        NSAssert(YTextArray, @"Y轴显示数据不能为空");
        
        for (int i = 0; i < YTextArray.count; i++) {
            
            if (i == YTextArray.count - 1) {
                
//                drawTitle(YTextArray[i], CGPointMake(0, i * HW - 28), 14, StockLineUnitColor);
                [self drawTitleWithTitle:YTextArray[i] Point:CGPointMake(0, i * HW - 28) Font:14 Color:StockLineUnitColor];
                break;
            }
            
            [self drawTitleWithTitle:YTextArray[i] Point:CGPointMake(0, i * HW) Font:14 Color:StockLineUnitColor];
            
//            drawTitle(YTextArray[i], CGPointMake(0, i * HW), 14, StockLineUnitColor);
        }
        
    }
    
}

/**
 * 绘制Title
 */

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
                                                                          
//CGFloat getWidth(NSString *string,CGFloat font){
//    
//    return [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size.width;
//}


@end
