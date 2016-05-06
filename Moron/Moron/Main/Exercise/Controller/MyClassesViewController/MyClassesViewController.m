//
//  MyClassesViewController.m
//  Moron
//
//  Created by bever on 16/4/26.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyClassesViewController.h"
#import "ClassItemViewController.h"

@interface MyClassesViewController ()  {

    UICollectionView *_collection;
    
    NSMutableArray *_dataList;
}

@end

@implementation MyClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"肌肉列表";
        
    //加载数据
    [self loadData];
    
    //创建collectionView
    [self createCollectionView];
}

//加载数据
- (void)loadData {
    
    //本地数据（存储）的读取
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/myClasses.plist"];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data) {//这里因为保存的是数组，解析出来也是数组。
        
        _dataList = [[NSMutableArray alloc] init];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSMutableArray *array = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        
        for (NSMutableDictionary *muDic in array) {
            
            [_dataList addObject:muDic];
        }
    }

    //未存储的数据的读取
    if (!_dataList) {
        
        _dataList = [[NSMutableArray alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MyClassDataPlist" ofType:@"plist"];
        NSMutableDictionary *itemDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        
        for (NSString *key in itemDic) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:itemDic[key]];
            [_dataList addObject:dic];
        }

    }
}

//创建collectionView
- (void)createCollectionView {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(120, 70);
    layout.minimumInteritemSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    _collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor whiteColor];
    _collection.dataSource = self;
    _collection.delegate = self;
    [self.view addSubview:_collection];
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - UICollectionDataSource
//单元格个数的返回
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _dataList.count;
}

//单元格的返回
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSInteger tag = 100;
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 70)];
        label.tag = tag;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:label];
    }
    label.text = _dataList[indexPath.row][@"name"];
    cell.backgroundColor = [UIColor colorWithRed:rand()%10*0.1 green:rand()%10*0.1 blue:rand()%10*0.1 alpha:1];
    return cell;
}

//单元格的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    ClassItemViewController *classItemVC = [[ClassItemViewController alloc] init];
    classItemVC.dataList = _dataList[indexPath.item][@"item"];
    classItemVC.saveBlock = ^(NSMutableArray *dataList) {
        
        NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:_dataList[indexPath.item]];
        [muDic setObject:dataList forKey:@"item"];
        [_dataList replaceObjectAtIndex:indexPath.item withObject:muDic];
        
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/myClasses.plist"];
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:_dataList];
        [archiver finishEncoding];
        BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
        
        if (isSuccess) {
            NSLog(@"保存成功");
        }else {
            NSLog(@"保存失败");
        }
    };
    [self.navigationController pushViewController:classItemVC animated:YES];
}

//边缘间距的返回
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
