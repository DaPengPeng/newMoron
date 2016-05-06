//
//  UserInfoFirestCell.m
//  Moron
//
//  Created by bever on 16/3/27.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "UserInfoFirestCell.h"
#import "UserInfoModel.h"
#import "MyDetailInfoViewController.h"

@implementation UserInfoFirestCell

-(void)awakeFromNib {
    
    //图片缩小时的超出边界问题
    self.clipsToBounds = NO;
    
    self.userImage.layer.cornerRadius = 45;
    self.userImage.layer.borderWidth = 2;
    self.userImage.layer.borderColor =[UIColor grayColor].CGColor;
    self.userImage.clipsToBounds = YES;
    self.editUserInfo.layer.cornerRadius = 5;
    self.editUserInfo.layer.borderColor = [UIColor greenColor].CGColor;
    self.editUserInfo.layer.borderWidth = 1;
    self.editUserInfo.layer.masksToBounds = YES;
    
    
}

//重写setModel方法
- (void)setModel:(UserInfoModel *)model {
    
    _model = model;

    self.userImage.image = [UIImage imageNamed:_model.userImage];
    self.dynamicCount.text = [_model.dynamicCount stringValue];
    self.focusCount.text = [_model.focusCount stringValue];
    self.fansCount.text = [_model.fansCount stringValue];
    self.adderss.text = _model.userAddress;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editUserInfo:(UIButton *)sender {
    
    MyDetailInfoViewController *detailInfoViewController = [[MyDetailInfoViewController alloc] init];
    UIViewController *viewController = [self controller];
    NSLog(@"controller %@",viewController);
    [viewController.navigationController pushViewController:detailInfoViewController animated:YES];

}   

- (UIViewController *)controller {

    UIResponder *responder = self;
    do {
        if ([responder isKindOfClass:NSClassFromString(@"UserInfoViewController")]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder != nil);
    return nil;
}
- (IBAction)dynamicAction:(UIButton *)sender {

}
- (IBAction)focusAction:(UIButton *)sender {

}
- (IBAction)fansAction:(UIButton *)sender {}

@end
