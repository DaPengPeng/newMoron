//
//  ClassItemViewController.h
//  Moron
//
//  Created by bever on 16/4/26.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyInfoSuperViewController.h"

typedef void(^SaveDataList)(NSMutableArray *dataList);

@interface ClassItemViewController : MyInfoSuperViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain) NSMutableArray *dataList;

@property (nonatomic,copy) SaveDataList saveBlock;

@end
