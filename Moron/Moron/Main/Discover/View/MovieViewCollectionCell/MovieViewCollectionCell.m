//
//  MovieViewCollectionCell.m
//  Moron
//
//  Created by bever on 16/5/2.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "MovieViewCollectionCell.h"

@implementation MovieViewCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic {

    _dataDic = dataDic;
    _title.text = dataDic[@"title"];
    NSString *url = dataDic[@"img"];
    [_img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
}

@end
