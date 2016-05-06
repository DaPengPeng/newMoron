//
//  SelfDynamicModel.m
//  Moron
//
//  Created by bever on 16/4/14.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "SelfDynamicModel.h"

@implementation SelfDynamicModel

- (void)setAttributes:(NSDictionary *)dic {
    
    //这里为什么不能使用setValue：方法；
    self.map = @{@"id":@"setWeiBoId:"};
    
    [super setAttributes:dic];
    
    UserModel *model = [[UserModel alloc] initWithDictionary:self.user];
    
    _userModel = model;
    
    if (dic[@"retweeted_status"]) {
        
        _retweetedModel = [[SelfDynamicModel alloc] initWithDictionary:dic[@"retweeted_status"]];
    }
}

@end
