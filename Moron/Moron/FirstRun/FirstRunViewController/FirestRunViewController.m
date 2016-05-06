//
//  FirestRunViewController.m
//  Moron
//
//  Created by bever on 16/4/11.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "FirestRunViewController.h"
#import "LogInViewController.h"
#import "RegisterViewController.h"

@interface FirestRunViewController ()

@end

@implementation FirestRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //创建UIImageView
    [self createBgImageView];
    
    //创建按钮
    [self createButton];
}

//创建UIImageView
- (void)createBgImageView {

    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bgImageView];
    bgImageView.image = [UIImage imageNamed:@"firestViewBg.jpg"];
}

//创建createButton
- (void)createButton {

    //登陆按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(80, kScreenH-200, kScreenW-160, 40);
    [loginButton setBackgroundImage:[[UIImage imageNamed:@"button_title"] stretchableImageWithLeftCapWidth:30 topCapHeight:15]
                           forState:UIControlStateNormal];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(logInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    //注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(80, kScreenH-140, kScreenW-160, 40);
    [registerButton setBackgroundImage:[[UIImage imageNamed:@"button_title"] stretchableImageWithLeftCapWidth:30 topCapHeight:15]
                              forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    
}

- (void)logInAction:(UIButton *)button {
    
    LogInViewController *logInViewController = [[LogInViewController alloc] init];
    
    [self.navigationController pushViewController:logInViewController animated:YES];
}

- (void)registerAction:(UIButton *)button {
    
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerViewController animated:YES];
}

//导航栏的隐藏
- (void)viewWillAppear:(BOOL)animated {

    self.navigationController.navigationBar.hidden = YES;
}

@end
