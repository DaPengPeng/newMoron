//
//  recordViewCell.h
//  Moron
//
//  Created by bever on 16/5/2.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recordViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *groupCount;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (nonatomic,retain) NSDictionary *dataDic;
@end
