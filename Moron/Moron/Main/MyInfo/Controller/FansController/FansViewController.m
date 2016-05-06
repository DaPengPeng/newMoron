//
//  FansViewController.m
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "FansViewController.h"
#import "FocusModel.h"
#import "FocusTabeViewCell.h"

@interface FansViewController () {

    NSMutableArray *_fansDataList;
    
    UITableView *_tableView;
}

@end

@implementation FansViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我的粉丝列表";
        self.view.backgroundColor = [UIColor whiteColor];
        //加载数据
        [self loadData];
    }
    return self;
}

//数据的加载
- (void)loadData {
    
    _fansDataList = [[NSMutableArray alloc] init];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/selfFans.plist"];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDictionary *dic = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        NSArray *users = dic[@"users"];
        
        for (NSDictionary *dic in users) {
            
            FocusModel *focusModel = [[FocusModel alloc] initWithDictionary:dic];
            
            [_fansDataList addObject:focusModel];
        }
    }
    
    [DppNetworking GET:@"https://api.weibo.com/2/friendships/followers.json" parmeters:@{@"access_token":kAccessToken,@"uid":kUid,@"count":@200,@"trim_status":@0} resulteBlock:^(id resulte) {
        
        _fansDataList = [[NSMutableArray alloc] init];
        NSArray *users = resulte[@"users"];
        
        for (NSDictionary *dic in users) {
            
            FocusModel *focusModel = [[FocusModel alloc] initWithDictionary:dic];
            
            [_fansDataList addObject:focusModel];
        }
        [_tableView reloadData];
    } withFilePath:filePath];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //tableView的创建
    [self createTableView];
}

//tableView的创建
- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [self.view addSubview:_tableView];
    
    //tableView的设置
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _fansDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FocusTabeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusTabeViewCell"];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FocusTabeViewCell" owner:nil options:nil] firstObject];
    }
    cell.focusModel = _fansDataList[indexPath.row];
    return cell;
}

//单元格高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
}

@end
