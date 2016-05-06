//
//  SelfDynamicViewCell.m
//  Moron
//
//  Created by bever on 16/4/14.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "SelfDynamicViewCell.h"
#import "SelfDynamicContentView.h"

@implementation SelfDynamicViewCell

- (void)awakeFromNib {
    // Initialization code
    
    //设置头像的圆角
    _selfImage.layer.cornerRadius = 25;
    _selfImage.clipsToBounds = YES;
    
}

- (void)setModel:(SelfDynamicModel *)model {
    
    _model = model;
    
    //头像设置
    [_selfImage sd_setImageWithURL:[NSURL URLWithString:_model.userModel.profile_image_url]];
    
    //时间设置
    _time.text = [UIUtils formatDateString:_model.created_at];
    
    //来源设置
    if (_model.source) {
        
        NSRange range2 = [_model.source rangeOfString:@">"];
        if (range2.location != NSNotFound) {
            
            NSString *sourceStr = [_model.source substringFromIndex:range2.location+1];
            NSRange range1 = [sourceStr rangeOfString:@"</a>"];
            NSString *sourceS = [sourceStr substringToIndex:range1.location];
            NSString *source = [NSString stringWithFormat:@"来自 %@",sourceS];
            _resource.text = source;
        }
    }
    
    
    //评论、点赞、转发设置
    _comment.text = [NSString stringWithFormat:@"评论：%@",[_model.comments_count stringValue]];
    _share.text = [NSString stringWithFormat:@"转发：%@",[_model.reposts_count stringValue]];
    _good.text = [NSString stringWithFormat:@"赞：%@",[_model.attitudes_count stringValue]];
    _selfName.text = _model.userModel.name;
    
    //contentView设置
    _dynamicContentView.model = model;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
