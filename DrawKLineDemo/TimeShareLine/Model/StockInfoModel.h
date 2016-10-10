//
//  StockInfoModel.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockInfoModel : NSObject

@property (nonatomic ,strong)NSString *mp;
@property (nonatomic ,strong)NSString *updatetime;//当前跟新时间
@property (nonatomic ,strong)NSString *last_close;//昨日收盘
@property (nonatomic ,strong)NSString *buy; //当前购买价格
@property (nonatomic ,strong)NSString *code;
@property (nonatomic ,strong)NSString *open;//开盘
@property (nonatomic ,strong)NSString *time;//当前跟新时间
@property (nonatomic ,strong)NSString *sell;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *low;//最低
@property (nonatomic ,strong)NSString *top;//最高
@property (nonatomic ,strong)NSString *isClosed;//是否闭盘
@property (nonatomic ,strong)NSString *margin;

@end
