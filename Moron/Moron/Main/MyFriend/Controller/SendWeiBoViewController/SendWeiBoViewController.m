//
//  SendWeiBoViewController.m
//  Moron
//
//  Created by bever on 16/4/28.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "SendWeiBoViewController.h"
#import "EmoticonsView.h"

@interface SendWeiBoViewController () {

    UIButton *_button;
}

@end

@implementation SendWeiBoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //添加一个观察者，更改button的背景颜色
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        if (![_textView.text isEqualToString:@""]) {
            
            _textView.label.hidden = YES;
            [_button setBackgroundImage:[UIImage imageNamed:@"icon_button_see_movieInfo@2x"] forState:UIControlStateNormal];
        }else {
            _textView.label.hidden = NO;
            [_button setBackgroundImage:[UIImage imageNamed:@"icon_hot_show_buy@2x"] forState:UIControlStateNormal];
        }
    }];
    
    self.title = @"发动态";
    
    //添加导航栏右侧发送按钮
    [self addRightButton];
    
    //添加左侧返回按钮
    [self addCustomBackButton];
    
    //设置textView 成为第一响应者
    [_textView becomeFirstResponder];
    
    //添加工具栏
    [self createToolBar];
    
}

//添加自定义返回按钮
- (void)addCustomBackButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setImage:[UIImage imageNamed:@"top_back_white"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

//按钮的相应事件
- (void)buttonAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}


//添加导航栏右侧发送按钮
- (void)addRightButton {

    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, 50, 30);
    _button.backgroundColor = [UIColor clearColor];
    [_button setTitle:@"发送" forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:15];
    [_button setBackgroundImage:[UIImage imageNamed:@"icon_hot_show_buy@2x"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:_button];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)buttonAct:(UIButton *)button {

    
    [DppNetworking POST:@"https://api.weibo.com/2/statuses/update.json" parmeters:@{@"access_token":kAccessToken,@"status":_textView.text} withBlcok:^(id resulte) {
        //控制器的pop
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

//添加键盘上方的view
//添加工具按钮栏
-(void)createToolBar
{
    UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
    
    toolBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    
    NSArray *imgNames = @[@"compose_toolbar_1",@"compose_toolbar_3",@"compose_toolbar_4",@"compose_toolbar_5",@"compose_toolbar_6"];
    
    for (int i = 0; i<5; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*kScreenW/5, 0, kScreenW/5, 44)];
        
        [btn setImage:[UIImage imageNamed:imgNames[i]] forState:UIControlStateNormal];
        
        btn.tag = 100+i;
        
        [btn addTarget:self action:@selector(toolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [toolBar addSubview:btn];
        
    }
    
    _textView.inputAccessoryView = toolBar;//将工具栏放在textView的上方
    
}

-(void)toolBarBtn:(UIButton *)btn
{
    switch (btn.tag) {
        case 104:
            
            //添加表情包
            [self addFaceView];
            
            break;
            
        default:
            break;
    }
}

-(void)addFaceView
{
    EmoticonsView *faceView = [[EmoticonsView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 220) withBlock:^(NSString *name) {
        
        //将name插入到文本中
        
        //获取光标的位置
        NSRange range = _textView.selectedRange;
        
        NSMutableString *text = [[NSMutableString alloc] initWithFormat:@"%@",_textView.text];
        
        //将图片文本插入都大文本中
        [text insertString:name atIndex:range.location];
        //设置插入后的新文本
        _textView.text = text;
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:nil];
        
        
        //重新设置光标位置
        range.location = range.location + name.length;
        
        _textView.selectedRange = range;
        
    }];
    
    if (!_textView.inputView) {
        [_textView resignFirstResponder];
        _textView.inputView = faceView;
        [_textView becomeFirstResponder];
    }
    else
    {
        [_textView resignFirstResponder];
        _textView.inputView = nil;
        [_textView becomeFirstResponder];
    }
    
}

//观察者的移除
- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
