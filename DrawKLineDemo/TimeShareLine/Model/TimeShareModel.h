//
//  TimeShareModel.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject

@property (nonatomic ,strong)NSString *t;//时间戳
@property (nonatomic ,strong)NSString *p;//价格

@end

@interface TimeShareModel : NSObject

/** TimeModel*/
@property (nonatomic ,strong)NSMutableArray *list;

@end
