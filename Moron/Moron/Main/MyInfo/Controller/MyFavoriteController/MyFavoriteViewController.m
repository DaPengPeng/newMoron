//
//  MyFavoriteViewController.m
//  Moron
//
//  Created by bever on 16/4/25.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MyFavoriteViewController.h"
#import "SelfDynamicModel.h"
#import "SelfDynamicViewCell.h"
#import "DynamicDetailViewController.h"
#import "PhotoView.h"

@interface MyFavoriteViewController () {

    NSMutableArray *_myFavotiteDataList;
}

@end

@implementation MyFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addCustomBackButton];
    
    //标题的设置
    self.title = @"我的收藏";
    
    //数据的加载
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//数据的加载
- (void)loadData {
    _myFavotiteDataList = [[NSMutableArray alloc] init];
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/myFavorite.plist"];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data) {
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDictionary *dic = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        NSArray *favoritesArray = dic[@"favorites"];
        
        for (NSDictionary *dic in favoritesArray) {
            
            NSDictionary *favoritesDic = dic[@"status"];
            SelfDynamicModel *favoritesModel = [[SelfDynamicModel alloc] initWithDictionary:favoritesDic];
            [_myFavotiteDataList addObject:favoritesModel];
            
        }
    }
    
    [DppNetworking GET:@"https://api.weibo.com/2/favorites.json" parmeters:@{@"access_token":kAccessToken} resulteBlock:^(id resulte) {
        
        _myFavotiteDataList = [[NSMutableArray alloc] init];
        NSArray *favoritesArray = resulte[@"favorites"];
        
        for (NSDictionary *dic in favoritesArray) {
            
            NSDictionary *favoritesDic = dic[@"status"];
            SelfDynamicModel *favoritesModel = [[SelfDynamicModel alloc] initWithDictionary:favoritesDic];
            [_myFavotiteDataList addObject:favoritesModel];
            
        }
        [self.tableView reloadData];
    } withFilePath:path];
}

//下拉刷新
-(void)pushRefreshData {
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/myFavorite.plist"];
    
    [DppNetworking GET:@"https://api.weibo.com/2/favorites.json" parmeters:@{@"access_token":kAccessToken} resulteBlock:^(id resulte) {
        
        NSArray *favoritesArray = resulte[@"favorites"];
        
        _myFavotiteDataList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in favoritesArray) {
            
            NSDictionary *favoritesDic = dic[@"status"];
            SelfDynamicModel *favoritesModel = [[SelfDynamicModel alloc] initWithDictionary:favoritesDic];
            [_myFavotiteDataList addObject:favoritesModel];
            
        }
        
        //刷新完调用的方法
        [self refreshFinished];
    } withFilePath:filePath];
}

#pragma mark - UITableViewDateSource
//单元格个数的返回
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _myFavotiteDataList.count;
}

//单元格的返回
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SelfDynamicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelfDynamicViewCell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SelfDynamicViewCell" owner:nil options:nil] firstObject];
    }
    cell.model = _myFavotiteDataList[indexPath.row];
    
    return cell;
}

//单元格的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DynamicDetailViewController *dynamicDetailViewController = [[DynamicDetailViewController alloc] init];
    dynamicDetailViewController.model = _myFavotiteDataList[indexPath.row];
    
    [self.navigationController pushViewController:dynamicDetailViewController animated:YES];
}

//单元格高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取model数据
    SelfDynamicModel *model = _myFavotiteDataList[indexPath.row];
    
    //自己发送的话的高度自适应
    CGFloat selfSpeakH = 0;
    if (model.text) {
        
        CGRect rect = [model.text boundingRectWithSize:CGSizeMake(kScreenW-30, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        selfSpeakH = rect.size.height+18;
    }
    
    //转发别人的话的高度
    CGFloat otherSpeakH = 0;
    if (model.retweetedModel.text) {
        
        CGRect rect = [model.retweetedModel.text boundingRectWithSize:CGSizeMake(kScreenW-30, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        
        otherSpeakH = rect.size.height-25;
    }
    //自己发送的图片的高度
    CGFloat selfPhotosH = 0;
    if ([model.pic_urls count] > 0) {
        
        PhotoView *photoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-30, 0)];
        NSMutableArray *urls = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in model.pic_urls) {
            
            NSString *urlString = dic[@"thumbnail_pic"];
            
            [urls addObject:urlString];
        }
        //图片的加载
        photoView.dataList = urls;
        BOOL hasY = urls.count%3;
        photoView.hidden = NO;
        selfPhotosH = ((kScreenW-15*2-20))/3*((urls.count/3)+1*hasY)+(((urls.count/3)+1*hasY)-1)*15+20-16;
    }
    
    //别人发送的图片高度
    CGFloat otherPhotoH = 0;
    if ([model.retweetedModel.pic_urls count] > 0) {
        
        PhotoView *photoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-30, 0)];
        NSMutableArray *urls = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in model.retweetedModel.pic_urls) {
            
            NSString *urlString = dic[@"thumbnail_pic"];
            
            [urls addObject:urlString];
        }
        //图片的加载
        photoView.dataList = urls;
        BOOL hasY = urls.count%3;
        photoView.hidden = NO;
        otherPhotoH = ((kScreenW-15*2-20))/3*((urls.count/3)+1*hasY)+(((urls.count/3)+1*hasY)-1)*15+35;
        
    }
    return 80 + selfSpeakH + otherSpeakH +selfPhotosH + otherPhotoH;
}

//添加自定义返回按钮
- (void)addCustomBackButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setImage:[UIImage imageNamed:@"top_back_white"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

//按钮的相应事件
- (void)buttonAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}


//视图将要出现的时候隐藏tabBar
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

@end
