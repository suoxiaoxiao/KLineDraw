//
//  StockKLine.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockKLineModel : NSObject

@property (nonatomic , assign)CGPoint kstartPoint;

@property (nonatomic , assign)CGPoint kendPoint;

@property (nonatomic , assign)CGPoint shadowStartPoint;

@property (nonatomic , assign)CGPoint shadowEndPoint;

@property (nonatomic ,strong)UIColor *color;

@end

@interface StockKLine : NSObject

@property(nonatomic,strong) NSArray *positionModels;

-(instancetype)initWithContext:(CGContextRef)context;

-(void)draw;

@end
