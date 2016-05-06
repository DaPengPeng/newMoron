//
//  NearbyViewController.m
//  Moron
//
//  Created by bever on 16/4/28.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "NearbyViewController.h"
#import "AppDelegate.h"
#import "SelfDynamicModel.h"
#import <CoreLocation/CoreLocation.h>

@interface NearbyViewController (){

    UITableView *_tableView;
    
    NSMutableArray *_dataList;
}


@end

@implementation NearbyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"附近的人";
    
    //创建tableView
    [self createTableView];
    
    //下载数据
    [self loadData];
}

//下载数据
- (void)loadData {

    //本地数据的读取
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"Documents/nearByFriends.plist"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data) {
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDictionary *dic = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        _dataList = [[NSMutableArray alloc] init];
        NSArray *array = dic[@"users"];
        for (NSDictionary *dic in array) {
            
            SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
            [_dataList addObject:model];
        }

    }
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    CLLocationCoordinate2D corrdinate = appDelegate.cooordinate;
    
    [DppNetworking GET:@"https://api.weibo.com/2/place/nearby_users/list.json" parmeters:@{@"access_token":kAccessToken,@"lat":@(corrdinate.latitude),@"long":@(corrdinate.longitude)} resulteBlock:^(id resulte) {
        
        _dataList = [[NSMutableArray alloc] init];
        NSArray *array = resulte[@"users"];
#warning 高级接口，审核开发者资质
        
        for (NSDictionary *dic in array) {
            
            SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
            [_dataList addObject:model];
        }
    } withFilePath:path];
}

- (void)createTableView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //头视图的创建
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 170)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:headerView.bounds];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"1_110903221016_1.gif"];
    [headerView addSubview:imageView];
    _tableView.tableHeaderView = headerView;
}

#pragma mark - UITabelDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

@end
