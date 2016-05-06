//
//  UserInfoHeaderView.m
//  Moron
//
//  Created by bever on 16/3/26.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "UserInfoHeaderView.h"
#import "MyDetailInfoViewController.h"
#import "BigScrollView.h"
#import "FocusViewController.h"
#import "FansViewController.h"

@implementation UserInfoHeaderView



-(void)awakeFromNib {

    self.userImage.layer.cornerRadius = 45;
    self.userImage.layer.borderWidth = 2;
    self.userImage.layer.borderColor =[UIColor grayColor].CGColor;
    self.userImage.clipsToBounds = YES;
    self.editUserInfo.layer.cornerRadius = 5;
    self.editUserInfo.layer.borderColor = [UIColor greenColor].CGColor;
    self.editUserInfo.layer.borderWidth = 1;
    self.editUserInfo.layer.masksToBounds = YES;
    self.buttonsView.selectedImage = @"up_home";
    self.buttonsView.titleArray = @[@"动态",@"照片",@"记录"];//注意这里，图片的传递写在数组的传递之前。
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    self.buttonsView.buttonBlock = ^(NSInteger index) {
            
        _block(index);
    };
    
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)setUserInfo:(UserInfo *)userInfo {

    _userInfo = userInfo;
    
    //头像设置
    [_userImage sd_setImageWithURL:[NSURL URLWithString:userInfo.profile_image_url]];
    
    //用户粉丝、关注、动态数量
    _fansCount.text = [userInfo.followers_count stringValue];
    _dynamicCount.text = [userInfo.statuses_count stringValue];
    _focusCount.text = [userInfo.friends_count stringValue];
    
    //用户所在地
    _location.text = userInfo.location;
}

//编辑按钮响应事件
- (IBAction)editUserInfo:(UIButton *)sender {
    
    MyDetailInfoViewController *controller = [[MyDetailInfoViewController alloc] init];
    UINavigationController *naviationController = [self currentNavigationController];
    [naviationController pushViewController:controller animated:YES];

}


- (IBAction)dynamicAction:(UIButton *)sender {
    
    BigScrollView *bigScrollView = [self getBigScrollView];
    [UIView animateWithDuration:0.25 animations:^{
        bigScrollView.contentOffset = CGPointMake(0, 160);
    }];

}
- (IBAction)focusAction:(UIButton *)sender {
    
    FocusViewController *focusVC = [[FocusViewController alloc] init];
    [[self currentNavigationController] pushViewController:focusVC animated:YES];
}
- (IBAction)fansAction:(UIButton *)sender {

    FansViewController *fansVC = [[FansViewController alloc] init];
    [[self currentNavigationController] pushViewController:fansVC animated:YES];
}

//找到当前导航控制器
- (UINavigationController *)currentNavigationController {

    UIResponder *responder = self;
    
    do {
        if ([responder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder != nil);
    
    return nil;
}

//找到bigScrollView
- (BigScrollView *)getBigScrollView {

    UIResponder *responder = self;
    
    do {
        if ([responder isKindOfClass:[BigScrollView class]]) {
            return (BigScrollView *)responder;
        }
        responder = responder.nextResponder;
    } while (responder != nil);
    
    return nil;
}
@end
