//
//  SelfDynamicViewCell.h
//  Moron
//
//  Created by bever on 16/4/14.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfDynamicContentView.h"
#import "SelfDynamicModel.h"
#import "CNLabel.h"

@interface SelfDynamicViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *selfImage;
@property (weak, nonatomic) IBOutlet UILabel *selfName;
@property (weak, nonatomic) IBOutlet UILabel *resource;
@property (weak, nonatomic) IBOutlet CNLabel *title;
@property (weak, nonatomic) IBOutlet SelfDynamicContentView *dynamicContentView;
@property (weak, nonatomic) IBOutlet UILabel *share;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *good;

@property (nonatomic,retain) SelfDynamicModel *model;

@end
