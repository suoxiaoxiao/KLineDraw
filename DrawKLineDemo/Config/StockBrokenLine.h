//
//  StockBrokenLine.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//



#import <UIKit/UIKit.h>

/************************折线图上面的view的位置模型************************/
@interface BrokenLinePositionModel : NSObject

@property(nonatomic,assign) CGPoint currentPoint;

@end



@interface StockBrokenLine : NSObject

@property(nonatomic,strong) NSArray *positionModels;

-(instancetype)initWithContext:(CGContextRef)context;

- (void)drawRect:(CGRect)rect;

@end
