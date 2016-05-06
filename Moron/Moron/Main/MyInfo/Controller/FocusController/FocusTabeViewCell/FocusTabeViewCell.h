//
//  FocusTabeViewCell.h
//  Moron
//
//  Created by bever on 16/4/21.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusModel.h"

@interface FocusTabeViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dynamic;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (nonatomic,retain) FocusModel *focusModel;

@end
