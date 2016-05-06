//
//  ClassModel.h
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "BaseModel.h"

@interface ClassModel : BaseModel

@property (nonatomic,copy) NSString *classDescription,*foodclass,*keywords,*name,*title;

@property (nonatomic,retain) NSNumber *classId,*seq;

@end
