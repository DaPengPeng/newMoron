//
//  ClassModel.m
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel

- (void)setAttributes:(NSDictionary *)dic {

    self.map = @{@"id":@"setClassId:",@"description":@"setClassDescription:"};
    [super setAttributes:dic];
}


@end
