//
//  StatusModel.h
//  Moron
//
//  Created by bever on 16/4/18.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "BaseModel.h"

@interface StatusModel : BaseModel

@property (nonatomic,copy) NSString *create_at,*text,*source,*in_reply_to_status_id,*in_reply_to_user_id,*in_reply_to_screen_name,*mid;

@property (nonatomic,retain) NSArray *annotations;

@property (nonatomic,retain) NSNumber *statusId,*favorited,*truncated,*reposts_count,*comments_count;

@end
