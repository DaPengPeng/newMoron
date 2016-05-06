//
//  DiscoverController.m
//  Moron
//
//  Created by bever on 16/4/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "DiscoverController.h"
#import "DiscoverHeaderView.h"
#import "DiscoverTableViewCell.h"
#import "DiscoverModel.h"
#import "CellPushViewController.h"

@interface DiscoverController () {

    UITableView *_tableView;
    
    DiscoverHeaderView *_headerView;
    
    NSMutableArray *_dataList;
}

@end

@implementation DiscoverController

-(instancetype)init {
    
    self = [super init];
    if (self != nil) {
        self.tabBarItem.image = [UIImage imageNamed:@"Search.ico"];
        self.title = @"发现";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //数据的加载
    [self loadData];
    
    //tableView的创建
    [self createTableView];
    
    //导航栏左侧的按钮
    [self addUserIconButton];
    
}

//导航栏左侧按钮的创建
- (void)addUserIconButton {
    
    UserIconImageView *userImageView = [[UserIconImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:userImageView];
    self.navigationItem.leftBarButtonItem = leftItem;
}


//数据的加载
- (void)loadData {

    _dataList = [[NSMutableArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DiscoverContentJson" ofType:@"json"];
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (error) {
        NSLog(@"error:%@",error);
    }
    
    NSArray *array = dic[@"bodys"];
    for (NSDictionary *dic in array) {
        
        DiscoverModel *model = [[DiscoverModel alloc] initWithDictionary:dic];
        [_dataList addObject:model];
    }
    
}

- (void)createTableView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //头视图的创建
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"DiscoverHeaderView" owner:nil options:nil] firstObject];
    _tableView.tableHeaderView = _headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverTableViewCell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DiscoverTableViewCell" owner:nil options:nil] firstObject];
    }
    cell.model = _dataList[indexPath.row];
    return cell;
}

//单元格高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 90;
}

//单元格的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    CellPushViewController *cellPushVC = [[CellPushViewController alloc] init];
    DiscoverModel *model = _dataList[indexPath.row];
    cellPushVC.url = model.url;
    [self.navigationController pushViewController:cellPushVC animated:YES];
}

//标签栏的显示
- (void)viewDidAppear:(BOOL)animated {

    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end
