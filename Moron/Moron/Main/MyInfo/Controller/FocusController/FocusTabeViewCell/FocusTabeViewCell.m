//
//  FocusTabeViewCell.m
//  Moron
//
//  Created by bever on 16/4/21.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "FocusTabeViewCell.h"

@implementation FocusTabeViewCell

- (void)awakeFromNib {
    // Initialization code
    
    //用户头像的设置
    _image.layer.cornerRadius = 25;
    _image.clipsToBounds = YES;
}

- (void)setFocusModel:(FocusModel *)focusModel {

    _focusModel = focusModel;
    
    [_image sd_setImageWithURL:[NSURL URLWithString:focusModel.profile_image_url]];
    _name.text = focusModel.screen_name;
    _dynamic.text = focusModel.statusModel.text;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
