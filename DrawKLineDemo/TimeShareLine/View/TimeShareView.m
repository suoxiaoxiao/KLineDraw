//
//  TimeShareView.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "TimeShareView.h"
#import "StockBrokenLine.h"
#import "StockPositionModel.h"
#import "StockLinearScaledUnit.h"

@interface TimeShareView () <StockLinearScaledUnitDataSource>

@property (nonatomic , assign)CGFloat minY;
@property (nonatomic , assign)CGFloat maxY;

@end


@implementation TimeShareView

- (void)drawRect:(CGRect)rect {
   
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, UIColorFromRGB(0x20222e, 1.0).CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    
    //计算坐标系
    NSArray *posiArr = [self private_convertTimeLineModlesToPositionModel];
    
   
    
    //画图
    StockBrokenLine *timeLien = [[StockBrokenLine alloc] initWithContext:context];
    timeLien.positionModels = posiArr;
    [timeLien drawRect:rect];
    
    //画线
    StockLinearScaledUnit *lineUnit = [[StockLinearScaledUnit alloc] initWithContext:context withSize:self.frame.size];
    lineUnit.HRow = 5;
    lineUnit.Vrow = 5;
    lineUnit.dataSource = self;
    [lineUnit draw];
    
    [super drawRect:rect];
}

/**
 *  将self.timeModel 变成{0,0} {0,1}形式
 *  固定宽度 整宽
 */
- (NSArray *)private_convertTimeLineModlesToPositionModel
{
    
    NSAssert(self.timeModel.list, @"timeLineModels不能为空!");
    
    [self.timeModel.list sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
       
        if ([(TimeModel *)obj1 t] >= [(TimeModel *)obj2 t]) {
            return NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
        
    }];
    
    //获取Y最高值和最小值
    CGFloat maxYPrice = [[[self.timeModel.list firstObject] p] floatValue];
    CGFloat minYPrice = [[[self.timeModel.list firstObject] p] floatValue];
    
    for (TimeModel *positon in self.timeModel.list) {
        if (maxYPrice < [positon.p floatValue])maxYPrice = [positon.p floatValue];
        if (minYPrice > [positon.p floatValue])minYPrice = [positon.p floatValue];
    }
    
    minYPrice -= 5.8 * kTimeLineTopBottomGap;
    maxYPrice += kTimeLineTopBottomGap/2;
    self.minY = minYPrice;
    self.maxY = maxYPrice;
    
    CGFloat drawViewHeight = self.frame.size.height;
    //Y值单位元
    // 想要的是吧高度按价差平分  得到一个单位的钱占多少高度
    CGFloat Yunit = drawViewHeight/(maxYPrice - minYPrice);
    
    // 2.算出x轴的单元值
    // 因为X周是时间戳  整个分时图的时间长度是一定的 各种股的时间段是不一样的! 所以采取枚举
    CGFloat Xunit = self.frame.size.width/StockTimeType8S;//一分钟占多宽
//    06:00 ~ 04:00
    
//     NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[[self.timeModel.list objectAtIndex:1] t] integerValue]/1000];
    //早上六点开始 1分间距时间
    
    //转换成posisiton的模型，
    NSMutableArray *positionArray = [NSMutableArray array];
    
    
    for (int i = 0; i<self.timeModel.list.count; i++) {
        
        
        TimeModel *model = self.timeModel.list[i];
        StockPositionModel *positionModel = [StockPositionModel new];
        
        positionModel.X = i * Xunit;
        
        positionModel.Y =  self.frame.size.height - ([model.p floatValue] - minYPrice) * Yunit;
        NSLog(@"X=%f  Y=%f",positionModel.X,positionModel.Y);
//        [positionArray addObject:positionModel];
        BrokenLinePositionModel *lineModel = [[BrokenLinePositionModel alloc] init];
        
        lineModel.currentPoint = CGPointMake(positionModel.X, positionModel.Y);
        
        [positionArray addObject:lineModel];
        
    }
    
    return positionArray;
}

#pragma mark - StockLinearScaledUnitDataSource

- (NSArray *)stockLinearFromMinTOMaxXShowText:(StockLinearScaledUnit *)linear
{
    return @[@"06:00",@"12:00",@"18:00",@"23:00",@"04:00"];
}
- (NSArray *)stockLinearFromMaxTOMinYShowText:(StockLinearScaledUnit *)linear
{
    
    CGFloat unit = (self.maxY - self.minY)/linear.HRow;
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (int i = 0; i < linear.HRow - 1; i++) {
        
        [temp addObject:[NSString stringWithFormat:@"%.02f",self.maxY - i * unit]];
    }
    [temp addObject:[NSString stringWithFormat:@"%.02f",self.minY]];
    
    return temp;
}

@end
