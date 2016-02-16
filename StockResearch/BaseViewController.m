//
//  BaseViewController.m
//  StockReserach
//
//  Created by Richard Shen on 15/12/12.
//  Copyright © 2015年 Richard Shen. All rights reserved.
//

#import "BaseViewController.h"
#import "ResearchCell.h"
#import "DetailController.h"

@interface BaseViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *moreUrl;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lists = [NSMutableArray array];

    __weak BaseViewController *weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[[WBAPIManager sharedManager] reseachListWithUrl:weakSelf.url] subscribeNext:^(NSArray *list) {
            [weakSelf.lists addObjectsFromArray:list];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
            
            weakSelf.page = 2;
            weakSelf.moreUrl = [NSString stringWithFormat:@"%@?p=%li",weakSelf.url,(long)weakSelf.page];
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [[[WBAPIManager sharedManager] reseachListWithUrl:weakSelf.moreUrl] subscribeNext:^(NSArray *list) {
            [weakSelf.lists addObjectsFromArray:list];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
            
            weakSelf.page ++;
            weakSelf.moreUrl = [NSString stringWithFormat:@"%@?p=%li",weakSelf.url,(long)weakSelf.page];

        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableView registerClass:[ResearchCell class] forCellReuseIdentifier:ResearchCellIdentify];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 56;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ResearchCellIdentify forIndexPath:indexPath];
    ResearchInfo *research = self.lists[indexPath.row];
    research.index = indexPath.row+1;
    cell.research = research;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ResearchInfo *research = self.lists[indexPath.row];
    DetailController *detail = [DetailController new];
    detail.hidesBottomBarWhenPushed = YES;
    detail.url = research.url;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
