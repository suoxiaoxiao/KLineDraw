//
//  StockColumnarLine.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StockColumnarModel : NSObject

@property (nonatomic , assign)CGPoint startPoint;

@property (nonatomic , assign)CGPoint endPoint;

@end

/*****************************柱状图******************************/
@interface StockColumnarLine : NSObject

@property(nonatomic,strong) NSArray *positionModels;

-(instancetype)initWithContext:(CGContextRef)context;

-(void)draw;

@end
