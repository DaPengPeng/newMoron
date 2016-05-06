//
//  FoodCollectionViewCell.h
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@interface FoodCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic,retain) FoodModel *foodModel;
@end
