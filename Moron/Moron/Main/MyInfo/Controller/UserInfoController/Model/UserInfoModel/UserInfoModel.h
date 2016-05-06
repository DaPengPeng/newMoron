//
//  UserInfoModel.h
//  Moron
//
//  Created by bever on 16/3/26.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel

@property (nonatomic,copy) NSString *userName,*userImage,*userSpeak,*userPhotoData,*userAddress;

@property (nonatomic,retain) NSArray *userPhoto;

@property (nonatomic,retain) NSNumber *dynamicCount,*focusCount,*fansCount;


@end
