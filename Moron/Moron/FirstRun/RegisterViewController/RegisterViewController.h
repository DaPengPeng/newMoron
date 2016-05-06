//
//  RegisterViewController.h
//  Moron
//
//  Created by bever on 16/4/11.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *rePassword;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
- (IBAction)registerAction:(UIButton *)sender;
- (IBAction)weiBoLoginAction:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
