//
//  DownLoadData.h
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoadData : NSObject


//分时图:  1474454901
#define DownLoad_OldTime_URL @"http://q.8caopan.com/wp/quotation/v2/tickChart?excode=HPME&code=OIL&sourceId=10&t=%ld&auth=252d4d8a8b62a6113bb154cd83c40a96"

//分时图跟新数据
#define DownLoad_UpdateTime_URL @"http://q.8caopan.com/wp/quotation/realTime?id=3"

//1分K线图
#define DownLoad_OneK_URL @"http://q.8caopan.com/wp/quotation/v2/kChart?type=10&excode=HPME&code=OIL&sourceId=10&t=%ld&auth=eee35ea62a8983929fba21469c0af218"

//5分K线图
#define DownLoad_FiveK_URL @"http://q.8caopan.com/wp/quotation/v2/kChart?type=2&excode=HPME&code=OIL&sourceId=10&t=%ld&auth=554b533214e89745b06cd517b9e47165"

//15分K线图
#define DownLoad_FifteenK_URL @"http://q.8caopan.com/wp/quotation/v2/kChart?type=3&excode=HPME&code=OIL&sourceId=10&t=%ld&auth=1030ecc1b7081ba3ea394e852f4d17a5"

//30分K线图
#define DownLoad_ThirtyK_URL @"http://q.8caopan.com/wp/quotation/v2/kChart?type=4&excode=HPME&code=OIL&sourceId=10&t=%ld&auth=f27daf514660e5c4e0855e3c9a28b156"

//60分K线图
#define DownLoad_SixtyK_URL @"http://q.8caopan.com/wp/quotation/v2/kChart?type=5&excode=HPME&code=OIL&sourceId=10&t=$ld&auth=227acd0218efe5d365dbe55ba1773cab"

//日K线图
#define DownLoad_DayK_URL @"http://q.8caopan.com/wp/quotation/v2/kChart?type=6&excode=HPME&code=OIL&sourceId=10&t=%ld&auth=b8f09eab05d8c3100e3689f81d2e1c7e"

//4小时K线图
#define DownLoad_FourHourK_URL @"http://q.8caopan.com/wp/quotation/v2/kChart?type=9&excode=HPME&code=OIL&sourceId=10&t=%ld&auth=640a9b8b40548de3d6d966454b476248"



+ (void)getDataWithURL:(NSString *)url Param:(NSDictionary *)param success:(void(^)(id response))success faile:(void(^)(NSError *error))faile;

@end
