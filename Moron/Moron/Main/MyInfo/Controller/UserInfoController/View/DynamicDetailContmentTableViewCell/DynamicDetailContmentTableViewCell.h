//
//  DynamicDetailContmentTableViewCell.h
//  Moron
//
//  Created by bever on 16/4/18.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "CNLabel.h"

@interface DynamicDetailContmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet CNLabel *comment;

@property (nonatomic,retain) CommentModel *model;

@end
