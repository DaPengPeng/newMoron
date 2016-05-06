//
//  DynamicTableView.h
//  Moron
//
//  Created by bever on 16/4/24.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigScrollView.h"

@interface DynamicTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) BigScrollView *bigScrollView;

@end
