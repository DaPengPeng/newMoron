//
//  DppScrollPageView.m
//  DppScrollPage
//
//  Created by bever on 16/4/16.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import "DppScrollPageView.h"
#import "TouchImageView.h"
#import "CellPushViewController.h"

@implementation DppScrollPageView {

    UIScrollView *_scrollView;

    UIPageControl *_pageControl;
}

- (void)setDataList:(NSArray *)dataList {

    _dataList = dataList;
    
    self.backgroundColor = [UIColor grayColor];
    
    //创建scrollView
    [self createScrollView];
    
    //创建分页控制器
    [self createPageControl];
}

//创建scrollView
- (void)createScrollView {

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.bounds.size.height)];
    [self addSubview:_scrollView];
    
    //计算每一个页面上item的数量
    NSInteger widthCount = (self.bounds.size.width-_minSpace)/(_itemSize.width+_minSpace);
    NSInteger heightCount = (self.bounds.size.height-_minSpace)/(_itemSize.height+_minSpace);
    NSInteger onePageItemCount = widthCount * heightCount;
    BOOL hasMod = _dataList.count%onePageItemCount;
    NSInteger pageCount = _dataList.count/onePageItemCount+1*hasMod;
    
    //_scrollView的设置
    _scrollView.contentSize = CGSizeMake(kScreenW*pageCount, self.bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    CGFloat itemWidth = _itemSize.width;
    CGFloat itemHeight = _itemSize.height;
    
    //在scroolView上添加imageView
    for (int i = 0; i < _dataList.count; i++) {
        
        TouchImageView *imageView = [[TouchImageView alloc] initWithFrame:CGRectMake((i/onePageItemCount)*kScreenW+_minSpace+((i%onePageItemCount)%widthCount)*(itemWidth+_minSpace), _minSpace+((i%onePageItemCount)/widthCount)*(itemHeight+_minSpace), itemWidth, itemHeight)];
        NSDictionary *dic = _dataList[i];
        
        [imageView sd_setImageWithURL:dic[@"img"]];
        imageView.userInteractionEnabled = YES;
        imageView.multipleTouchEnabled = YES;
        imageView.tag = 100+i;
        [_scrollView addSubview:imageView];
        
        //label的创建
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.height-20, _scrollView.width-100, 20)];
        label.text = dic[@"title"];
        label.textColor = [UIColor whiteColor];
        [imageView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
    }
}

//创建分页控制器
- (void)createPageControl {
    
    CGFloat width = _scrollView.bounds.size.width;
    CGFloat height = _scrollView.bounds.size.height;

    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(width-70, height-20, 100, 20)];
    
    //分也控制器的设置
    _pageControl.numberOfPages = _scrollView.contentSize.width/width;
    _pageControl.enabled = NO;
    _pageControl.tintColor = [UIColor greenColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self addSubview:_pageControl];
}

//scrollView与pageControl的绑定
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger currentPage = scrollView.contentOffset.x/_scrollView.bounds.size.width;
    _pageControl.currentPage = currentPage;
}

// TapAction
- (void)tapAction:(UITapGestureRecognizer *)tap {

    NSDictionary *dic = _dataList[tap.view.tag-100];
    
    CellPushViewController *cellPushVC = [[CellPushViewController alloc] init];
    cellPushVC.url = dic[@"url"];
    [[self viewController].navigationController pushViewController:cellPushVC animated:YES];
}


@end
