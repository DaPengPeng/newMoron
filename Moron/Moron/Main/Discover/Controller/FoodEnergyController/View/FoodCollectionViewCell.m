//
//  FoodCollectionViewCell.m
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "FoodCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation FoodCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setFoodModel:(FoodModel *)foodModel {

    _foodModel = foodModel;
    
    _name.text = _foodModel.name;
    [_foodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/img%@",_foodModel.img]]];
}

@end
