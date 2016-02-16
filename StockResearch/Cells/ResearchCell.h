//
//  ResearchCell.h
//  StockResearch
//
//  Created by Richard Shen on 16/2/16.
//  Copyright © 2016年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResearchInfo.h"
#import "APPMacro.h"

FOUNDATION_EXPORT NSString *const ResearchCellIdentify;

@interface ResearchCell : UITableViewCell

@property (nonatomic, strong) ResearchInfo *research;
@end
