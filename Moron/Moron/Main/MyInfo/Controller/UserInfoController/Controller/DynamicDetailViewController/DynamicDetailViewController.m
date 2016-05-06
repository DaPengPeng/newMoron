//
//  DynamicDetailViewController.m
//  Moron
//
//  Created by bever on 16/4/18.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "DynamicDetailViewController.h"
#import "SelfDynamicContentView.h"
#import "SelfDynamicViewCell.h"
#import "PhotoView.h"
#import "CNLabel.h"
#import "DynamicDetailContmentTableViewCell.h"

@interface DynamicDetailViewController () {

    NSMutableArray *_commentDataList;
}

@end

@implementation DynamicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //数据的加载
    [self loadData];
    
    //标题设置
    self.title = [NSString stringWithFormat:@"%@的微博",_model.userModel.screen_name];
    
    //自定义返回按钮
    [self addCustomBackButton];
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


//数据的加载
- (void)loadData {
    
    //本地信息的读取
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/comment.plist"];
    _commentDataList = [[NSMutableArray alloc] init];
    
    //信息的读取
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDictionary *dic = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        NSArray *commentsArray = dic[@"comments"];
        
        for (NSDictionary *commentDic in commentsArray) {
            
            CommentModel *commentModel = [[CommentModel alloc] initWithDictionary:commentDic];
            [_commentDataList addObject:commentModel];
            
        }
    }

    //网络信息的读取
    [DppNetworking GET:@"https://api.weibo.com/2/comments/show.json" parmeters:@{@"access_token":kAccessToken,@"id":_model.weiBoId} resulteBlock:^(id resulte) {
       
        _commentDataList = [[NSMutableArray alloc] init];
        NSArray *commentsArray = resulte[@"comments"];
        
        for (NSDictionary *commentDic in commentsArray) {
            
            CommentModel *commentModel = [[CommentModel alloc] initWithDictionary:commentDic];
            [_commentDataList addObject:commentModel];
            
        }
        [self.tableView reloadData];
    } withFilePath:filePath];
}

//下拉刷新
-(void)pushRefreshData {
 
    //获取当前显示的第一个微博数据
    CommentModel *model = _commentDataList[0];
    
    NSString *url = @"https://api.weibo.com/2/comments/show.json";
    if (kAccessToken) {
        
        NSDictionary *param = @{@"access_token":kAccessToken,@"since_id":model.commentId,@"id":_model.weiBoId};
        
        NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/comment.plist"];
        
        [DppNetworking GET:url parmeters:param resulteBlock:^(id resulte) {
            //获取数组
            NSArray *comments = [resulte objectForKey:@"comments"];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in comments) {
                
                CommentModel *model = [[CommentModel alloc] initWithDictionary:dic];
                
                [arr addObject:model];
                
            }
            if (arr.count>0) {
                
                _commentDataList = [NSMutableArray arrayWithArray:[arr arrayByAddingObjectsFromArray:_commentDataList]];
                
                //刷新数据
                [self.tableView reloadData];
                
            }
            //刷新完后掉用该方法
            [self refreshFinished];
            
        } withFilePath:filePath];
    }

}

//头视图高度的确定
- (CGFloat)getCellH {

    //获取model数据
    SelfDynamicModel *model = self.model;
    
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

#pragma mark -UITableViewDatasorce
//组数的返回
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

//单元格个数的返回
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }else if (_commentDataList) {
    
        return _commentDataList.count;
    }else {
    
        return 0;
    }
}

//单元格内容的返回
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        
        SelfDynamicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelfDynamicViewCell"];
        if (!cell) {
            
            //加载xib
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SelfDynamicViewCell" owner:nil options:nil] firstObject];
        }
        cell.model = self.model;
        return cell;
    }else {
    
        if (_commentDataList) {
            
            DynamicDetailContmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DynamicDetailContmentTableViewCell"];
            if (!cell) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"DynamicDetailContmentTableViewCell" owner:nil options:nil] firstObject];
            }
            
            cell.model = _commentDataList[indexPath.row];
            return cell;
        }
        return nil;
    }
}

//单元格高度的返回
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        
        CGFloat firstCellH = [self getCellH];
        return firstCellH;
    }else {
    
        //根据model获取lable的高度
        CNLabel *label = [[CNLabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW-16, 0)];
        CommentModel *model = _commentDataList[indexPath.row];
        label.text = model.text;
        
        return 60+label.height;
    }
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
