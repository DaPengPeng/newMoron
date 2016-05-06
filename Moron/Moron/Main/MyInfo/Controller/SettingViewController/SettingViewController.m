//
//  SettingViewController.m
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () {

    UITableView *_tableView;
    
    NSDictionary *_dataDic;
    NSArray *_dataList;
}

@end

@implementation SettingViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"设置";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //加载数据
    [self loadData];
    
    //创建TableView
    [self creatTableView];
    
}

//加载数据
- (void)loadData {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    _dataDic = [NSDictionary dictionaryWithContentsOfFile:path];
    _dataList = @[@"array1",@"array2",@"array3",@"array4"];
    
}

//创建TableView
- (void)creatTableView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-20) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
//单元格个数的返回
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = _dataDic[_dataList[section]];
    return array.count;
}

//单元格的返回
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] init];
    }
    NSArray *array = _dataDic[_dataList[indexPath.section]];
    cell.textLabel.text = array[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//组数的返回
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataList.count;
}

//头视图高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 19;
}

//尾视图高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 1;
}

@end
