//
//  CommentModel.m
//  Moron
//
//  Created by bever on 16/4/18.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

- (void)setAttributes:(NSDictionary *)dic {
    
    self.map = @{@"id":@"setCommentId:"};

    [super setAttributes:dic];
    NSDictionary *userDic = dic[@"user"];
    if (userDic) {
        
        _userModel = [[UserModel alloc] initWithDictionary:userDic];
    }
    NSDictionary *statusDic = dic[@"status"];
    if (statusDic) {
        
        _statusModel = [[StatusModel alloc] initWithDictionary:statusDic];
    }
}

@end
