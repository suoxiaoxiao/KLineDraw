//
//  KLineXView.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/26.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLineXView : UIView

@property (nonatomic ,strong)NSMutableArray *XArray;

@property (nonatomic , assign)KLineGapType type;

- (void)draw;

@end
