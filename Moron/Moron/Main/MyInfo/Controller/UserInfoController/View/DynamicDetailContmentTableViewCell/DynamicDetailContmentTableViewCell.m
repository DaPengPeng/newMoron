//
//  DynamicDetailContmentTableViewCell.m
//  Moron
//
//  Created by bever on 16/4/18.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "DynamicDetailContmentTableViewCell.h"

@implementation DynamicDetailContmentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _userImage.layer.cornerRadius = 25;
    _userImage.clipsToBounds = YES;
    
    _comment.textAttributes = @{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]};
}

- (void)setModel:(CommentModel *)model {

    _model = model;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:model.userModel.profile_image_url]];
    _name.text = model.userModel.screen_name;
    
    //相关字符的替换
    NSDictionary *munthDic = @{@"Jan":@"1 -",@"Feb":@"2 -",@"Mar":@"3 -",@"Apr":@"4 -",@"May":@"5 -",@"Jun":@"6 -",@"Jul":@"7 -",@"Aug":@"8 -",@"Sep":@"9 -",@"Oct":@"10 -",@"Nov":@"11 -",@"Dec":@"12 -",};
    NSMutableString *muCreate_at = [NSMutableString stringWithString:model.created_at];
    for (NSString *key in munthDic) {
        
        if ([model.created_at rangeOfString:key].location != NSNotFound) {
            [muCreate_at replaceCharactersInRange:[model.created_at rangeOfString:key] withString:munthDic[key]];
        }
    }
    
    //字符串的截取
    _time.text = [muCreate_at substringWithRange:NSMakeRange(4, 12)];
    _comment.text = model.text;
}

@end
