//
//  MovieViewController.m
//  Moron
//
//  Created by bever on 16/4/27.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieViewCollectionCell.h"
#import "CellPushViewController.h"

@interface MovieViewController () {

    UICollectionView *_collectionView;
    
    NSMutableArray *_dataList;
}

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"视频中心";
    
    //collectionView的创建
    [self createCollectionView];
    
    //加载数据
    [self loadData];
    
}

- (void)loadData {
    
    _dataList = [[NSMutableArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"movies" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    for (NSDictionary *dic in jsonDic[@"body"]) {
        
        [_dataList addObject:dic];
    }
    
}

- (void)createCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(120, 120);
    layout.minimumInteritemSpacing = 15;
    layout.minimumLineSpacing = 15;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"MovieViewCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MovieViewCollectionCell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieViewCollectionCell" forIndexPath:indexPath];
    cell.dataDic = _dataList[indexPath.item];
    return cell;
}

//单元格点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellPushViewController *moviesPushVC = [[CellPushViewController alloc] init];
    moviesPushVC.url = _dataList[indexPath.item][@"url"];
    moviesPushVC.title = _dataList[indexPath.item][@"title"];
    [self.navigationController pushViewController:moviesPushVC animated:YES];
}

//边缘间距的返回
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(20, 10, 20, 10);
}

@end
