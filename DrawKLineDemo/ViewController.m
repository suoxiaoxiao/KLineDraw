//
//  ViewController.m
//  DrawKLineDemo
//
//  Created by 索晓晓 on 16/9/19.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "ViewController.h"
#import "TimeShareViewController.h"
#import "ColumnarLineViewController.h"
#import "KLineViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)timeShareAction:(UIButton *)sender {
    
    TimeShareViewController *vc = [[TimeShareViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)columnarLineAction:(id)sender {
    ColumnarLineViewController *vc = [[ColumnarLineViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)KLineAction:(id)sender {
    
    KLineViewController *vc = [[KLineViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)brokenLineAction:(id)sender {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
