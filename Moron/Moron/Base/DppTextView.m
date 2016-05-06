//
//  DppTextView.m
//  Moron
//
//  Created by bever on 16/4/28.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "DppTextView.h"

@implementation DppTextView

- (void)awakeFromNib {

    _label = [[UILabel alloc] initWithFrame:CGRectMake(3, 6.5, self.width, 20)];
    _label.text = @"分享你的成果...";
    _label.textColor = [UIColor grayColor];
    [self addSubview:_label];
    
    [self becomeFirstResponder];
}

@end
