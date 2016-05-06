//
//  RefreshTableViewController.h
//  Moron
//
//  Created by bever on 16/4/18.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface RefreshTableViewController : UIViewController <EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) EGORefreshTableHeaderView *refreshView;


//下拉刷新
-(void)pushRefreshData;

//刷新完成的操作
-(void)refreshFinished;

@end
