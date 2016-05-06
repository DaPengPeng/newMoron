//
//  CNLabel.h
//  WeiBoBV53
//
//  Created by wangjin on 16/1/5.
//  Copyright © 2016年 wangjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNLabel : UIView<UITextViewDelegate>
{
    UITextView *_textView;
}

@property (nonatomic, copy)NSString *text;

@property (nonatomic, retain)NSDictionary *textAttributes;

@end

@interface CNTextAttachMent : NSTextAttachment

@end
