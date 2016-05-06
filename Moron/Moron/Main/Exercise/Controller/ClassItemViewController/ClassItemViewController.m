//
//  ClassItemViewController.m
//  Moron
//
//  Created by bever on 16/4/26.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "ClassItemViewController.h"
#import "ExerciseItemCollectionCell.h"

@interface ClassItemViewController () {

    UICollectionView *_collectionView;
}

@end

@implementation ClassItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题的设置
    self.title = @"相关项目";
    
    //右侧保存按钮的创建
    [self createRightItem];
}

//右侧保存按钮的创建
- (void)createRightItem {

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 44);
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

//右侧保存按钮的响应
- (void)rightButtonAction:(UIButton *)butotn {

    _saveBlock(_dataList);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//复写set方法
- (void)setDataList:(NSMutableArray *)dataList {
    
    _dataList =[[NSMutableArray alloc] initWithArray:dataList];
    
    //创建collectionView
    [self createCollectionView];
}

//创建collectionView
- (void)createCollectionView {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(120, 70);
    layout.minimumInteritemSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"ExerciseItemCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ExerciseItemCollectionCell"];
}

#pragma mark - UICollectionDataSource
//单元格个数的返回
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataList.count;
}

//单元格的返回
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ExerciseItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExerciseItemCollectionCell" forIndexPath:indexPath];
    cell.dataDic = [NSMutableDictionary dictionaryWithDictionary:_dataList[indexPath.row]];
    cell.backgroundColor = [UIColor colorWithRed:rand()%10*0.1 green:rand()%10*0.1 blue:rand()%10*0.1 alpha:1];
    return cell;
}

//单元格的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    ExerciseItemCollectionCell *cell = (ExerciseItemCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    BOOL isMyClass = [_dataList[indexPath.item][@"isMyClass"] boolValue];
    cell.checkmarkImage.hidden = [_dataList[indexPath.item][@"isMyClass"] boolValue];
    isMyClass = !isMyClass;
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:_dataList[indexPath.item]];
    [muDic setValue:@(isMyClass) forKey:@"isMyClass"];
    [_dataList replaceObjectAtIndex:indexPath.item withObject:muDic];
}

//边缘间距的返回
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
@end
