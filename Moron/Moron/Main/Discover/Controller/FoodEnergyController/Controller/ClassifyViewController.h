//
//  ClassifyViewController.h
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "MyInfoSuperViewController.h"

@interface ClassifyViewController : MyInfoSuperViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *dataList;

@property (nonatomic,assign) BOOL isNoPush;

@end
