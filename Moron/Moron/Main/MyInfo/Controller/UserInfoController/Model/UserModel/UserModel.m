//
//  UserModel.m
//  Moron
//
//  Created by bever on 16/4/14.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)setAttributes:(NSDictionary *)dic {
    
    self.map = @{@"id":@"setUserId:",@"description":@"setUserDescription:"};//这里为什么不能使用setValue：方法；
    
    [super setAttributes:dic];
}

@end
