//
//  RegisterViewController.m
//  Moron
//
//  Created by bever on 16/4/11.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "RegisterViewController.h"
#import "DppXMPP.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"

@interface RegisterViewController ()  {

    BOOL _isSuccess;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置button的背景图片
    [_registerButton setBackgroundImage:[[UIImage imageNamed:@"button_title.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:15] forState:UIControlStateNormal];
    
    //返回按钮的添加
    [self addCustomBackButton];
}


- (void)viewWillAppear:(BOOL)animated {

    self.title = @"注册";
    self.navigationController.navigationBar.hidden = NO;
}

//添加自定义返回按钮
- (void)addCustomBackButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setImage:[UIImage imageNamed:@"top_back_white"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

//按钮的相应事件
- (void)buttonAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerAction:(UIButton *)sender {
    NSString *password = _password.text;
    NSString *repassword = _rePassword.text;
    NSString *userName = _userName.text;
    
    if ([password isEqual:repassword] && password.length > 0 && userName.length > 0) {
        
        DppXMPP *xmpp = [DppXMPP shared];
        [xmpp registerJID:self.userName.text passWord:self.password.text];
        if (_isSuccess) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            
            self.label.text = @"注册失败";
        }
    }
}

//其他方式登陆
- (IBAction)weiBoLoginAction:(UITapGestureRecognizer *)sender {
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate weiBoLogin];
}


@end
