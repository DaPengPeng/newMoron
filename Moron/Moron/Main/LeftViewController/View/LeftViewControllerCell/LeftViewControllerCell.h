//
//  LeftViewControllerCell.h
//  Moron
//
//  Created by bever on 16/4/27.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewControllerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UITextView *groupCount;
@property (weak, nonatomic) IBOutlet UITextView *count;
@property (weak, nonatomic) IBOutlet UITextView *weight;
@property (weak, nonatomic) IBOutlet UITextView *time;

@end
