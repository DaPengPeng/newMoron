//
//  UserInfoViewController.h
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyInfoSuperViewController.h"
#import "EGORefreshTableHeaderView.h"

typedef void(^MyInfoFootBlock)(CGFloat);

@interface UserInfoViewController : MyInfoSuperViewController <UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,EGORefreshTableHeaderDelegate>


@property (nonatomic,copy) MyInfoFootBlock block;


@end
