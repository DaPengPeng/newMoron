//
//  MyDetailInfoModel.h
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "BaseModel.h"

@interface MyDetailInfoModel : BaseModel

@property (nonatomic,copy) NSString *title,*content;

@property (nonatomic,retain) NSNumber *type;

@end
