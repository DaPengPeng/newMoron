//
//  DppScrollPageView.h
//  DppScrollPage
//
//  Created by bever on 16/4/16.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DppScrollPageView : UIView <UIScrollViewDelegate>

@property (nonatomic,assign) CGFloat minSpace;//item之间的最小间距

@property (nonatomic,assign) CGSize itemSize;//在宽度、高度上有几个item

@property (nonatomic,retain) NSArray *dataList;//数据源

//没有数据的包装，注意赋值的顺序

@end
