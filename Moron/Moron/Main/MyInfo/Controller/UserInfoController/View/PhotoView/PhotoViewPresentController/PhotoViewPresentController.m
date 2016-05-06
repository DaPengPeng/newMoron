//
//  PhotoViewPresentController.m
//  PhotoView
//
//  Created by bever on 16/4/14.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import "PhotoViewPresentController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Rect.h"
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width


@interface PhotoViewPresentController () <UIScrollViewDelegate> {

    UIScrollView *_scrollView;
    
    NSInteger _currentIndex;
}

@end

@implementation PhotoViewPresentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)setPhotoView:(PhotoView *)photoView {

    _photoView = photoView;
    
    CGRect newFrame = [_photoView convertRect:self.imageView.frame toView:self.view];
    _imageView.frame = newFrame;
    [self.view addSubview:_imageView];
}

- (void)setDataList:(NSArray *)dataList {

    _dataList = dataList;
    
    //创建scrollView
    [self createScrollView];
}

- (void)setImageView:(PhotoImageView *)imageView {

    _imageView = imageView;
    _currentIndex = _imageView.index;
}

//创建scrollView
- (void)createScrollView {

    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_scrollView];
    
    //scrollView的设置
    _scrollView.contentSize = CGSizeMake(kScreenW*_dataList.count, kScreenH);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;

    //创建ImageView
    for (int i = 0 ; i < _dataList.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW*i, 0, kScreenW, kScreenH)];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_dataList[i]]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageView];
        
        
    }
    _scrollView.contentOffset = CGPointMake(kScreenW*_currentIndex, 0);
    _scrollView.hidden = YES;
}

//tapAction
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    PhotoImageView *currentImageView = (PhotoImageView *)[_photoView.subViewsDic objectForKey:[NSString stringWithFormat:@"%ld",_currentIndex]];
    UIImageView *imageView = _scrollView.subviews[_currentIndex];
    CGRect rect = [imageView.image rect];
    CGRect newFrame = [self.view convertRect:rect toView:_photoView];
    currentImageView.frame = newFrame;
    [_photoView bringSubviewToFront:currentImageView];
    
    //将_photoView拿到单元格的最上层（防止其他label的遮盖）
    [[_photoView superview] bringSubviewToFront:_photoView];

    

    [self dismissViewControllerAnimated:NO completion:^{
        
        [UIView animateWithDuration:0.3 animations:^{
           
        currentImageView.frame = currentImageView.oldFrame;
        }];
    }];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    CGRect rect = [_imageView.image rect];
    //放大动画
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.imageView setFrame:rect];
        
        
    } completion:^(BOOL finished) {
        
        _scrollView.hidden = NO;
        
        //还原Item
        self.imageView.frame = self.imageView.oldFrame;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        [self.photoView addSubview:self.imageView];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    _currentIndex = _scrollView.contentOffset.x/kScreenW;
}
@end
