//
//  DiscoverTableViewCell.h
//  Moron
//
//  Created by bever on 16/4/25.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverModel.h"

@interface DiscoverTableViewCell : UITableViewCell

@property (nonatomic,retain) DiscoverModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *title;

@end
