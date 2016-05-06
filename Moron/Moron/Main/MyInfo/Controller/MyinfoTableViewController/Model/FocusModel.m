//
//  FocusModel.m
//  Moron
//
//  Created by bever on 16/4/21.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "FocusModel.h"

@implementation FocusModel


-(void)setAttributes:(NSDictionary *)dic {
    
    self.map = @{@"description":@"setFocusDescription:",@"id":@"setFocusId:"};
    [super setAttributes:dic];
    
    if (dic[@"status"]) {
        
        _statusModel = [[StatusModel alloc] initWithDictionary:dic[@"status"]];
    }
    
}

@end
