//
//  MacroViewController.m
//  StockReserach
//
//  Created by Richard Shen on 15/12/12.
//  Copyright © 2015年 Richard Shen. All rights reserved.
//

#import "MacroViewController.h"

@interface MacroViewController ()

@end

@implementation MacroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"宏观经济";
    
    self.url = @"http://vip.stock.finance.sina.com.cn/q/go.php/vReport_List/kind/macro/index.phtml";
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
