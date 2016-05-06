//
//  MyInfoSuperViewController.m
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyInfoSuperViewController.h"

@interface MyInfoSuperViewController ()

@end

@implementation MyInfoSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addCustomBackButton];
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


//标签栏的隐藏
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    self.tabBarController.tabBar.hidden = YES;
    
}



@end
