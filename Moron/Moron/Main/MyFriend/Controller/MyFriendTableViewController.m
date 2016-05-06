//
//  MyFriendTableViewController.m
//  Moron
//
//  Created by bever on 16/3/20.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyFriendTableViewController.h"
#import "SelfDynamicContentView.h"
#import "SelfDynamicViewCell.h"
#import "SelfDynamicModel.h"
#import "PhotoView.h"
#import "CNLabel.h"
#import "DynamicDetailViewController.h"
#import "SendWeiBoViewController.h"

@interface MyFriendTableViewController ()

@end

@implementation MyFriendTableViewController {
    
    UIScrollView *_scrollView;//滑动视图
    
    UITableView *_myTableView;//好友的动态视图
    
    NSMutableArray *_myDataList;//好友的动态的数据
    
    UITableView *_publicTableView;//公共动态
    
    NSMutableArray *_publicDataList;//公共动态数据
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"Flag.ico"];
        self.tabBarItem.title = @"动态";
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加导航栏中部按钮视图
    [self addButtonsView];
    
    //添加头像
    [self addUserIconButton];
    
    //创建scrollView
    [self createscrllView];
    
    //加载数据
    [self loadData];
    
    //创建myTableView
    [self createMyTabelView];
    
    //创建publicTableView
    [self createPublicTableView];
}

//添加导航栏中部按钮视图
- (void)addButtonsView {

    ButtonsView *buttonsView = [[ButtonsView alloc] initWithFrame:CGRectMake((kScreenW-120)/2, 12, 120, 20) withTitleArray:@[@"我的",@"广场"] withSelectedImage:nil];
    buttonsView.tag = 100;
    buttonsView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:buttonsView];
    
    buttonsView.buttonBlock = ^(NSInteger index) {
        
        [UIView animateWithDuration:0.3f animations:^{
            
            _scrollView.contentOffset = CGPointMake(kScreenW*index, 0);
        }];
    };
}

//导航栏左侧按钮的创建
- (void)addUserIconButton {
    
    UserIconImageView *userImageView = [[UserIconImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:userImageView];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//创建scrollView
- (void)createscrllView {

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64)];
    [self.view addSubview:_scrollView];
    
    //scrollView的设置
    _scrollView.contentSize = CGSizeMake(kScreenW*2, 0);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
}

//加载数据
- (void)loadData {
    
    //myTbaleDataList
    //本地数据的读取
    _myDataList = [[NSMutableArray alloc] init];
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/friendsDynamic.plist"];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDictionary *dic = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        NSArray *array = dic[@"statuses"];
        for (NSDictionary *dic in array) {
            
            SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
            [_myDataList addObject:model];
        }
    }
    
    //更新网络数据
    if (kAccessToken) {
        
        [DppNetworking GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parmeters:@{@"access_token":kAccessToken} resulteBlock:^(id resulte) {
            
            _myDataList = [[NSMutableArray alloc] init];
            NSArray *array = resulte[@"statuses"];
            for (NSDictionary *dic in array) {
                
                SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
                [_myDataList addObject:model];
            }
            [_myTableView reloadData];
        } withFilePath:filePath];
    }
    
    //publicDataList
    _publicDataList = [[NSMutableArray alloc] init];
    NSString *pFilePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/publicDynamic.plist"];
    //信息的读取
    NSData *pData = [NSData dataWithContentsOfFile:pFilePath];
    if (pData) {
        
        NSKeyedUnarchiver *pUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:pData];
        NSDictionary *pDic = [pUnarchiver decodeObject];
        [pUnarchiver finishDecoding];
        NSArray *pArray = pDic[@"statuses"];
        for (NSDictionary *dic in pArray) {
            
            SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
            [_publicDataList addObject:model];
        }
    }

    if (kAccessToken) {
        
        [DppNetworking GET:@"https://api.weibo.com/2/statuses/public_timeline.json" parmeters:@{@"access_token":kAccessToken} resulteBlock:^(id resulte) {
            
            _publicDataList = [[NSMutableArray alloc] init];
            NSArray *array = resulte[@"statuses"];
            for (NSDictionary *dic in array) {
                
                SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
                [_publicDataList addObject:model];
            }
            
            [_publicTableView reloadData];
        } withFilePath:pFilePath];
    }
}

//创建myTableView
- (void)createMyTabelView {

    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-49)];
    [_scrollView addSubview:_myTableView];
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //创建发微博按钮
    [self createSendWeiBoButton];
}

//创建发微博按钮
- (void)createSendWeiBoButton {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenW-60, kScreenH-49-64-60, 50, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"write"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 25;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];
}

- (void)buttonAction:(UIButton *)button {

    SendWeiBoViewController *sendWeiBoVC = [[SendWeiBoViewController alloc] init];
    [self.navigationController pushViewController:sendWeiBoVC animated:YES];
}

//创建publicTableView
- (void)createPublicTableView {

    _publicTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenW, 0, kScreenW, kScreenH-64-49)];
    [_scrollView addSubview:_publicTableView];
    
    _publicTableView.delegate = self;
    _publicTableView.dataSource = self;
    _publicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _myTableView) {
        
        return _myDataList.count;
    }else {
    
        return _publicDataList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SelfDynamicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SelfDynamicViewCell" owner:nil options:nil] firstObject];
    }
    
    if (tableView == _myTableView) {
        
        cell.model = _myDataList[indexPath.row];
    }else {
    
        cell.model = _publicDataList[indexPath.row];
    }
    
    return cell;
}

//单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == _myTableView) {
        
        DynamicDetailViewController *detailViewController = [[DynamicDetailViewController alloc] init];
        SelfDynamicModel *model = _myDataList[indexPath.row];
        detailViewController.model = model;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }else if (tableView == _publicTableView) {
    
        DynamicDetailViewController *detailViewController = [[DynamicDetailViewController alloc] init];
        SelfDynamicModel *model = _publicDataList[indexPath.row];
        detailViewController.model = model;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

//单元格高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _myTableView) {
        //获取model数据
        SelfDynamicModel *model = _myDataList[indexPath.row];
        
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
    }else {
    
    
        //获取model数据
        SelfDynamicModel *model = _publicDataList[indexPath.row];
        
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
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    //scrollView的滑动对按钮的改变
    if (scrollView == _scrollView) {
        
        NSInteger index = scrollView.contentOffset.x/kScreenW;
        
        //防止数组越界的安全判断
        if (index > 1) {
            index = 1;
        }
        if (index < 0) {
            index = 0;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kIdenxChange object:nil userInfo:@{@"index":@(index)}];
    }
}

//导航控制器上的自定义按钮的隐藏与显示
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    ButtonsView *buttonsView = [self.navigationController.navigationBar viewWithTag:100];
    buttonsView.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    ButtonsView *buttonsView = [self.navigationController.navigationBar viewWithTag:100];
    buttonsView.hidden = YES;
}

@end
