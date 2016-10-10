//
//  PublicConfig.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/19.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, StockLineType){
    StockLineTypeKLine = 1,    //K线
    StockLineTypeBrokenLine,     //折线图
    StockLineTypeColumnarLine,     //柱状图
};

typedef NS_ENUM(NSUInteger, StockTimeType){
    StockTimeTypeUSA = 240,             //美股 //（9：30-11：30，13：00-15：00）
    StockTimeTypeA = 390,               //A股 //（9：30-16：00）
    StockTimeTypeHK = 240,              //港股
    StockTimeType8S = 1320,                //8元控股 06:00 ~ 次日04:00
};

typedef NS_ENUM(NSUInteger, ColumnarLineGapType){
    ColumnarLineGapTypeNone = 0,
    ColumnarLineGapTypeOneMin = 20, //一分K
    ColumnarLineGapTypeFiveMin = 20,//5分K
    ColumnarLineGapTypeTenMin = 20, //15分K
};

typedef NS_ENUM(NSUInteger, KLineGapType){
    KLineGapTypeNone = 0,
    KLineGapTypeOneMin = 20, //一分K
    KLineGapTypeFiveMin = 20,//5分K
    KLineGapTypeTenMin = 20, //15分K
    KLineGapTypeDay = 20, //day
};



#define UIColorFromRGB(rgbValue,alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]


static const NSInteger kTimeLineTopBottomGap = 10;
#pragma mark 分时线界面线的颜色
#define TimeLineColor UIColorFromRGB(0x365ad8,1.0)
#define TimeLineWidth (2)
#define TimeShodowColor UIColorFromRGB(0x242b4b,1.0)


#define StockLineUnitColor UIColorFromRGB(0xacbcdc,1.0)
#define StockLineUnitWidth (0.5)

#define kColumnarLineWidth (5)
#define kColumnarGapValue (1)
#define ColumnarLineRedColor UIColorFromRGB(0xdb243d,1.0)
#define ColumnarLineGreenColor UIColorFromRGB(0x15b529,1.0)

#define kKLineWidth (10)
#define kKShodowWidth (1)
#define kKLineGapWidth (1)
#define KLineRedColor UIColorFromRGB(0xdb243d,1.0)
#define KLineGreenColor UIColorFromRGB(0x15b529,1.0)
static const NSInteger kKLineTopBottomGap = 200;


#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width


@interface PublicConfig : NSObject
@end
