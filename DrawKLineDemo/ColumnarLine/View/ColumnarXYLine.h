//
//  ColumnarXYLine.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnarLineDataModel.h"


@interface ColumnarXYLine : UIView


@property (nonatomic ,strong)NSMutableArray *columnarModel;

@property (nonatomic , assign)ColumnarLineGapType type;

- (void)draw;

@end
