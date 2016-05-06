//
//  MyInfoTableViewController.h
//  Moron
//
//  Created by bever on 16/3/20.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableDictionary *dataDic;

@property (nonatomic,strong) NSMutableArray *dataList;

@end
