//
//  DiscoverTableViewCell.m
//  Moron
//
//  Created by bever on 16/4/25.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "DiscoverTableViewCell.h"

@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
//    _img.contentMode = UIViewContentModeScaleAspectFill;
}


- (void)setModel:(DiscoverModel *)model {

    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:_model.img]];
    _title.text = _model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
