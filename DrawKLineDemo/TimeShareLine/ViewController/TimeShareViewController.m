//
//  TimeShareViewController.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/20.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "TimeShareViewController.h"
#import "TimeShareView.h"
#import "TimeShareModel.h"
#import "StockInfoModel.h"

@interface TimeShareViewController ()

@property (nonatomic ,strong) TimeShareView*timeView;
@property (nonatomic ,strong)TimeShareModel *dataModel;
@property (nonatomic ,strong)StockInfoModel *infoModel;

@end

@implementation TimeShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分时图";
    
    
    [self getStockInfo:^{
        [self getData];
    }];
}

- (void)getData
{
    
    //[[NSDate date] timeIntervalSince1970]
    
    [DownLoadData getDataWithURL:[NSString stringWithFormat:DownLoad_OldTime_URL,(NSInteger)[[NSDate date] timeIntervalSince1970]] Param:nil success:^(id response) {
        
        if ([[response objectForKey:@"status"] integerValue] == 1000) {
            
            TimeShareModel *model = [[TimeShareModel alloc] init];
            model.list = [TimeModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"list"]];
            
            self.dataModel = model;
            
            self.timeView = [[TimeShareView alloc] initWithFrame:CGRectMake(0, 100, WIDTH, 400)];
            self.timeView.backgroundColor = [UIColor grayColor];
            self.timeView.timeModel = model;
            [self.view addSubview:self.timeView];
            [self.timeView setNeedsDisplay];
            
        }
        
    } faile:^(NSError *error) {
        
    }];
}

- (void)getStockInfo:(void(^)(void))complate
{
    [DownLoadData getDataWithURL:DownLoad_UpdateTime_URL Param:nil success:^(id response) {
        
        if ([[response objectForKey:@"status"] integerValue] == 1000) {
            
            StockInfoModel *infoModel = [[StockInfoModel alloc] init];
            [infoModel mj_setKeyValues:response[@"data"][@"quotes"]];
            
            self.infoModel = infoModel;
            self.timeView.infoModel = infoModel;
            
            if (complate) {
                complate();
            }
        }
        
    } faile:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
