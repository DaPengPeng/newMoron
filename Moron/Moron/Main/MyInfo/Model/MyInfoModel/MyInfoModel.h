//
//  MyInfoModel.h
//  Moron
//
//  Created by bever on 16/3/22.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "BaseModel.h"

@interface MyInfoModel : BaseModel

@property (nonatomic,copy) NSString *title,*title2,*image,*controller;

@property (nonatomic,retain) NSNumber *type,*dynamicCount,*fansCount,*focusCount;

@end
