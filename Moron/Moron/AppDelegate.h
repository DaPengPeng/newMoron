//
//  AppDelegate.h
//  Moron
//
//  Created by bever on 16/3/19.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,assign) CLLocationCoordinate2D cooordinate;//位置的获取

@property (nonatomic,assign) CGFloat walkMetre;

- (void)weiBoLogin;

@end

