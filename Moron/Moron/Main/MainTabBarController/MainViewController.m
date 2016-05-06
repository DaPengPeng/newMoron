//
//  MainViewController.m
//  Moron
//
//  Created by bever on 16/3/19.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MainViewController.h"
#import "CustomTabBarController.h"
#import "BaseNavigationController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"

#define kLeftViewWidth [UIScreen mainScreen].bounds.size.width*0.78

@interface MainViewController () {

    BOOL _isGo;
}

@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"训练";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

//实例控制器
- (void)initControllers {

    //实例控制器
    CustomTabBarController *tabBarController = [[CustomTabBarController alloc] init];
    
    NSArray *controllerNameArray = @[@"ExerciseTableViewController",@"DiscoverController",@"MyFriendTableViewController",@"MyInfoTableViewController"];
    
    NSMutableArray *controllerArray = [[NSMutableArray alloc] init];
    for (NSString *controllerName in controllerNameArray) {
        
        UIViewController *controller = [[NSClassFromString(controllerName) alloc] init];
        BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:controller];
        [controllerArray addObject:navigationController];
    }
    
    tabBarController.viewControllers = controllerArray;
    
    LeftViewController *leftViewController = [[LeftViewController alloc] init];
    //实例抽屉效果控制器
    
    MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:tabBarController leftDrawerViewController:leftViewController];

    //设置
    //设置左侧视图打开方式
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    //设置左侧视图关闭方法
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    //设置左视图宽度
    [drawerController setMaximumLeftDrawerWidth:kLeftViewWidth];
    //设置阴影
    [drawerController setShowsShadow:NO];

    [[UIApplication sharedApplication].delegate window].rootViewController = drawerController;
    
    
}

@end
