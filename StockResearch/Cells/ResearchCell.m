//
//  ResearchCell.m
//  StockResearch
//
//  Created by Richard Shen on 16/2/16.
//  Copyright © 2016年 Richard Shen. All rights reserved.
//

#import "ResearchCell.h"

NSString * const ResearchCellIdentify = @"ResearchCellIdentify";

@interface ResearchCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *indexLabel;
@end

@implementation ResearchCell


- (void)setResearch:(ResearchInfo *)research
{
    _research = research;
    if(_research.isRead){
        self.indexLabel.textColor = [UIColor grayColor];
        self.titleLabel.textColor = [UIColor grayColor];
    }
    else{
        self.indexLabel.textColor = [UIColor blackColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
//    self.indexLabel.text = [NSString stringWithFormat:@"%li.",(long)_research.index];
//    [self.indexLabel sizeToFit];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%li. %@",(long)_research.index, _research.title];
    self.timeLabel.text = _research.time;
}

#pragma mark - UI
- (UILabel *)indexLabel
{
    if(!_indexLabel){
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 16, 20, 14)];
        _indexLabel.font = [UIFont systemFontOfSize:14];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_indexLabel];
    }
    return _indexLabel;
}

- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, WIDTH_SCREEN-130, 40)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN-100, 8, 90, 40)];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor grayColor];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}
@end
