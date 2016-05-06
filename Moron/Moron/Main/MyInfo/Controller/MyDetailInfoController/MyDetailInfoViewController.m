//
//  MyDetailInfoViewController.m
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyDetailInfoViewController.h"
#import "MyDetailInfoModel.h"
#import "EditMyInfoTableViewCell.h"

@interface MyDetailInfoViewController () {

    UITableView *_tableView;
}

@end

@implementation MyDetailInfoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"个人资料";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"chat_bg_default.jpg"]]];
    
    //数据的加载
    [self loadData];
    
    //创建tableView
    [self createTableView];
}


//数据的加载
- (void)loadData {
    _dataDic = [[NSMutableDictionary alloc] init];
    _dataList = @[@"section0",@"section1",@"section2",@"section3",@"section4",@"section5",@"section6"];
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/userInfo.plist"];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *dic = [unarchiver decodeObject];
    [unarchiver finishDecoding];
    UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:dic];
    
    MyDetailInfoModel *model1 = [[MyDetailInfoModel alloc] initWithDictionary:@{@"title":userInfo.profile_image_url,@"content":@"更换头像",@"type":@1}];
    MyDetailInfoModel *model2 = [[MyDetailInfoModel alloc] initWithDictionary:@{@"title":@"昵称:",@"content":userInfo.screen_name,@"type":@2}];
    MyDetailInfoModel *model3 = [[MyDetailInfoModel alloc] initWithDictionary:@{@"title":@"性别:",@"content":@"男",@"type":@2}];
    MyDetailInfoModel *model4 = [[MyDetailInfoModel alloc] initWithDictionary:@{@"title":@"出生年月:",@"content":@"1980.05.05",@"type":@3}];
    MyDetailInfoModel *model5 = [[MyDetailInfoModel alloc] initWithDictionary:@{@"title":@"所在城市:",@"content":@"加拿大-温哥华",@"type":@3}];
    MyDetailInfoModel *model6 = [[MyDetailInfoModel alloc] initWithDictionary:@{@"title":@"身高:",@"content":@"186",@"type":@2}];
    MyDetailInfoModel *model7 = [[MyDetailInfoModel alloc] initWithDictionary:@{@"title":@"体重:",@"content":@"80kg",@"type":@2}];
    MyDetailInfoModel *model8 = [[MyDetailInfoModel alloc] initWithDictionary:@{@"title":@"BMI:",@"content":@"未添加",@"type":@2}];
    MyDetailInfoModel *model9 = [[MyDetailInfoModel alloc] initWithDictionary:@{@"title":@"简介",@"content":@"",@"type":@4}];
    
    [_dataDic setObject:@[model1] forKey:@"section0"];
    [_dataDic setObject:@[model2] forKey:@"section1"];
    [_dataDic setObject:@[model3] forKey:@"section2"];
    [_dataDic setObject:@[model4] forKey:@"section3"];
    [_dataDic setObject:@[model5] forKey:@"section4"];
    [_dataDic setObject:@[model6,model7,model8] forKey:@"section5"];
    [_dataDic setObject:@[model9] forKey:@"section6"];
    
    
}

//创建tableView
- (void)createTableView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark - UITableDataSourceDelegate
//单元格个数的返回
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *array = [_dataDic objectForKey:_dataList[section]];
    return array.count;
}

//单元格内容的返回
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [_dataDic objectForKey:_dataList[indexPath.section]];
    MyDetailInfoModel *model = array[indexPath.row];
    if (indexPath.section == 0) {
        
        EditMyInfoTableViewCell *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"EditMyInfoTableViewCell" owner:nil options:nil] firstObject];
        cell1.model = model;
        return cell1;
    }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 5) {
    
        EditMyInfoTableViewCell *cell2 = [[[NSBundle mainBundle] loadNibNamed:@"EditMyInfoTableViewCell" owner:nil options:nil] objectAtIndex:1];
        cell2.model = model;
        return cell2;
    }else if (indexPath.section == 3 || indexPath.section == 4) {
    
        EditMyInfoTableViewCell *cell3 = [[[NSBundle mainBundle] loadNibNamed:@"EditMyInfoTableViewCell" owner:nil options:nil] objectAtIndex:2];
        cell3.model = model;
        return cell3;
    }else {
    
        EditMyInfoTableViewCell *cell4 = [[[NSBundle mainBundle] loadNibNamed:@"EditMyInfoTableViewCell" owner:nil options:nil] lastObject];
        cell4.model = model;
        return cell4;
    }
    return nil;
}

//单元格组数的返回
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataList.count;
}

//单元格高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 6) {
        
        return 160;
    }
    return 44;
}

//头视图高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 14;
}

//尾视图高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 1;
}

@end
