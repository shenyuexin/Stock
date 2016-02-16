//
//  WBAPIManager.h
//  HongRenTao
//
//  Created by Richard Shen on 16/1/11.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#define kTimeoutInterval             10
#define kDefaultPageNum              20

#define kDefaultErrorCode            0

@interface WBAPIManager : NSObject

+ (instancetype)sharedManager;

- (RACSignal *)contentWithUrl:(NSString *)url;

- (RACSignal *)reseachListWithUrl:(NSString *)url;
@end
