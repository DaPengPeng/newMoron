//
//  LeftViewControllerCell.m
//  Moron
//
//  Created by bever on 16/4/27.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "LeftViewControllerCell.h"

@implementation LeftViewControllerCell

- (void)awakeFromNib {
    // Initialization code
    
    _groupCount.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    _count.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    _time.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    _weight.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
