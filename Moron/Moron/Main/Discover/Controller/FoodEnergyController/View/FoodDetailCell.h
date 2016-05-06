//
//  FoodDetailCell.h
//  FoodEnergy
//
//  Created by bever on 16/4/23.
//  Copyright © 2016年 bever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@interface FoodDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *despr;

@property (weak, nonatomic) IBOutlet UITextView *message;
@property (weak, nonatomic) IBOutlet UIImageView *image;


@property (nonatomic,retain) FoodModel *foodModel;

@end
