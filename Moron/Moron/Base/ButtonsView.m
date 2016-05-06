//
//  ButtonsView.m
//  ButtonDamo
//
//  Created by bever on 16/2/23.
//  Copyright © 2016年 我是清风. All rights reserved.
//

#import "ButtonsView.h"

@implementation ButtonsView {

    int _buttonCount;
    UIImageView *_imageView;
    
    NSMutableArray *_buttonsArray;//button数组
}



-(void)setTitleArray:(NSArray *)titleArray {
    
    _titleArray = titleArray;
    _buttonCount = (int)titleArray.count;
    self.backgroundColor = [UIColor grayColor];
    [self creatButton];

}

-(void)awakeFromNib {

    //添加观察者
    [[NSNotificationCenter defaultCenter] addObserverForName:kIdenxChange object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSNumber *indexNumber = [note.userInfo objectForKey:@"index"];
        NSInteger index = [indexNumber integerValue];
        [self buttonAction:_buttonsArray[index]];
    }];
}

-(instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray withSelectedImage:(NSString *)selectedImage {

    self = [super initWithFrame:frame];
    if (self) {
        
        _buttonCount = (int)titleArray.count;
        _titleArray = titleArray;
        _selectedImage = selectedImage;
        self.backgroundColor = [UIColor grayColor];
        
        //添加观察者
        [[NSNotificationCenter defaultCenter] addObserverForName:kIdenxChange object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            
            NSNumber *indexNumber = [note.userInfo objectForKey:@"index"];
            NSInteger index = [indexNumber integerValue];
            [self buttonAction:_buttonsArray[index]];
        }];
        [self creatButton];
    }
    return self;

}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        //添加观察者
        [[NSNotificationCenter defaultCenter] addObserverForName:kIdenxChange object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            
            NSNumber *indexNumber = [note.userInfo objectForKey:@"index"];
            NSInteger index = [indexNumber integerValue];
            [self buttonAction:_buttonsArray[index]];
        }];
    }
    return self;
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)creatButton {
    
    _buttonsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _buttonCount; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.bounds.size.width/_buttonCount * i, 0, self.bounds.size.width/_buttonCount, self.bounds.size.height);
        button.tag = 100 + i;
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonsArray addObject:button];
        
        button.titleLabel.font = [UIFont systemFontOfSize:16.5];
        if ( i == _currentIndex) {
            
            button.titleLabel.font = [UIFont systemFontOfSize:20];
            button.selected = YES;
        }
        [self addSubview:button];
        
    }
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/_buttonCount * _currentIndex, self.bounds.size.height-7, self.bounds.size.width/_buttonCount, 7)];
    _imageView.contentMode = UIViewContentModeCenter;//图片的自适应
    _imageView.image = [UIImage imageNamed:_selectedImage];
    [self addSubview:_imageView];

}

- (void)buttonAction:(UIButton *)button {

   
    [self changeButtonView:button];
    _currentIndex = (NSInteger)button.tag-100;
    _buttonBlock((NSInteger)button.tag-100);
}

- (void)changeButtonView:(UIButton *)button {

    NSArray *buttonArray = [self subviews];
    
    for (UIView *view in buttonArray) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *button1 = (UIButton *)view;
            button1.titleLabel.font = [UIFont systemFontOfSize:16.5];
            button1.selected = NO;
            
        }
    }
    button.selected = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _imageView.frame = CGRectMake(button.frame.origin.x, button.frame.size.height-7, button.frame.size.width, 7);
    }];
}



@end
