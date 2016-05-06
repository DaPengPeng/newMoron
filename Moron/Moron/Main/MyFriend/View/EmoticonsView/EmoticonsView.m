//
//  EmoticonsView.m
//  Moron
//
//  Created by bever on 16/4/28.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "EmoticonsView.h"
#import "EmoticonsImageView.h"

static const NSInteger _culCount = 8;
static const NSInteger _lineCount = 4;

@interface EmoticonsView () <UIScrollViewDelegate>{

    UIScrollView *_scrollView;
    
    UIPageControl *_pageControl;
    
    NSMutableArray *_dataList;
    
    MyBlock _block;
}

@end

@implementation EmoticonsView

- (instancetype)initWithFrame:(CGRect)frame  withBlock:(MyBlock)block{
    if (self = [super initWithFrame:frame]) {
        _block = block;
        
        //数据的读取
        [self loadData];
        
        //画表情
        [self createScrollView];
        
        //创建分页控制器
        [self createPageControl];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    UIImage *image = [UIImage imageNamed:@"emoticon_keyboard_background"];
    [image drawInRect:self.bounds];
    
}

//数据的读取
- (void)loadData {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    _dataList = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:path]];
}

//创建scrollView
- (void)createScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.bounds.size.height)];
    [self addSubview:_scrollView];
    
    //计算每一个页面上item的数量
    NSInteger widthCount = _culCount;
    NSInteger heightCount = _lineCount;
    NSInteger onePageItemCount = widthCount * heightCount;
    BOOL hasMod = _dataList.count%onePageItemCount;
    NSInteger pageCount = _dataList.count/onePageItemCount+1*hasMod;
    
    //_scrollView的设置
    _scrollView.contentSize = CGSizeMake(kScreenW*pageCount, self.bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    for (int i = 0; i < pageCount; i++) {
        
        EmoticonsImageView *view = [[EmoticonsImageView alloc] initWithFrame:CGRectMake(kScreenW * i, 0, _scrollView.width, _scrollView.height) withBlock:_block];
        view.dataList = [_dataList subarrayWithRange:NSMakeRange(i*32, (i+1)*32 >= _dataList.count ? _dataList.count-i*32 : 32)];
        [_scrollView addSubview:view];
    }
}

//创建分页控制器
- (void)createPageControl {
    
    CGFloat width = _scrollView.bounds.size.width;
    CGFloat height = _scrollView.bounds.size.height;
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((width-70)/2, height-20, 70, 20)];
    
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



@end

