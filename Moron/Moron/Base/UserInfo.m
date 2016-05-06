//
//  UserInfo.m
//  Moron
//
//  Created by bever on 16/4/21.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(void)setAttributes:(NSDictionary *)dic {

    self.map = @{@"description":@"setUserInfoDescription:",@"id":@"setUserId:"};
    [super setAttributes:dic];
    
    if (dic[@"status"]) {
        
        _statusModel = [[StatusModel alloc] initWithDictionary:dic[@"status"]];
    }
    
}


@end
