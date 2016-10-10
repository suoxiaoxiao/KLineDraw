//
//  ColumnarView.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/22.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface ColumnarView : UIView

/**
 * 需要绘制的数据
 */
@property (nonatomic ,strong)NSMutableArray *drawModels;



/**
 *  绘制
 */
-(void)resetDrawView;

@end
