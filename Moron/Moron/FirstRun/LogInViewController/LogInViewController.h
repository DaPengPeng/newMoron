//
//  LogInViewController.h
//  Moron
//
//  Created by bever on 16/4/11.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)frogetPasswordAction:(UIButton *)sender;
- (IBAction)registerAction:(UIButton *)sender;
- (IBAction)weiBoLoginAction:(UITapGestureRecognizer *)sender;

@end
