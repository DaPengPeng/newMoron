//
//  FoodModel.h
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "BaseModel.h"

@interface FoodModel : BaseModel

@property (nonatomic,retain) NSNumber *count,*fcount,*foodId,*rcount;

@property (nonatomic,copy) NSString *foodDescription,*disease,*img,*summary,*keywords,*name,*message;

@end
