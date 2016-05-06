//
//  SelfDynamicContentView.h
//  Moron
//
//  Created by bever on 16/4/14.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfDynamicModel.h"
#import "CNLabel.h"

@interface SelfDynamicContentView : UIView

@property (nonatomic,retain) SelfDynamicModel *model;

@property (nonatomic,assign) CGFloat contentLabelH,photoViewH;

@property (nonatomic,retain) CNLabel *contentLabel;
@end
