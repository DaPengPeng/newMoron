//
//  CommentModel.h
//  Moron
//
//  Created by bever on 16/4/18.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
#import "StatusModel.h"

@interface CommentModel : BaseModel

@property (nonatomic,copy) NSString *created_at,*text,*source;

@property (nonatomic,retain) NSNumber *commentId,*mid;

@property (nonatomic,retain) UserModel *userModel;

@property (nonatomic,retain) StatusModel *statusModel;

@end
