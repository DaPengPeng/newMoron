//
//  DiscoverHeaderView.h
//  Moron
//
//  Created by bever on 16/4/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DppScrollPageView.h"

@interface DiscoverHeaderView : UIView

@property (weak, nonatomic) IBOutlet DppScrollPageView *scrollPageView;
- (IBAction)firestButtonAction:(UIButton *)sender;
- (IBAction)secondButtonAction:(UIButton *)sender;
- (IBAction)thirdButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *nearBy;
@property (weak, nonatomic) IBOutlet UIButton *food;
@property (weak, nonatomic) IBOutlet UIButton *movies;

@end
