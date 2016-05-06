//
//  DynamicTableView.m
//  Moron
//
//  Created by bever on 16/4/24.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "DynamicTableView.h"
#import "SelfDynamicViewCell.h"
#import "SelfDynamicModel.h"
#import "DynamicDetailViewController.h"
#import "PhotoView.h"

@interface DynamicTableView () {

    NSMutableArray *_dynamicViewDataList;
}

@end

@implementation DynamicTableView
//
//- (instancetype)initWithFrame:(CGRect)frame {
//
//    if (self = [super initWithFrame:frame]) {
//        
//        self.delegate = self;
//        self.dataSource = self;
//        
//        [self loadData];
//    }
//    return self;
//}
//
////数据的加载
//- (void)loadData {
//    
//    //dynamicViewDataList
//    _dynamicViewDataList = [[NSMutableArray alloc] init];
//    if (kAccessToken) {
//        
//        [DppNetworking GET:@"https://api.weibo.com/2/statuses/user_timeline.json" parmeters:@{@"access_token":kAccessToken} resulteBlock:^(id resulte) {
//            
//            NSArray *array = resulte[@"statuses"];
//            for (NSDictionary *dic in array) {
//                
//                SelfDynamicModel *model = [[SelfDynamicModel alloc] initWithDictionary:dic];
//                [_dynamicViewDataList addObject:model];
//            }
//            [self reloadData];
//        }];
//    }
//}
//
//
//#pragma mark - UITableViewDateSource
////单元格个数的返回
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return _dynamicViewDataList.count;
//}
//
////单元格的返回
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    SelfDynamicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelfDynamicViewCell"];
//    
//    if (!cell) {
//        
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"SelfDynamicViewCell" owner:nil options:nil] firstObject];
//    }
//    cell.model = _dynamicViewDataList[indexPath.row];
//    
//    return cell;
//}
//
////单元格的点击事件
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    DynamicDetailViewController *dynamicDetailViewController = [[DynamicDetailViewController alloc] init];
//    dynamicDetailViewController.model = _dynamicViewDataList[indexPath.row];
//    
//    [[self viewController].navigationController pushViewController:dynamicDetailViewController animated:YES];
//}
//
//
//
////单元格高度的返回
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    //获取model数据
//    SelfDynamicModel *model = _dynamicViewDataList[indexPath.row];
//    
//    //自己发送的话的高度自适应
//    CGFloat selfSpeakH = 0;
//    if (model.text) {
//        
//        CGRect rect = [model.text boundingRectWithSize:CGSizeMake(kScreenW-30, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
//        
//        selfSpeakH = rect.size.height+18;
//    }
//    
//    //转发别人的话的高度
//    CGFloat otherSpeakH = 0;
//    if (model.retweetedModel.text) {
//        
//        CGRect rect = [model.retweetedModel.text boundingRectWithSize:CGSizeMake(kScreenW-30, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
//        
//        otherSpeakH = rect.size.height-25;
//    }
//    //自己发送的图片的高度
//    CGFloat selfPhotosH = 0;
//    if ([model.pic_urls count] > 0) {
//        
//        PhotoView *photoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-30, 0)];
//        NSMutableArray *urls = [[NSMutableArray alloc] init];
//        for (NSDictionary *dic in model.pic_urls) {
//            
//            NSString *urlString = dic[@"thumbnail_pic"];
//            
//            [urls addObject:urlString];
//        }
//        //图片的加载
//        photoView.dataList = urls;
//        BOOL hasY = urls.count%3;
//        photoView.hidden = NO;
//        selfPhotosH = ((kScreenW-15*2-20))/3*((urls.count/3)+1*hasY)+(((urls.count/3)+1*hasY)-1)*15+20-16;
//    }
//    
//    //别人发送的图片高度
//    CGFloat otherPhotoH = 0;
//    if ([model.retweetedModel.pic_urls count] > 0) {
//        
//        PhotoView *photoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-30, 0)];
//        NSMutableArray *urls = [[NSMutableArray alloc] init];
//        for (NSDictionary *dic in model.retweetedModel.pic_urls) {
//            
//            NSString *urlString = dic[@"thumbnail_pic"];
//            
//            [urls addObject:urlString];
//        }
//        //图片的加载
//        photoView.dataList = urls;
//        BOOL hasY = urls.count%3;
//        photoView.hidden = NO;
//        otherPhotoH = ((kScreenW-15*2-20))/3*((urls.count/3)+1*hasY)+(((urls.count/3)+1*hasY)-1)*15+35;
//        
//    }
//    return 80 + selfSpeakH + otherSpeakH +selfPhotosH + otherPhotoH;
//}
//
//
////滑动时调用的方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    _bigScrollView.scrollEnabled = NO;
//}
//
////寻找父视图中的scrollView
//- (UIResponder *)getScrollView {
//    
//    UIResponder *responder = self;
//    
//    do {
//        if ([responder isKindOfClass:[BigScrollView class]]) {
//            
//            return responder;
//        }
//        responder = responder.nextResponder;
//    } while (responder);
//
//    return nil;
//}



@end
