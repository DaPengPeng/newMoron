//
//  UserInfoViewController.m
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "UserInfoViewController.h"
#import "MyDetailInfoViewController.h"
#import "UserInfoFirestCell.h"
#import "UserInfoModel.h"
#import "PhotoView.h"
#import "UserInfoHeaderView.h"
#import "CNLabel.h"
#import "SelfDynamicViewCell.h"
#import "SelfDynamicContentView.h"
#import "SelfDynamicModel.h"
#import "UserModel.h"
#import "DynamicDetailViewController.h"
#import "BigScrollView.h"
#import "DynamicTableView.h"
#import "recordViewCell.h"

@interface UserInfoViewController () {
    
    DynamicTableView *_dynamicTableView;
    UITableView *_recordView;
    
    NSMutableArray *_headerViewDataList;
    NSMutableArray *_dynamicViewDataList;
    NSMutableArray *_recordViewDataList;
    
    UICollectionView *_collectionView;
    
    BigScrollView *_bigScrollView;
    
    NSInteger _itemIndex;
    
    CGFloat _touchLong;
    
    EGORefreshTableHeaderView *_refreshView;
    
    PhotoView *_photoView;
    
    BOOL _isLoading;
    
    UIScrollView *_smallScrollView;
}

@end

@implementation UserInfoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"梦很想家ing";
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadData];
    
    //创建collectionView
//    [self createCollectionView];
    
    //创建bigScroollView
    [self createBigScrollView];
    
//    UserInfoHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoHeaderView" owner:nil options:nil] firstObject];
//    headerView.frame = CGRectMake(0, 0, kScreenW, 200);
//    [self.view addSubview:headerView];

    //创建smallScrollView
    [self createSmallScrollView];
}

//加载数据
- (void)loadData {
    
    //headerViewDataList
    _headerViewDataList = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UserInfo" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *userInfoDic = [dic objectForKey:@"userInfo"];
    UserInfoModel *model = [[UserInfoModel alloc] initWithDictionary:userInfoDic];
    [_headerViewDataList addObject:model];
    
    //dynamicViewDataList
    //本地信息的读取
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/myDynamic.plist"];
    _dynamicViewDataList = [[NSMutableArray alloc] init];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {//安全判断
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDictionary *dDic = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        NSArray *array = dDic[@"statuses"];
        for (NSDictionary *dic in array) {
            
            SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
            [_dynamicViewDataList addObject:model];
        }
    }
    
    //网络信息的读取
    if (kAccessToken) {
        
        _dynamicViewDataList = [[NSMutableArray alloc] init];
        [DppNetworking GET:@"https://api.weibo.com/2/statuses/user_timeline.json" parmeters:@{@"access_token":kAccessToken} resulteBlock:^(id resulte) {
            
            NSArray *array = resulte[@"statuses"];
            for (NSDictionary *dic in array) {
                
                SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
                [_dynamicViewDataList addObject:model];
            }
            [_dynamicTableView reloadData];
        } withFilePath:filePath];
    }
    
    //recordViewDataList
    NSString *recordPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/record.plist"];
    NSData *recordData = [NSData dataWithContentsOfFile:recordPath];
    if (recordData) {
        NSKeyedUnarchiver *recordUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:recordData];
        NSMutableDictionary *recordDic = [NSMutableDictionary dictionaryWithDictionary:[recordUnarchiver decodeObject]];
        [recordUnarchiver finishDecoding];
        _recordViewDataList = recordDic[@"array"];
        
    }
    
}

