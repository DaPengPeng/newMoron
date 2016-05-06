//
//  ExerciseItemCollectionCell.m
//  Moron
//
//  Created by bever on 16/4/26.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "ExerciseItemCollectionCell.h"

@implementation ExerciseItemCollectionCell

- (void)awakeFromNib {
    // Initialization code
    
    //将图片隐藏
    _checkmarkImage.hidden = YES;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic {

    _dataDic = dataDic;
    
    _label.text = dataDic[@"name"];
    
    _checkmarkImage.hidden = ![dataDic[@"isMyClass"] boolValue];
    
}

@end
