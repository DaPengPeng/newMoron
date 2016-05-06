//
//  UserIconImageView.m
//  Moron
//
//  Created by bever on 16/4/21.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "UserIconImageView.h"
#import "MMDrawerController.h"

@implementation UserIconImageView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        //设置圆角
        self.layer.cornerRadius = frame.size.width/2;
        self.clipsToBounds = YES;
        
        //接收用户交互
        self.userInteractionEnabled = YES;
        
        //图形的添加
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/userInfo.plist"];
        //信息的读取
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDictionary *dic = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:dic];
        [self sd_setImageWithURL:[NSURL URLWithString:userInfo.profile_image_url] placeholderImage:[UIImage imageNamed:@"8.jpg"]];
        
        //手势的添加
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {

    MMDrawerController *MMDrawerController = [self MMDrawerController];
    [MMDrawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

//抽屉视图控制器的寻找
- (MMDrawerController *)MMDrawerController {
    
    UIResponder *responder = self;
    
    do {
        if ([responder isKindOfClass:[MMDrawerController class]]) {
            
            return  (MMDrawerController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder != nil);
    
    return nil;
}

@end
