//
//  LeftViewController.h
//  Moron
//
//  Created by bever on 16/3/20.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *rankImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView4;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView5;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView6;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView7;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView8;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView9;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *wheatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *bgView;

- (IBAction)buttonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)myInfoAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *walkMeters;



@end
