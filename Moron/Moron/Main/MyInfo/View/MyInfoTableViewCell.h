//
//  MyInfoTableViewCell.h
//  Moron
//
//  Created by bever on 16/3/22.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyInfoModel;

@interface MyInfoTableViewCell : UITableViewCell

@property (nonatomic,retain) MyInfoModel *model;

@property (nonatomic,retain) NSArray *focusDataList;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *loudlySpeak;


@property (weak, nonatomic) IBOutlet UILabel *count1;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *count2;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *count3;
@property (weak, nonatomic) IBOutlet UILabel *title3;


@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;


- (IBAction)dynamicAction:(UIButton *)sender;
- (IBAction)focusAction:(UIButton *)sender;
- (IBAction)fansAction:(UIButton *)sender;



@end
