//
//  FoodCell.m
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "FoodCell.h"
#import "UIImageView+WebCache.h"

@implementation FoodCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setFoodModel:(FoodModel *)foodModel {

    _foodModel = foodModel;
    
    _name.text = _foodModel.name;
    [_foodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/img%@",_foodModel.img]]];
    
}

- (void)setClassModel:(ClassModel *)classModel {

    _classModel = classModel;
    _name.text = _classModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
