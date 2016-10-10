//
//  KLineYView.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/26.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLineYView : UIView

@property (nonatomic , assign)NSInteger YRow;

- (void)drawViewWithMax:(CGFloat)max Min:(CGFloat)min;

@end
