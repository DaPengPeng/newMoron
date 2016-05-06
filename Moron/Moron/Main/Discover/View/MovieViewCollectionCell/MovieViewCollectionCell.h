//
//  MovieViewCollectionCell.h
//  Moron
//
//  Created by bever on 16/5/2.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewCollectionCell : UICollectionViewCell

@property (nonatomic,retain) NSDictionary *dataDic;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
