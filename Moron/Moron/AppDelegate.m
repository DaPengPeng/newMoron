//
//  AppDelegate.m
//  Moron
//
//  Created by bever on 16/3/19.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "AppDelegate.h"
#import "FirestRunViewController.h"
#import "MainViewController.h"
#import "BaseNavigationController.h"
#import "WeiboSDK.h"

@interface AppDelegate ()<WeiboSDKDelegate,CLLocationManagerDelegate> {

    CLLocation *preLocation;
}

@property (nonatomic,retain) CLLocationManager *locationManager;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
 
    //实例主窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //判断是否是首次运行app
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *accessToken = [userDefaults valueForKey:@"accessToken"];
    if (!accessToken) {
    
        [self.locationManager startUpdatingLocation];//开启定位
        //实例初次运行控制器
        FirestRunViewController *firestRunViewController = [[FirestRunViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:firestRunViewController];
        self.window.rootViewController = navigationController;
    
    }else {
        
        [self.locationManager startUpdatingLocation];//开启定位
        //实例主控制器
        MainViewController *mainViewController = [[MainViewController alloc] init];
        [mainViewController initControllers];
    
    }
    return YES;
}

- (CLLocationManager *)locationManager {
    
    if (!_locationManager) {
        
        _locationManager =[[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
        
        //前台授权（默认情况下不可以在后台获取位置，勾选后台模式 location upData 但是会出现蓝条）（background modes）中的location pData
        //NSLocationWhenInUseUsageDescription info 文件中必须设置这个key
        //[_locationManager requestWhenInUseAuthorization];//请求使用应用的时候定位
        
        //前后台定位授权
        //+authorzationStatus != kCLAutorizationStatusNotDetaramined
        //这个方法不会有效（用户拒绝了请求或者请求未通过）
        //当前的授权状态为前台授权时此方法也会有效
        [_locationManager requestAlwaysAuthorization];
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 9.0) {
        
        _locationManager.allowsBackgroundLocationUpdates = YES;
        NSLog(@"定位开启了");
    }
    return _locationManager;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    //这个方法一直调用
    CLLocation *location = [locations firstObject];
    
    _cooordinate = location.coordinate;
    
    if (preLocation) {
        
        if (location.speed < 4.0) {
            
            CLLocationDistance metres = [location distanceFromLocation:preLocation];
            _walkMetre = _walkMetre + metres;
        }else {
        
            preLocation = nil;//位置的重置
        }
        
    }
    preLocation = location;
}

- (void)weiBoLogin {

    //错误捕捉
    @try{
        
        [self author];
    }
    @catch(NSException *exception) {
        NSLog(@"exception:%@", exception);
    }
    @finally {
        
    }
}

//授权认证
- (void)author {
    
    //开启调试模式
    [WeiboSDK enableDebugMode:YES];
    
    //注册appkey
    [WeiboSDK registerApp:kAppkey];
    
    NSString *accessToken = kAccessToken;
    
    NSDate *overDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"overDate"];
    NSTimeInterval time = [overDate timeIntervalSinceNow];
    if (!accessToken || time <= 0) {
        
        //初始化请求
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        
        //设置授权回调页
        request.redirectURI = kRedirectURI;
        
        //设置权限
        request.scope = @"all";
        
        [WeiboSDK sendRequest:request];
    }
}

#pragma mark - WeiBoSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
    
}

//授权成功后调用该方法，并且带有相应信息
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
    NSString *accessToken = [(WBAuthorizeResponse *)response accessToken];
    
    //accessToken的存储
    [[NSUserDefaults standardUserDefaults]setObject:accessToken forKey:@"accessToken"];
    
    //accessToken有效时间的存储
    NSDate *overDate = [(WBAuthorizeResponse *)response expirationDate];
    [[NSUserDefaults standardUserDefaults] setObject:overDate forKey:@"overDate"];
    
    //存储uid
    NSString *uid = [(WBAuthorizeResponse *)response userID];
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/userInfo.plist"];
    //用户信息的获取
    [DppNetworking GET:@"https://api.weibo.com/2/users/show.json"
             parmeters:@{@"access_token":kAccessToken,@"uid":kUid} resulteBlock:^(id resulte) {
                 
                 //实例主控制器
                 MainViewController *mainViewController = [[MainViewController alloc] init];
                 [mainViewController initControllers];
             } withFilePath:path];
    
}


//跳转到授权回调页
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [WeiboSDK handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    
//    return YES;
//}

@end


