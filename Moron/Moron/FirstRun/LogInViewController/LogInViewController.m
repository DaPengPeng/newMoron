//
//  LogInViewController.m
//  Moron
//
//  Created by bever on 16/4/11.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "LogInViewController.h"
#import "WeiboSDK.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@interface LogInViewController ()
@end

@implementation LogInViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置button的背景图片
    [_loginButton setBackgroundImage:[[UIImage imageNamed:@"button_title.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:15] forState:UIControlStateNormal];
    
    //自定返回按钮
    [self addCustomBackButton];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"登陆";
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

- (IBAction)loginAction:(UIButton *)sender {
}

- (IBAction)frogetPasswordAction:(UIButton *)sender {
}

- (IBAction)registerAction:(UIButton *)sender {
}

- (IBAction)weiBoLoginAction:(UITapGestureRecognizer *)sender {
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate weiBoLogin];
}


@end
