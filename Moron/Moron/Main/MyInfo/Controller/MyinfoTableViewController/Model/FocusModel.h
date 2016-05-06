//
//  FocusModel.h
//  Moron
//
//  Created by bever on 16/4/21.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "BaseModel.h"
#import "StatusModel.h"

@interface FocusModel : BaseModel

@property (nonatomic,copy) NSString *screen_name,*name,*province,*city,*location,*focusDescription,*url,*profile_image_url,*domain,*gender,*created_at,*avatar_large,*verified_reason;

@property (nonatomic,retain) NSNumber *focusId,*followers_count,*friends_count,*statuses_count,*favourites_count,*following,*allow_all_act_msg,*geo_enabled,*verified,*allow_all_comment,*follow_me,*online_status,*bi_followers_count;

@property (nonatomic,retain) StatusModel *statusModel;

/*
 focusDescription
 focusId
 */

@end
