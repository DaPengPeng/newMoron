//
//  ListViewController.m
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "ListViewController.h"
#import "DppNetworking.h"
#import "FoodModel.h"
#import "FoodCollectionViewCell.h"
#import "DetailViewController.h"

@interface ListViewController () {

    UICollectionView *_collectionView;

    NSMutableArray *_dataList;
}

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //collectionView的创建
    [self createCollectionView];
    
    //加载数据
    [self loadData];
    
}

- (void)loadData {
    
    _dataList = [[NSMutableArray alloc] init];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/foodList.plist"];
    
    [DppNetworking GET:@"http://www.tngou.net/api/food/list" parmeters:@{@"id":_clsaaId} resulteBlock:^(id resulte) {

        NSArray *array = resulte[@"tngou"];
        for (NSDictionary *dic in array) {

            FoodModel *foodModel = [[FoodModel alloc] initWithDictionary:dic];
            [_dataList addObject:foodModel];
        }

        [_collectionView reloadData];
    } withFilePath:filePath];
}

- (void)createCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(120, 120);
    layout.minimumInteritemSpacing = 15;
    layout.minimumLineSpacing = 15;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"FoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.foodModel = _dataList[indexPath.item];
    return cell;
}

//单元格点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    FoodModel *model = _dataList[indexPath.item];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    detailVC.foodId = model.foodId;
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
