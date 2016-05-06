//
//  recordViewCell.m
//  Moron
//
//  Created by bever on 16/5/2.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "recordViewCell.h"

@implementation recordViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic {
    
    _dataDic = dataDic;
    _itemName.text = _dataDic[@"itemName"];
    _groupCount.text = _dataDic[@"groupCount"];
    _count.text = _dataDic[@"count"];
    _time.text = _dataDic[@"time"];
    _weight.text = _dataDic[@"weight"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
