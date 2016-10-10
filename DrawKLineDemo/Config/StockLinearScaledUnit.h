//
//  StockLinearScaledUnit.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/21.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StockLinearScaledUnit;

@protocol StockLinearScaledUnitDataSource <NSObject>
@optional
- ( NSArray *  )stockLinearFromMinTOMaxXShowText:(StockLinearScaledUnit * )linear;
- ( NSArray *  )stockLinearFromMaxTOMinYShowText:(StockLinearScaledUnit * )linear;

@end




@interface StockLinearScaledUnit : NSObject

@property (nonatomic , weak) id<StockLinearScaledUnitDataSource> dataSource;

@property (nonatomic , assign)NSInteger Vrow;//垂直线数(包含边线)
@property (nonatomic , assign)NSInteger HRow;//水平线数(包含边线)

-(instancetype )initWithContext:(CGContextRef )context withSize:(CGSize)size;

-(void)draw;


@end
