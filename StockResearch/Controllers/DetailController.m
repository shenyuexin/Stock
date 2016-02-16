//
//  DeatilController.m
//  StockResearch
//
//  Created by Richard Shen on 16/2/16.
//  Copyright © 2016年 Richard Shen. All rights reserved.
//

#import "DetailController.h"
#import "WBAPIManager.h"
#import "APPMacro.h"

@interface DetailController ()

@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation DetailController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak DetailController *weakSelf = self;
    
    [[[WBAPIManager sharedManager] contentWithUrl:self.url] subscribeNext:^(NSString *content) {
        if(content){
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
            NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
            style.lineHeightMultiple = 1.5;
            style.paragraphSpacing = 10;
            [attr setAttributes:@{NSParagraphStyleAttributeName:style,
                                  NSFontAttributeName:[UIFont systemFontOfSize:16]}
                          range:NSMakeRange(0, attr.length)];
            
            weakSelf.textView.attributedText = attr;
            [weakSelf.textView sizeToFit];
            
            [weakSelf.scroll setContentSize:CGSizeMake(WIDTH_SCREEN, MAX(CGRectGetHeight(self.textView.frame)+20, HEIGHT_SCREEN))];
        }
    }];
}

#pragma mark - UI
- (UIScrollView *)scroll
{
    if(!_scroll){
        _scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scroll];
    }
    return _scroll;
}

- (UITextView *)textView
{
    if(!_textView){
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, WIDTH_SCREEN-20, HEIGHT_SCREEN)];
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.scrollsToTop = NO;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:14];
        [self.scroll addSubview:_textView];
    }
    return _textView;
}
@end
