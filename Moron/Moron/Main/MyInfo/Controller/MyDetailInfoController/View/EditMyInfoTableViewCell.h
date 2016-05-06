//
//  EditMyInfoTableViewCell.h
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyDetailInfoModel;

@interface EditMyInfoTableViewCell : UITableViewCell <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,retain) MyDetailInfoModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UITextView *content2;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel3;
@property (weak, nonatomic) IBOutlet UITextView *content3;

@property (weak, nonatomic) IBOutlet UITextView *content4;

@property (nonatomic,retain) UIImagePickerController *pickerController;

- (IBAction)exchangeUserImageAction:(UIButton *)sender;


@end
