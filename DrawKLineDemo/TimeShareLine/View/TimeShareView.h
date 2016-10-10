//
//  TimeShareView.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeShareModel.h"
#import "StockInfoModel.h"

@interface TimeShareView : UIView

/** X-Y*/
@property (nonatomic ,strong)TimeShareModel *timeModel;
/** 股票信息*/
@property (nonatomic ,strong)StockInfoModel *infoModel;


@end
