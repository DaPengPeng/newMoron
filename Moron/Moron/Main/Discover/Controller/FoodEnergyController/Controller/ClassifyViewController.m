//
//  ClassifyViewController.m
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "ClassifyViewController.h"
#import "DppNetworking.h"
#import "FoodModel.h"
#import "FoodCell.h"
#import "FoodCollectionViewCell.h"
#import "ClassModel.h"
#import "ListViewController.h"

@interface ClassifyViewController () {
    
    UITableView *_tableView;
    
    UICollectionView *_collectionView;
}

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建tableView
    [self createTableView];
    
    //加载数据
    if (!_dataList) {
        
        [self loadData];
    }

}

- (void)loadData {
    
    _dataList = [[NSMutableArray alloc] init];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/foodClassify.plist"];
    
    [DppNetworking GET:@"http://www.tngou.net/api/food/classify" parmeters:nil resulteBlock:^(id resulte) {
        
        NSArray *array = resulte[@"tngou"];
        
        for (NSDictionary *dic in array) {
            
            ClassModel *classModel = [[ClassModel alloc] initWithDictionary:dic];
            [_dataList addObject:classModel];
        }
        [_tableView reloadData];
    } withFilePath:filePath];
    
}

- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ClassModel *model = _dataList[indexPath.item];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = model.name;
    return cell;
}

//单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (!_isNoPush) {
        
        NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/foodClassifyId.plist"];
    
        NSMutableArray *dataList = [[NSMutableArray alloc] init];
        ClassModel *model = _dataList[indexPath.row];
        [DppNetworking GET:@"http://www.tngou.net/api/food/classify" parmeters:@{@"id":model.classId} resulteBlock:^(id resulte) {
            
            ClassifyViewController *classVC = [[ClassifyViewController alloc] init];
            NSArray *array = resulte[@"tngou"];
            
            for (NSDictionary *dic in array) {
                
                ClassModel *classModel = [[ClassModel alloc] initWithDictionary:dic];
                [dataList addObject:classModel];
            }
            
            classVC.dataList = dataList;
            classVC.isNoPush = YES;
            [self.navigationController pushViewController:classVC animated:YES];
        } withFilePath:filePath];
    }else {
        
        ClassModel *model = _dataList[indexPath.row];
        
        ListViewController *listVC =[[ListViewController alloc] init];
        listVC.clsaaId = model.classId;
        [self.navigationController pushViewController:listVC animated:YES];
        
        
    }
}
@end

