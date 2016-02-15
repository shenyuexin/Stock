//
//  BaseViewController.h
//  StockReserach
//
//  Created by Richard Shen on 15/12/12.
//  Copyright © 2015年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBAPIManager.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *url;
@end
