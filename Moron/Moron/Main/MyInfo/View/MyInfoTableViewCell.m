//
//  MyInfoTableViewCell.m
//  Moron
//
//  Created by bever on 16/3/22.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyInfoTableViewCell.h"
#import "MyInfoModel.h"
#import "DynamicViewController.h"
#import "FocusViewController.h"
#import "FansViewController.h"


@implementation MyInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

//重写setModel方法
-(void)setModel:(MyInfoModel *)model {

    _model = model;
    
    if ([_model.type integerValue] == 1) {
        
        //头像的边框设置
        _userImage.layer.cornerRadius = 30;
        _userImage.clipsToBounds = YES;
        _userImage.layer.borderWidth = 1;
        
        [_userImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
        _userName.text = _model.title;
        _loudlySpeak.text = _model.title2;
    }else if ([_model.type integerValue] == 2) {
        
        _count1.text = [model.dynamicCount stringValue];
        _count2.text = [model.focusCount stringValue];
        _count3.text = [model.fansCount stringValue];
    
    }else if ([_model.type integerValue] == 3){
    
        _title.text = _model.title;
        _image.image = [UIImage imageNamed:_model.image];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)dynamicAction:(UIButton *)sender {
    
    DynamicViewController *dynamicController = [[DynamicViewController alloc] init];
    UITableViewController *myInfoViewController = [self controller];
    [myInfoViewController.navigationController pushViewController:dynamicController animated:YES];
}

- (IBAction)focusAction:(UIButton *)sender {
    
    FocusViewController *focusViewController = [[FocusViewController alloc] init];
    UITableViewController *myInfoViewController = [self controller];
    [myInfoViewController.navigationController pushViewController:focusViewController animated:YES];
     
}

- (IBAction)fansAction:(UIButton *)sender {
    
    FansViewController *fansViewController = [[FansViewController alloc] init];
    UITableViewController *myInfoViewController = [self controller];
    [myInfoViewController.navigationController pushViewController:fansViewController animated:YES];
}

//拿到当前的控制器
- (UITableViewController *)controller {

    UIResponder *responder = self;
    do {
        if ([responder isKindOfClass:[NSClassFromString(@"MyInfoTableViewController") class]]) {
            return (UITableViewController *)responder;
        }else {
        
            responder = responder.nextResponder;
        }
    } while (responder != nil);
    return nil;
}
@end
