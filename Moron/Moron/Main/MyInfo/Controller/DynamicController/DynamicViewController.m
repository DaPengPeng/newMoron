//
//  DynamicViewController.m
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "DynamicViewController.h"
#import "SelfDynamicModel.h"
#import "SelfDynamicViewCell.h"
#import "DynamicDetailViewController.h"
#import "PhotoView.h"

@interface DynamicViewController () {

    NSMutableArray *_dataList;
    
    UITableView *_tableView;
}

@end

@implementation DynamicViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我的动态";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //加载数据
    [self loadData];
    
    //创建tableView
    [self createTabelView];

}

//加载数据
- (void)loadData {
    
    //dynamicViewDataList
    _dataList = [[NSMutableArray alloc] init];
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/selfDynamic.plist"];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDictionary *dic = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        NSArray *array = dic[@"statuses"];
        for (NSDictionary *dic in array) {
            
            SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
            [_dataList addObject:model];
        }
    }
    
    if (kAccessToken) {
        
        _dataList = [[NSMutableArray alloc] init];
        [DppNetworking GET:@"https://api.weibo.com/2/statuses/user_timeline.json" parmeters:@{@"access_token":kAccessToken} resulteBlock:^(id resulte) {
            
            NSArray *array = resulte[@"statuses"];
            for (NSDictionary *dic in array) {
                
                SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
                [_dataList addObject:model];
            }
            [_tableView reloadData];
        } withFilePath:filePath];
    }
    
}

//创建tableView
- (void)createTabelView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-104)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - UITabelViewDataSource
//单元格个数的返回
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
}

//单元格的返回
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SelfDynamicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelfDynamicViewCell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SelfDynamicViewCell" owner:nil options:nil] firstObject];
    }
    cell.model = _dataList[indexPath.row];
    return cell;
}

//单元格的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DynamicDetailViewController *dynamicDetailViewController = [[DynamicDetailViewController alloc] init];
    dynamicDetailViewController.model = _dataList[indexPath.row];
    
    [self.navigationController pushViewController:dynamicDetailViewController animated:YES];
}



//单元格高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取model数据
    SelfDynamicModel *model = _dataList[indexPath.row];
    
    //自己发送的话的高度自适应
    CGFloat selfSpeakH = 0;
    if (model.text) {
        
        CNLabel *label = [[CNLabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW-16, 0)];
        //设置文本
        label.text = [NSString stringWithFormat:@"%@",model.text];
        selfSpeakH = label.height;
        
    }
    
    //photoView
    CGFloat selfPhotosH = 0;
    if ([model.pic_urls count] > 0) {
        
        BOOL hasY = [model.pic_urls count]%3;
        selfPhotosH = ((kScreenW-15*2-20))/3*(([model.pic_urls count]/3)+1*hasY)+((([model.pic_urls count]/3)+1*hasY)-1)*15+12;
    }
    
    //转发内容的高度
    int repostVH = 0;
    if (model.retweetedModel) {
        
        //创建微博View对象
        SelfDynamicContentView *reweetedView = [[SelfDynamicContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-16, 0)];
        
        //调用setWbModel方法 用来获取高度
        reweetedView.model = model.retweetedModel;
        
        repostVH = reweetedView.height;
        
    }
    
    return 90+selfPhotosH+selfSpeakH+repostVH;
}

@end
