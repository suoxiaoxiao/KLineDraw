//
//  KLine.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/26.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KlineProtocol <NSObject>
@optional
- (void)kLineWillDrawView:(NSArray *)drawArray;

@end


@interface KLine : UIView

@property (nonatomic , weak)id <KlineProtocol> delegate;

/**
 * 需要绘制的数据
 */
@property (nonatomic ,strong)NSMutableArray *drawModels;

/**
 *  绘制
 */
-(void)resetDrawViewOfMax:(CGFloat)maxValue Min:(CGFloat)minValue;

@end
