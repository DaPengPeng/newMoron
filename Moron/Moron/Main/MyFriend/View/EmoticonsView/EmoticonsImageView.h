//
//  EmoticonsImageView.h
//  Moron
//
//  Created by bever on 16/4/28.
//  Copyright © 2016年 清风. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MyBlock) (NSString *name);

@interface EmoticonsImageView : UIView

- (instancetype)initWithFrame:(CGRect)frame withBlock:(MyBlock)blcok;

@property (nonatomic,retain) NSArray *dataList;

@end
