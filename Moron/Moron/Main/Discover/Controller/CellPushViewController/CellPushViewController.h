//
//  CellPushViewController.h
//  Moron
//
//  Created by bever on 16/4/25.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyInfoSuperViewController.h"

@interface CellPushViewController : MyInfoSuperViewController <UIWebViewDelegate>

@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *title1;

@end
