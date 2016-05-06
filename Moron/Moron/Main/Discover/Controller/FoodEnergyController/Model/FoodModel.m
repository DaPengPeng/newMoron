//
//  FoodModel.m
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

- (void)setAttributes:(NSDictionary *)dic {

    self.map = @{@"id":@"setFoodId:",@"description":@"setFoodDescription:"};
    [super setAttributes:dic];
}

@end
