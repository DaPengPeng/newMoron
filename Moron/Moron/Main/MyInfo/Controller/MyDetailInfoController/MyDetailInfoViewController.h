//
//  MyDetailInfoViewController.h
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyInfoSuperViewController.h"

@interface MyDetailInfoViewController : MyInfoSuperViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataList;

@property (nonatomic,strong) NSMutableDictionary *dataDic;

@end