//创建collectionView
- (void)createCollectionView {
    
    //创建布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenW, kScreenH-300);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(kScreenW, 200);
    
    //创建collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-50) collectionViewLayout:layout];
    _collectionView.pagingEnabled =YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentSize = CGSizeMake(kScreenW*3, kScreenH-50);
    _collectionView.backgroundColor = [UIColor clearColor];
    
    
    //注册单元格
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    //注册头视图
    [_collectionView registerNib:[UINib nibWithNibName:@"UserInfoHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    [self.view addSubview:_collectionView];
}

//创建bigScrollView
- (void)createBigScrollView {

    _bigScrollView = [[BigScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-50)];
    [self.view addSubview:_bigScrollView];
    
    _bigScrollView.contentSize = CGSizeMake(kScreenW, kScreenH-64+200-75);
    _bigScrollView.delegate = self;
    [_bigScrollView becomeFirstResponder];
    
    UserInfoHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoHeaderView" owner:nil options:nil] firstObject];
    headerView.frame = CGRectMake(0, 0, kScreenW, 200);
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/userInfo.plist"];
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *dic = [unarchiver decodeObject];
    [unarchiver finishDecoding];
    UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:dic];
    
    headerView.userInfo = userInfo;
    headerView.block = ^(NSInteger index) {
    
        _smallScrollView.contentOffset = CGPointMake(kScreenW*index, 0);
    };
    [_bigScrollView addSubview:headerView];
}

//创建smallScrollView
- (void)createSmallScrollView {

    _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, kScreenW, kScreenH-50)];
    [_bigScrollView addSubview:_smallScrollView];
    
    //scrollView的设置
    _smallScrollView.contentSize = CGSizeMake(kScreenW*3, kScreenH-64-50);
    _smallScrollView.backgroundColor = [UIColor whiteColor];
    _smallScrollView.pagingEnabled = YES;
    _smallScrollView.delegate = self;
    
    UITableView *tableView = [self createTableView];
    [_smallScrollView addSubview:tableView];
    
    PhotoView *photoView = [self createPhotoView];
    [_smallScrollView addSubview:photoView];
    
    UITableView *recordView = [self createRecordView];
    [_smallScrollView addSubview:recordView];
}

- (UITableView *)createTableView {
    
    _dynamicTableView = [[DynamicTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-104)];
    _dynamicTableView.backgroundColor = [UIColor clearColor];
    _dynamicTableView.dataSource = self;
    _dynamicTableView.delegate = self;
    _dynamicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_dynamicTableView resignFirstResponder];
//    _dynamicTableView.scrollEnabled = NO;
    //创建下拉刷新视图
    _refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -kScreenH, kScreenW, kScreenH)];
    
    //设置代理
    _refreshView.delegate = self;
    
    [_dynamicTableView addSubview:_refreshView];
    
    return _dynamicTableView;
}

- (UITableView *)createRecordView {
    
    _recordView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenW*2, 0, kScreenW, kScreenH-40)];
    
    _recordView.backgroundColor = [UIColor clearColor];
    _recordView.delegate = self;
    _recordView.dataSource = self;
    _recordView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //头视图的创建
    UIView *recordHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"RecordHeaderView" owner:nil options:nil] firstObject];
    _recordView.tableHeaderView = recordHeaderView;
    
    return _recordView;
}

//创建PhotoView
- (PhotoView *)createPhotoView {
    
    _photoView = [[PhotoView alloc] initWithFrame:CGRectMake(kScreenW, 0, kScreenW, kScreenH-104)];
    _photoView.dataList = @[@"http://imgsrc.baidu.com/baike/pic/item/b2de9c82d158ccbf6fe124131bd8bc3eb13541bd.jpg",@"http://imgsrc.baidu.com/baike/pic/item/b2de9c82d158ccbf6fe124131bd8bc3eb13541bd.jpg",@"http://img313.ph.126.net/ECoJRg_Hv0UgfvzrR05xUw==/3678314995655388709.jpg",@"http://imgsrc.baidu.com/baike/pic/item/b2de9c82d158ccbf6fe124131bd8bc3eb13541bd.jpg",@"http://imgsrc.baidu.com/baike/pic/item/b2de9c82d158ccbf6fe124131bd8bc3eb13541bd.jpg",@"http://img313.ph.126.net/ECoJRg_Hv0UgfvzrR05xUw==/3678314995655388709.jpg",@"http://img313.ph.126.net/ECoJRg_Hv0UgfvzrR05xUw==/3678314995655388709.jpg"];
    
    return _photoView;
}


