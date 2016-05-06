//
//  MyInfoTableViewController.m
//  Moron
//
//  Created by bever on 16/3/20.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyInfoTableViewController.h"
#import "MyInfoModel.h"
#import "MyInfoTableViewCell.h"
#import "UserInfoViewController.h"
#import "SettingViewController.h"

@interface MyInfoTableViewController () {

    UITableView *_tableView;
}

@end

@implementation MyInfoTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"User.ico"];
        self.title = @"我的";
        
        //添加默认数据
        [self addDefultData];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    //添加设置按钮
    [self addSettingButton];
    
    //更新用户信息
    [self upDateUserInfo];

    //创建tableView
    [self creareTableView];
}

//添加自定义设置按钮
- (void)addSettingButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setImage:[UIImage imageNamed:@"sidebar_setting"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

//设置按钮的相应事件
- (void)settingButtonAction:(UIButton *)button {
    
    SettingViewController *settingController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingController animated:YES];
}

//添加默认数据
- (void)addDefultData {
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/userInfo.plist"];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *dic = [unarchiver decodeObject];
    UserInfo *userInfoShow = [[UserInfo alloc] initWithDictionary:dic];

    NSString *userName = userInfoShow.screen_name;
    NSString *userImageUrl = userInfoShow.profile_image_url;
    NSString *userInfoDescription = userInfoShow.userInfoDescription;
    
    NSString *title1 = @"训练等级";
    NSString *title2 = @"我的成就";
    NSString *title3 = @"我的收藏";
    NSString *title4 = @"个人资料";
    
    NSString *image1 = @"";
    NSString *image2 = @"";
    NSString *image3 = @"";
    NSString *image4 = @"";
    
    //用户信息的封装
    NSDictionary *userInfo = @{@"title":userName,@"image":userImageUrl,@"type":@1,@"title2":userInfoDescription,@"controller":@"UserInfoViewController"};
    MyInfoModel *userModel = [[MyInfoModel alloc] initWithDictionary:userInfo];
    
    //关注、粉丝、动态单元格数据的封装
    NSDictionary *countLabels = @{@"fansCount":userInfoShow.followers_count,@"focusCount":userInfoShow.friends_count,@"dynamicCount":userInfoShow.statuses_count,@"type":@2};
    MyInfoModel *countLabelsModel = [[MyInfoModel alloc] initWithDictionary:countLabels];
    
    //各个项目的数据的封装
    NSDictionary *obj1 = @{@"title":title1,@"image":image1,@"type":@3,@"controller":@"MyLevelViewController"};
    NSDictionary *obj2 = @{@"title":title2,@"image":image2,@"type":@3,@"controller":@"MyBadgeViewController"};
    NSDictionary *obj3 = @{@"title":title3,@"image":image3,@"type":@3,@"controller":@"MyFavoriteViewController"};
    NSDictionary *obj4 = @{@"title":title4,@"image":image4,@"type":@3,@"controller":@"MyDetailInfoViewController"};
    MyInfoModel *model1 = [[MyInfoModel alloc] initWithDictionary:obj1];
    MyInfoModel *model2 = [[MyInfoModel alloc] initWithDictionary:obj2];
    MyInfoModel *model3 = [[MyInfoModel alloc] initWithDictionary:obj3];
    MyInfoModel *model4 = [[MyInfoModel alloc] initWithDictionary:obj4];
    
    //数据组的封装
    NSArray *section0 = @[userModel,countLabelsModel];
    NSArray *section1 = @[model1,model2];
    NSArray *section2 = @[model3,model4];
    _dataDic = [NSMutableDictionary dictionaryWithDictionary:@{@"section0":section0,@"section1":section1,@"section2":section2}];
    
    _dataList = [NSMutableArray arrayWithArray:@[@"section0",@"section1",@"section2"]];
}

//userInfo的更新
- (void)upDateUserInfo {

    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/userInfo.plist"];
    //用户信息的获取
    [DppNetworking GET:@"https://api.weibo.com/2/users/show.json"
             parmeters:@{@"access_token":kAccessToken,@"uid":kUid} resulteBlock:^(id resulte) {
                 
                 //用户信息的封装
                 UserInfo *userInfoShow = [[UserInfo alloc] initWithDictionary:resulte];
                 
                 NSString *userName = userInfoShow.screen_name;
                 NSString *userImageUrl = userInfoShow.profile_image_url;
                 NSString *userInfoDescription = userInfoShow.userInfoDescription;
                 
                 //用户信息的封装
                 NSDictionary *userInfo = @{@"title":userName,@"image":userImageUrl,@"type":@1,@"title2":userInfoDescription,@"controller":@"UserInfoViewController"};
                 MyInfoModel *userModel = [[MyInfoModel alloc] initWithDictionary:userInfo];
                 
                 //关注、粉丝、动态单元格数据的封装
                 NSDictionary *countLabels = @{@"fansCount":userInfoShow.followers_count,@"focusCount":userInfoShow.friends_count,@"dynamicCount":userInfoShow.statuses_count,@"type":@2};
                 MyInfoModel *countLabelsModel = [[MyInfoModel alloc] initWithDictionary:countLabels];
                 
                 NSArray *section0 = @[userModel,countLabelsModel];
                 
                 [_dataDic setObject:section0 forKey:@"section0"];
                 [_tableView reloadData];
                 
             } withFilePath:filePath];
}

//创建tableView
- (void)creareTableView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-49)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataList.count;
}

//返回单元格数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *array = [_dataDic objectForKey:_dataList[section]];
    return array.count;
}

//返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            
            MyInfoTableViewCell *cell2 = [[[NSBundle mainBundle] loadNibNamed:@"MyInfoTableViewCell" owner:nil options:nil] objectAtIndex:1];
            NSArray *array = _dataDic[_dataList[indexPath.section]];
            cell2.model = array[indexPath.row];
            return cell2;
        }else {
        
            MyInfoTableViewCell *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"MyInfoTableViewCell" owner:nil options:nil] firstObject];
            NSArray *array = _dataDic[_dataList[indexPath.section]];
            cell1.model = array[indexPath.row];
            return cell1;
        }
    }else {
    
        MyInfoTableViewCell *cell3 = [[[NSBundle mainBundle] loadNibNamed:@"MyInfoTableViewCell" owner:nil options:nil] lastObject];
        NSArray *array = _dataDic[_dataList[indexPath.section]];
        cell3.model = array[indexPath.row];
        return cell3;
    }
}

//单元格的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [_dataDic objectForKey:_dataList[indexPath.section]];
    MyInfoModel *model = array[indexPath.row];
    UIViewController *controller = [[NSClassFromString(model.controller) alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            return 70;//第一组第一个单元格返回70
        }else {
        
            return 55;//第一组第二个单元格返回55
        }
    }
    return 44;
}

//头视图高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        
        return 0;
    }
    return 30;
}


//标签栏的显示
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    self.tabBarController.tabBar.hidden = NO;
    
    [self upDateUserInfo];
    
}




@end
