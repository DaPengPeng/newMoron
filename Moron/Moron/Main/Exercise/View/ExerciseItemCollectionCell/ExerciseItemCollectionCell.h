//
//  ExerciseItemCollectionCell.h
//  Moron
//
//  Created by bever on 16/4/26.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseItemCollectionCell : UICollectionViewCell

@property (nonatomic,retain) NSMutableDictionary *dataDic;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *checkmarkImage;

@end