#pragma mark - UIScrollViewDelegate
//结束减速时buttonsView数据的传递
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //scrollView左右滑动时，数据的传递
    if(scrollView == _smallScrollView) {
        
        NSInteger index = scrollView.contentOffset.x/kScreenW;
        
        //增加安全判断，防止数组越界
        if (index > 2) {
            index = 2;
        }
        if (index < 0) {
            index = 0;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kIdenxChange object:nil userInfo:@{@"index":@(index)}];
        
    }
}

//滑动视图结束滑动时刷新数据
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView == _dynamicTableView) {
        
        [_refreshView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

//滑动视图滑动时，refresh视图的变更
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _dynamicTableView) {
        
        [_refreshView egoRefreshScrollViewDidScroll:scrollView];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.item == 0) {
        
        UITableView *tableView = [self createTableView];
        [cell.contentView addSubview:tableView];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if (indexPath.item == 1) {
        
        PhotoView *photoView = [self createPhotoView];
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:photoView];
        return cell;
    }else if (indexPath.item == 2) {
        
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    return nil;
}

//头视图的返回
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        
        return headerView;
    }
    return nil;
}

//单元格重用的设置
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    for (UIView *view in cell.contentView.subviews) {
        
        [view removeFromSuperview];
    }
}

#pragma mark - UITableViewDataSource

//单元格个数的返回
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _recordView) {
        return _recordViewDataList.count;
    }
    return _dynamicViewDataList.count;
}

//单元格的返回
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _recordView) {
        
        recordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordViewCell"];
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"recordViewCell" owner:nil options:nil] firstObject];
        }
        NSDictionary *dic = _recordViewDataList[indexPath.item];
        cell.dataDic = dic;
        return cell;

    }
    
    SelfDynamicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelfDynamicViewCell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SelfDynamicViewCell" owner:nil options:nil] firstObject];
    }
    cell.model = _dynamicViewDataList[indexPath.row];
    
    return cell;
}

//单元格的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _dynamicTableView) {
        
        DynamicDetailViewController *dynamicDetailViewController = [[DynamicDetailViewController alloc] init];
        dynamicDetailViewController.model = _dynamicViewDataList[indexPath.row];
        
        [self.navigationController pushViewController:dynamicDetailViewController animated:YES];
    }
}



//单元格高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _recordView) {
        
        return 44;
    }
    
    //获取model数据
    SelfDynamicModel *model = _dynamicViewDataList[indexPath.row];
    
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

#pragma  --mark EGORefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    //修改刷新的bool属性
    _isLoading = YES;
    
    //开始刷新
    [self pushRefreshData];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _isLoading;
}

//下拉刷新加载数据
-(void)pushRefreshData
{
    //获取当前显示的第一个微博数据
    SelfDynamicModel *model = _dynamicViewDataList[0];
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/myDynamic.plist"];
    
    NSString *url = @"https://api.weibo.com/2/statuses/user_timeline.json";
    if (kAccessToken) {
        
        NSDictionary *param = @{@"access_token":kAccessToken,@"since_id":model.weiBoId};
        
        [DppNetworking GET:url parmeters:param resulteBlock:^(id resulte) {
            //获取数组
            NSArray *statuses = [resulte objectForKey:@"statuses"];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in statuses) {
                
                SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
                
                [arr addObject:model];
                
            }
            if (arr.count>0) {
                
                _dynamicViewDataList = [NSMutableArray arrayWithArray:[arr arrayByAddingObjectsFromArray:_dynamicViewDataList]];
                
                //刷新数据
                [_dynamicTableView reloadData];
                
            }
            //刷新完后掉用该方法
            [self refreshFinished];
            
        } withFilePath:path];
    }
    
}

//刷新完成的操作
-(void)refreshFinished
{
    //刷新完后掉用该方法
    [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_dynamicTableView];
    
    //修改状态
    _isLoading = NO;
}



@end