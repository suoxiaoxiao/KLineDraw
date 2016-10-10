//
//  KLineViewController.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/26.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "KLineViewController.h"
#import "KLineView.h"
#import "ColumnarLineDataModel.h"

@interface KLineViewController ()

@property (nonatomic ,strong)NSMutableArray *dataModel;

@end

@implementation KLineViewController


- (NSMutableArray *)dataModel
{
    if (!_dataModel) {
        _dataModel = [NSMutableArray array];
    }
    return _dataModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"K线图";
    
    KLineView *kView = [[KLineView alloc] initWithFrame:CGRectMake(0, 100, WIDTH, 400)];
    [self.view addSubview:kView];
    
    __weak typeof(self)weakSelf = self;
    NSLog(@"开始下载%f",[[NSDate date] timeIntervalSince1970]);
    [self getData:^{
        NSLog(@"结束下载%f",[[NSDate date] timeIntervalSince1970]);
        kView.kArray = weakSelf.dataModel;
        
    }];
    
    
    // Do any additional setup after loading the view.
}

- (void)getData:(void(^)(void))complate
{
    [DownLoadData getDataWithURL:[NSString stringWithFormat:DownLoad_DayK_URL,(NSInteger)[[NSDate date] timeIntervalSince1970]] Param:nil success:^(id response) {
        
        NSLog(@"%@",response);
        if (response && [response isKindOfClass:[NSDictionary class]]) {
            
            if ([response[@"status"] integerValue] == 1000) {
                
                NSArray *candle = response[@"data"][@"candle"];
                
                if (candle && candle.count) {
                    
                    for (NSDictionary *dict in candle) {
                        
                        ColumnarLineDataModel *model = [[ColumnarLineDataModel alloc] init];
                        [model mj_setKeyValues:dict];
                        
                        [self.dataModel addObject:model];
                        
                    }
                    
                    if (complate) {
                        complate();
                    }
                    
                }
                
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
