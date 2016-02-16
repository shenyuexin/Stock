//
//  ResearchInfo.h
//  StockResearch
//
//  Created by Richard Shen on 16/2/15.
//  Copyright © 2016年 Richard Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResearchInfo : NSObject

@property (nonatomic, strong) NSString *rid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *time;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign, getter=isRead) BOOL read;
@end
