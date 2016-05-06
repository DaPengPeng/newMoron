//
//  FoodCell.h
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"
#import "ClassModel.h"

@interface FoodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *name;


@property (nonatomic,retain) FoodModel *foodModel;

@property (nonatomic,retain) ClassModel *classModel;
@end
