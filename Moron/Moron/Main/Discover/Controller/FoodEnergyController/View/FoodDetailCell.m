//
//  FoodDetailCell.m
//  FoodEnergy
//
//  Created by bever on 16/4/23.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "FoodDetailCell.h"
#import "UIImageView+WebCache.h"

@implementation FoodDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setFoodModel:(FoodModel *)foodModel {

    _foodModel = foodModel;
    
    _name.text = foodModel.name;
    _despr.text = foodModel.foodDescription;
    [_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/img%@",_foodModel.img]]];
    
    NSMutableString *string = [NSMutableString stringWithString:foodModel.message];
    do {
        
        NSRange rangeP = [string rangeOfString:@"<p>"];
        if (rangeP.location != NSNotFound) {
            
            [string deleteCharactersInRange:rangeP];
        }
    } while ([string rangeOfString:@"<p>"].location != NSNotFound);
    
    do {
        
        NSRange rangeP = [string rangeOfString:@"</p>"];
        if (rangeP.location != NSNotFound) {
            
            [string deleteCharactersInRange:rangeP];
        }
    } while ([string rangeOfString:@"</p>"].location != NSNotFound);
    
    do {
        
        NSRange rangeP = [string rangeOfString:@"<h2>"];
        if (rangeP.location != NSNotFound) {
            
            [string deleteCharactersInRange:rangeP];
        }
    } while ([string rangeOfString:@"<h2>"].location != NSNotFound);
    
    do {
        
        NSRange rangeP = [string rangeOfString:@"</h2>"];
        if (rangeP.location != NSNotFound) {
            
            [string deleteCharactersInRange:rangeP];
        }
    } while ([string rangeOfString:@"</h2>"].location != NSNotFound);
    
    do {
        
        NSRange rangeP = [string rangeOfString:@"<strong>"];
        if (rangeP.location != NSNotFound) {
            
            [string deleteCharactersInRange:rangeP];
        }
    } while ([string rangeOfString:@"<strong>"].location != NSNotFound);
    do {
        
        NSRange rangeP = [string rangeOfString:@"</strong>"];
        if (rangeP.location != NSNotFound) {
            
            [string deleteCharactersInRange:rangeP];
        }
    } while ([string rangeOfString:@"</strong>"].location != NSNotFound);
    _message.text = string;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
