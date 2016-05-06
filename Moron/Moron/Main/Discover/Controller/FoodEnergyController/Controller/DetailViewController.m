//
//  DetailViewController.m
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "DetailViewController.h"
#import "DppNetworking.h"
#import "FoodModel.h"
#import "FoodDetailCell.h"

@interface DetailViewController () {

    NSMutableArray *_dataList;
    
    UITableView *_tableView;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    [self createTableView];
}

//表示图的创建
- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 414, [UIScreen mainScreen].bounds.size.height)];
    
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

//加载数据
- (void)loadData {
    
    _dataList = [[NSMutableArray alloc] init];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/foodShow.plist"];
    
    [DppNetworking GET:@"http://www.tngou.net/api/food/show" parmeters:@{@"id":_foodId} resulteBlock:^(id resulte) {
        
        FoodModel *foodModel = [[FoodModel alloc] initWithDictionary:resulte];
        [_dataList addObject:foodModel];
        
        [_tableView reloadData];
    } withFilePath:filePath];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    FoodModel *model = _dataList[indexPath.row];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FoodDetailCell" owner:nil options:nil] firstObject];
    }
    cell.foodModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    FoodModel *model = _dataList[indexPath.row];
    
    CGRect rect = [model.message boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.5]} context:nil];

    return 300+rect.size.height;
}

@end
