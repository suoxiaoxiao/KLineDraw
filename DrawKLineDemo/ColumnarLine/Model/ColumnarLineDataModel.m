//
//  ColumnarLineDataModel.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/22.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "ColumnarLineDataModel.h"

@implementation ColumnarLineDataModel

- (instancetype)init
{
    if (self = [super init]) {
        
        self.c = @"0";
        self.o = @"0";
        self.h = @"0";
        self.l = @"0";
        self.t = @"";
        self.v = @"0";
    }
    return self;
}

@end
