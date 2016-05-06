//
//  CellPushViewController.m
//  Moron
//
//  Created by bever on 16/4/25.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "CellPushViewController.h"

@interface CellPushViewController ()

@end

@implementation CellPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _title1;
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    webView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSURL *url = [NSURL URLWithString:_url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

@end
