//
//  DownLoadData.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "DownLoadData.h"
#import <AFNetworking.h>
//http://q.8caopan.com/wp/quotation/v2/tickChart?excode=HPME&code=OIL&sourceId=10&t=1474355352188&auth=252d4d8a8b62a6113bb154cd83c40a96

@implementation DownLoadData

+ (void)getDataWithURL:(NSString *)url Param:(NSDictionary *)param success:(void (^)(id))success faile:(void (^)(NSError *))faile
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"%@",responseObject);
        //成功
        NSLog(@"请求成功");
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            success(dic);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        if (error && faile) {
            faile(error);
        }
    }];
    
}




//解析CSV文件
+(NSArray *)readCSVData:(NSData *)responseObject{
    
    NSString *filepath=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    NSMutableArray *marr = [NSMutableArray array];
    
    NSArray *lines = [filepath componentsSeparatedByString:@"\n"];
    
    NSString *firstTitle = [lines firstObject];
    
    NSArray *titleArr = [firstTitle componentsSeparatedByString:@","];
    
    for (NSString *row in lines) {
        
        NSArray *items = [row componentsSeparatedByString:@","];
        
        if (items.count > 1) {
            
            NSMutableDictionary *item = [NSMutableDictionary dictionary];
            
            for (int i = 0; i < titleArr.count; i++) {
                
                [item setObject:items[i] forKey:titleArr[i]];
                
            }
            
            [marr addObject:item];
            
        }
    }
    NSLog(@"%@",marr);
    
    return marr;
}


@end
