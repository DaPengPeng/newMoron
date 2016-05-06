//
//  LeftViewController.m
//  Moron
//
//  Created by bever on 16/3/20.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftViewControllerCell.h"
#import "AppDelegate.h"

@interface LeftViewController () {

    NSMutableArray *_dataList;
    
    BOOL _selected;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _button.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.45];
    _button.tintColor = [UIColor blackColor];
    _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
    _walkMeters.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
    
    //相关信息的显示
    [self showSomething];
    
    [self settingTableView];
    
    [self loadData];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)timerAction:(NSTimer *)timer {

    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    _walkMeters.text = [NSString stringWithFormat:@"今日步数为：%.0f步。",appDelegate.walkMetre*2.1];
}

- (void)showSomething {

    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/userInfo.plist"];
    
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *dic = [unarchiver decodeObject];
    [unarchiver finishDecoding];
    UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:dic];
    
    self.userImage.layer.cornerRadius = 30;
    self.userImage.clipsToBounds = YES;
    
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:userInfo.profile_image_url]];
    self.adressLabel.text = userInfo.location;
    self.wheatherLabel.text = @"21°";
    self.nameLabel.text = userInfo.screen_name;
}

- (void)settingTableView {

    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

//数据的加载
- (void)loadData {
    
    //数据的筛选
    
    _dataList = [[NSMutableArray alloc] init];
    //本地数据（存储）的读取
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/myClasses.plist"];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data) {//这里因为保存的是数组，解析出来也是数组。
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSMutableArray *array = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        
        for (NSMutableDictionary *muDic in array) {
            NSMutableDictionary *classDic = [[NSMutableDictionary alloc] init];
            NSMutableArray *items = [[NSMutableArray alloc] init];
            NSArray *array = muDic[@"item"];
            for (NSDictionary *dic in array) {
                
                if ([dic[@"isMyClass"] boolValue]) {
                    
                    
                    [items addObject:dic];
                }
            }
            [classDic setObject:items forKey:muDic[@"name"]];
            [_dataList addObject:classDic];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dic = _dataList[section];
    NSArray *keys = [dic allKeys];
    NSArray *array = dic[keys[0]];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeftViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftViewControllerCell"];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LeftViewControllerCell" owner:nil options:nil] firstObject];
    }
    NSDictionary *dic = _dataList[indexPath.section];
    NSArray *keys = [dic allKeys];
    NSArray *array = dic[keys[0]];
    NSDictionary *itemDic = array[indexPath.item];
    cell.itemName.text = itemDic[@"name"];
    return cell;
}

//状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}


- (IBAction)myInfoAction:(UIButton *)sender {
}



- (IBAction)buttonAction:(UIButton *)sender {
    
    _selected = !_selected;
    if (_selected) {
        
        _button.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.45];
        [_button setTitle:@"已打卡" forState:UIControlStateNormal];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (UIView *view in _tableView.subviews[0].subviews) {
            
            if ([view isKindOfClass:[LeftViewControllerCell class]]) {
                
                LeftViewControllerCell *cell = (LeftViewControllerCell *)view;
                NSDictionary *dic = @{@"itemName":cell.itemName.text,@"groupCount":cell.groupCount.text,@"weight":cell.weight.text,@"count":cell.count.text,@"time":cell.time.text};
                [array addObject:dic];
            }
        }
        
        NSMutableDictionary *recordDic = [[NSMutableDictionary alloc] init];
        [recordDic setObject:array forKey:@"array"];
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/record.plist"];
        //数组的保存
        
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:recordDic];
        [archiver finishEncoding];
        BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
        if (isSuccess) {
            NSLog(@"保存成功");
        }else {
            NSLog(@"保存失败");
        }
    }else {
    
        _button.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.45];
        [_button setTitle:@"打卡" forState:UIControlStateNormal];
    }
    
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self loadData];
    [_tableView reloadData];
}

@end
