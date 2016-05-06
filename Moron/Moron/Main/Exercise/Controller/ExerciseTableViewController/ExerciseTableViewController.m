//
//  ExerciseTableViewController.m
//  Moron
//
//  Created by bever on 16/3/20.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "ExerciseTableViewController.h"
#import "MyClassesViewController.h"

@interface ExerciseTableViewController () {

    UITableView *_tableView;
    
    NSMutableArray *_dataList;
}

@end

@implementation ExerciseTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"Run 1.ico"];
        self.tabBarController.tabBar.tintColor = [UIColor redColor];
        self.title = @"训练";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //导航栏左侧头像的创建
    [self createUserimage];
    
    //导航栏右侧的选课按钮
    [self createRightItem];
    
    //表示图的创建
    [self createTableView];
    
    //数据的加载
    [self loadData];
}

//导航栏左侧头像的创建
- (void)createUserimage {

    UserIconImageView *userImageView = [[UserIconImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:userImageView];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//导航栏右侧的选课按钮
- (void)createRightItem {

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 80, 44);
    [rightButton setTitle:@"定制课程" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

//按钮的响应事件
- (void)rightButtonAction:(UIButton *)button {

    MyClassesViewController *myClassesVC = [[MyClassesViewController alloc] init];
    [self.navigationController pushViewController:myClassesVC animated:YES];
}

//表示图的创建
- (void)createTableView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //头视图的创建
    UIView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"EcerciseMyClassesHeaderView" owner:nil options:nil] firstObject];
    headerView.frame = CGRectMake(0, 0, kScreenW, 160);
    _tableView.tableHeaderView = headerView;

}

//数据的加载
- (void)loadData {

    //数据的筛选
    
    _dataList = [[NSMutableArray alloc] init];
    //本地数据（存储）的读取
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/myClasses.plist"];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data) {//这里因为保存的是数组，解析出来也是数组。
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSMutableArray *array = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        
        for (NSMutableDictionary *muDic in array) {
            NSMutableDictionary *classDic = [[NSMutableDictionary alloc] init];
            NSMutableArray *items = [[NSMutableArray alloc] init];
            NSArray *array = muDic[@"item"];
            for (NSDictionary *dic in array) {
                
                if ([dic[@"isMyClass"] boolValue]) {
                    
                    
                    [items addObject:dic];
                }
            }
            [classDic setObject:items forKey:muDic[@"name"]];
            [_dataList addObject:classDic];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSDictionary *dic = _dataList[section];
    NSArray *keys = [dic allKeys];
    NSArray *array = dic[keys[0]];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    NSDictionary *dic = _dataList[indexPath.section];
    NSArray *keys = [dic allKeys];
    NSArray *array = dic[keys[0]];
    NSDictionary *itemDic = array[indexPath.item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = itemDic[@"name"];
    return cell;
}

#warning 单元格的编辑
//标签栏的显示
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    [self loadData];
    [_tableView reloadData];
}

@end
