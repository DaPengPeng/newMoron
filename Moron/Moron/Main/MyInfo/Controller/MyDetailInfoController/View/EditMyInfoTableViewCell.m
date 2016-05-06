//
//  EditMyInfoTableViewCell.m
//  Moron
//
//  Created by bever on 16/3/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "EditMyInfoTableViewCell.h"
#import "MyDetailInfoModel.h"

@implementation EditMyInfoTableViewCell 

- (void)awakeFromNib {
    // Initialization code
    
    //头像边框的设置
    _userImage.layer.borderWidth = 1;
    _userImage.layer.borderColor = [UIColor grayColor].CGColor;
    _userImage.clipsToBounds = YES;
    _userImage.layer.cornerRadius = 22;
    
    //实例
    _pickerController = [[UIImagePickerController alloc] init];
    
    //设置来源
    _pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //设置摄像头
//    _pickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;//前置摄像头
    _pickerController.delegate = self;
    
}

//setModel方法的重写
- (void)setModel:(MyDetailInfoModel *)model {

    _model = model;
    if ([_model.type integerValue] == 1) {
        
        [_userImage sd_setImageWithURL:[NSURL URLWithString:model.title]];
    }else if ([_model.type integerValue] == 2) {
    
        _titleLabel2.text = _model.title;
        _content2.text = _model.content;
    }else if ([_model.type integerValue] == 3) {
    
        _titleLabel3.text = _model.title;
        _content3.text = _model.content;
    }else {
    
//        _content4.text = _model.title;
//        _content4.text = _model.content;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)exchangeUserImageAction:(UIButton *)sender {
    
    
//    [[self viewController] presentViewController:self.pickerController animated:NO completion:nil];
}
@end
