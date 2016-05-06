//
//  DiscoverHeaderView.m
//  Moron
//
//  Created by bever on 16/4/23.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "DiscoverHeaderView.h"
#import "ClassifyViewController.h"
#import "MovieViewController.h"
#import "MapViewController.h"
#import "NearbyViewController.h"

@implementation DiscoverHeaderView

- (void)awakeFromNib {

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DiscoverContentJson" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *array = dic[@"header"];
    _scrollPageView.minSpace = 0;
    _scrollPageView.itemSize = CGSizeMake(kScreenW, 170);
    _scrollPageView.dataList = array;
    
    _food.layer.cornerRadius = 35/2;
    _movies.layer.cornerRadius = 35/2;
    _nearBy.layer.cornerRadius = 35/2;
    _food.layer.masksToBounds = YES;
    _movies.layer.masksToBounds = YES;
    _nearBy.layer.masksToBounds = YES;
}

//附近
- (void)secondButtonAction:(UIButton *)sender {

//    MapViewController *mapVC = [[MapViewController alloc] init];
//    [[self viewController].navigationController pushViewController:mapVC animated:YES];
    
    NearbyViewController *nearVC = [[NearbyViewController alloc] init];
    [[self viewController].navigationController pushViewController:nearVC animated:YES];
}

//食物
- (IBAction)thirdButtonAction:(UIButton *)sender {
    
    ClassifyViewController *foodVC = [[ClassifyViewController alloc] init];
    
    [[self viewController].navigationController pushViewController:foodVC animated:YES];
}

//视频
- (IBAction)firestButtonAction:(UIButton *)sender {
    
    MovieViewController *movieVC = [[MovieViewController alloc] init];
    
    [[self viewController].navigationController pushViewController:movieVC animated:YES];
}


@end
