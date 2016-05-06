//
//  ListViewController.h
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "MyInfoSuperViewController.h"

@interface ListViewController : MyInfoSuperViewController <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>


@property (nonatomic,retain) NSNumber *clsaaId;

@end
