//
//  UserInfoHeaderView.h
//  Moron
//
//  Created by bever on 16/3/26.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UserInfoHeaderViewBlock)(NSInteger index);

@interface UserInfoHeaderView : UIView

@property (nonatomic,retain) UserInfo *userInfo;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *dynamicCount;
@property (weak, nonatomic) IBOutlet UILabel *dynamic;
@property (weak, nonatomic) IBOutlet UILabel *focus;
@property (weak, nonatomic) IBOutlet UILabel *focusCount;
@property (weak, nonatomic) IBOutlet UILabel *fans;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;
@property (weak, nonatomic) IBOutlet UIButton *editUserInfo;
@property (weak, nonatomic) IBOutlet ButtonsView *buttonsView;
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (nonatomic,copy) UserInfoHeaderViewBlock block;

- (IBAction)editUserInfo:(UIButton *)sender;
- (IBAction)dynamicAction:(UIButton *)sender;
- (IBAction)focusAction:(UIButton *)sender;
- (IBAction)fansAction:(UIButton *)sender;

@end
