//
//  DetailViewController.h
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "MyInfoSuperViewController.h"

@interface DetailViewController : MyInfoSuperViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSNumber *foodId;

@end
