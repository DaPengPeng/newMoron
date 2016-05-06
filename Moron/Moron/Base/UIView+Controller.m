//
//  UIView+Controller.m
//  Moron
//
//  Created by bever on 16/4/13.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)

- (UIViewController *)getViewController {

    UIResponder *responder = self;
    
    do {
        
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
        
    } while (responder != nil);
    
    return nil;
}

@end
