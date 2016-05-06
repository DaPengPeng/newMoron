//
//  EmoticonsImageView.m
//  Moron
//
//  Created by bever on 16/4/28.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "EmoticonsImageView.h"

@implementation EmoticonsImageView {

    UIImageView *_imageView;
    
    UIImageView *_itemView;
    
    MyBlock _blcok;
}

static const NSInteger _culCount = 8;
static const NSInteger _lineCount = 3;
static const CGFloat _minSpace = 10;
static const UIEdgeInsets _edgeInsets = {10, 15, 10, 15};

- (instancetype)initWithFrame:(CGRect)frame withBlock:(MyBlock)blcok {

    if (self = [super initWithFrame:frame]) {
        _blcok = blcok;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 92)];
        _imageView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier.png"];
        [self addSubview:_imageView];
        _imageView.hidden = YES;
        _imageView.clipsToBounds = NO;
        
        _itemView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 60, 60)];
        [_imageView addSubview:_itemView];
    }
    return self;
}

- (void)setDataList:(NSArray *)dataList {

    _dataList = dataList;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIImage *image = [UIImage imageNamed:@"emoticon_keyboard_background"];
    [image drawInRect:self.bounds];
    
    for (int i = 0; i < _dataList.count; i++) {
        
        NSDictionary *dic = _dataList[i];
        
        UIImage *image = [UIImage imageNamed:dic[@"png"]];
        [image drawInRect:[self rectOfIndex:i]];
    }
}

- (CGRect)rectOfIndex:(NSInteger)i {
    
    //计算每一个页面上item的数量
    NSInteger widthCount = _culCount;
    
    CGFloat itemWidth = ((self.width-_edgeInsets.left-_edgeInsets.right)-(_culCount-1)*_minSpace)/_culCount;
    CGFloat itemHeight = itemWidth;
    return CGRectMake(_edgeInsets.left+(i%widthCount)*(itemWidth+_minSpace), _edgeInsets.top+(i/widthCount)*(itemHeight+_minSpace), itemWidth, itemHeight);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    //拿到点所在矩形的下标
    NSInteger index = 24;
    for (int i = 0; i <_dataList.count; i++) {
        
        BOOL isContain = CGRectContainsPoint([self rectOfIndex:i], point);
        if (isContain) {
            index = i;
            break;
        }
    }
    
    if (index < _dataList.count) {
        
        _imageView.hidden = NO;
        _itemView.image = [UIImage imageNamed:_dataList[index][@"png"]];
        
        CGFloat itemWidth = ((self.width-_edgeInsets.left-_edgeInsets.right)-(_culCount-1)*_minSpace)/_culCount;
        CGRect rect = [self rectOfIndex:index];
        CGFloat centerX = rect.origin.x + itemWidth/2;
        CGFloat centerY = rect.origin.y + itemWidth/2 - _imageView.bounds.size.height/2;
        
        //设置中心点
        _imageView.center = CGPointMake(centerX, centerY);
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UIScrollView *scrollView = (UIScrollView *)[self superview];
    scrollView.scrollEnabled = NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UIScrollView *scrollView = (UIScrollView *)[self superview];
    scrollView.scrollEnabled = YES;
    _imageView.hidden = YES;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    //拿到点所在矩形的下标
    NSInteger index = 24;
    for (int i = 0; i <_dataList.count; i++) {
        
        BOOL isContain = CGRectContainsPoint([self rectOfIndex:i], point);
        if (isContain) {
            index = i;
            break;
        }
    }
    
    if (index < _dataList.count) {
    
        _blcok(_dataList[index][@"cht"]);
    }
}

@end
