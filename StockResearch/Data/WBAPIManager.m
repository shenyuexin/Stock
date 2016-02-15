//
//  WBAPIManager.m
//  HongRenTao
//
//  Created by Richard Shen on 16/1/11.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import "WBAPIManager.h"
#import <AFNetworking/AFNetworking.h>
#import <hpple/TFHpple.h>
#import "ResearchInfo.h"

@interface WBAPIManager()

@property (nonatomic, assign) BOOL isLogin;
@end

@implementation WBAPIManager

+ (instancetype)sharedManager
{
    static WBAPIManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WBAPIManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if(self){
    }
    return self;
}

- (NSString *)subString:(NSString *)string regex:(NSString *)regex
{
    NSError *error = nil;
    NSRegularExpression *regexString = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:&error];
    NSTextCheckingResult *firstMatch = [regexString firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    if (firstMatch) {
        NSRange resultRange = [firstMatch rangeAtIndex:0];
        return [string substringWithRange:resultRange];
    }
    return nil;
}

#pragma mark - RACSignal
- (RACSignal *)signalWithUrl:(NSString *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    serializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", nil];
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] init];
    sessionManager.responseSerializer = serializer;
    
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id _Nonnull responseObject, NSError * _Nullable error) {
            TFHpple *doc = [[TFHpple alloc] initWithHTMLData:responseObject];
            if(error){
                [subscriber sendError:error];
            }
            else{
                TFHppleElement *element  = [[doc searchWithXPathQuery:@"//div[@class='main']"] firstObject];
                
                [subscriber sendNext:element];
                [subscriber sendCompleted];
            }
        }];
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            if(task.state != NSURLSessionTaskStateCompleted){
                [task cancel];
            }
        }];
    }] replayLazily];
    return signal;
}


- (RACSignal *)reseachListWithUrl:(NSString *)url
{
    return [[self signalWithUrl:url] map:^id(TFHppleElement *element) {
        NSMutableArray *array = [NSMutableArray array];
        TFHppleElement *div = [element.children objectAtIndex:1];
        for(TFHppleElement *child in div.children){
            if([child.tagName isEqualToString:@"tr"] && [child.raw rangeOfString:@"tal f14"].location != NSNotFound){
                NSArray *objElements = child.children;
                
                TFHppleElement *idElement = objElements[1];
                TFHppleElement *contetElement = objElements[3];
                TFHppleElement *timeElement = objElements[7];

                ResearchInfo *research = [ResearchInfo new];
                research.rid = idElement.text;
                research.time = timeElement.text;
                
                research.title = [[contetElement firstChildWithTagName:@"a"].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                research.url = [self subString:contetElement.raw regex:@"(http).*(?=\">)"];
                
                [array addObject:research];
            }
        }
        return array;
    }];
}
@end
