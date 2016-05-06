//
//  SelfDynamicModel.h
//  Moron
//
//  Created by bever on 16/4/14.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"

@interface SelfDynamicModel : BaseModel

@property (nonatomic,copy) NSString *created_at,*text,*source,*in_reply_to_status_id,*in_reply_to_user_id,*in_reply_to_screen_name,*mid,*thumbnail_pic;

@property (nonatomic,retain) NSNumber *weiBoId,*favorited,*truncated,*reposts_count,*comments_count,*attitudes_count,*previous_cursor,*next_cursor,*total_number;

@property (nonatomic,retain) NSArray *annotations,*ad,*pic_urls;

@property (nonatomic,retain) NSDictionary *user,*retweeted_status;

@property (nonatomic,retain) UserModel *userModel;
@property (nonatomic,retain) SelfDynamicModel *retweetedModel;

@end
