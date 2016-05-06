//
//  DynamicDetailViewController.h
//  Moron
//
//  Created by bever on 16/4/18.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "SelfDynamicModel.h"

@interface DynamicDetailViewController : RefreshTableViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) SelfDynamicModel *model;

@end
