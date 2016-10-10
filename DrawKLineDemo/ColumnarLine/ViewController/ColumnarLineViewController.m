//
//  ColumnarLineViewController.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/22.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "ColumnarLineViewController.h"
#import "ColumnarLineDataModel.h"
#import "ColumnarLineView.h"


@interface ColumnarLineViewController ()

@property (nonatomic ,strong)NSMutableArray *dataModel;

@property (nonatomic ,strong)ColumnarLineView *columnarView;

@end

@implementation ColumnarLineViewController

- (NSMutableArray *)dataModel
{
    if (!_dataModel) {
        _dataModel = [NSMutableArray array];
    }
    return _dataModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"柱状图";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //暂时拿日期和闭盘价做图
    
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)getData
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
                    self.columnarView = [[ColumnarLineView alloc] initWithFrame:CGRectMake(0, 100, WIDTH, 400)];
                    self.columnarView.columnarModel = self.dataModel;
                    [self.view addSubview:self.columnarView];
                    
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
