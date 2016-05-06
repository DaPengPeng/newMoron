//
//  RefreshTableViewController.m
//  Moron
//
//  Created by bever on 16/4/18.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "RefreshTableViewController.h"

@interface RefreshTableViewController () {

    BOOL _isLoading;
}

@end

@implementation RefreshTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -kScreenH, kScreenW, kScreenH)];
    _refreshView.delegate = self;
    [_tableView addSubview:_refreshView];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    //拖动结束时，执行下拉刷新
    [_refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    [_refreshView egoRefreshScrollViewDidScroll:scrollView];
}

#pragma mark - UITableViewDateSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;
}

#pragma mark - EGORefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {

    _isLoading = YES;
    
    [self pushRefreshData];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {

    return _isLoading;
}

//下拉刷新
-(void)pushRefreshData {

}

//刷新完成的操作
-(void)refreshFinished {

    //刷新完后掉用该方法
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    //修改状态
    _isLoading = NO;
}

@end
