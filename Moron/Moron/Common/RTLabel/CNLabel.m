//
//  CNLabel.m
//  WeiBoBV53
//
//  Created by wangjin on 16/1/5.
//  Copyright © 2016年 wangjin. All rights reserved.
//

#import "CNLabel.h"

@implementation CNLabel
{
    NSMutableDictionary *_iconDic;
}

- (void)awakeFromNib {

    self.frame = CGRectMake(0, 0, self.superview.width, 0);
    
    //初始化textView
    [self createTextView];
    
    //清空背景颜色
    self.backgroundColor = [UIColor clearColor];
    
    //解析plist文件 中文字符--图片
    [self loadIconDic];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //初始化textView
        [self createTextView];
        
        //清空背景颜色
        self.backgroundColor = [UIColor clearColor];
        
        //解析plist文件 中文字符--图片
        [self loadIconDic];
    }
    
    return self;
}

//解析 中文字符对应图片的数据
-(void)loadIconDic
{
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    
    //解析该文件
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    
    //初始化字典
    _iconDic = [NSMutableDictionary dictionary];
    
    for (NSDictionary *dic in arr) {
        
        //拿出代表图片的字符串 [**]
        NSString *imgNameKey = [dic objectForKey:@"chs"];
        
        //拿出图片
        NSString *imgNameValue = [dic objectForKey:@"png"];
        
        //将图片与名字 作为键值对存放入新的字典
        [_iconDic setValue:imgNameValue forKey:imgNameKey];
    }
    
}

//初始化textView
-(void)createTextView
{
    _textView = [[UITextView alloc] initWithFrame:self.bounds];
    
    _textView.scrollEnabled = NO;
    
    _textView.editable = NO;
    
    _textView.delegate = self;
    
    _textView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_textView];
}

//复写set方法
-(void)setText:(NSString *)text
{
    _text = [text copy];
    
    //实现文本高度的计算
    [self loadAttributedString];
    
}

-(void)loadAttributedString
{
    //将普通文本字符串转化为带有富文本属性的字符串
    NSMutableAttributedString *att;
    
    if (self.textAttributes) {
        //如果在外部设置了文本的其它属性则使用该方式初始化
        att = [[NSMutableAttributedString alloc] initWithString:_text attributes:_textAttributes];
    }
    else
    {
        att = [[NSMutableAttributedString alloc] initWithString:_text];
    }
    
    //图文混排
    [self praseString:att];
    
    //超链接
    [self praseLink:att];
    
    //计算文本高度
    [self height:att];
    
    //给textview设置富文本字符串
    _textView.attributedText = att;
    
    //设置当前cnlabel的高度（高度等于textView的高度）
    self.height = _textView.height;
}

//实现图文混排
-(void)praseString:(NSMutableAttributedString *)att
{
    //1.查找符合要求的字符串 并且获取range范围
    NSArray *ranges = [self rangeOfString:@"\\[\\w{1,5}\\]"];
    
    //2.倒叙遍历数组 并且替换字符串
    for (int i = (int)ranges.count-1; i>=0; i--) {
        
        //获取到range范围 --将要替换的字符串的范围
        NSRange range = [ranges[i] rangeValue];
        
        //通过range截取字符串
        NSString *substr = [_text substringWithRange:range];
        
        //通过截取的字符串去替换图片
        NSString *imgName = [_iconDic objectForKey:substr];
        
        //用来接受图片
        CNTextAttachMent *attachment = [[CNTextAttachMent alloc] init];
        
        //设置image属性
        attachment.image = [UIImage imageNamed:imgName];
        
        //可以设置图像文本大小
//        attachment.bounds
        
        //删除原有字符串
        if (imgName) {
            
            [att deleteCharactersInRange:range];
        }
        
        //将带有图片属性的attachment对象转化NSAttributedString
        NSAttributedString *insertStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        //在删除原有字符串的location位置插入图片文本字符串
        [att insertAttributedString:insertStr atIndex:range.location];
    }
}

//超链接字符
-(void)praseLink:(NSMutableAttributedString *)att
{
    //连接字符串
    NSString *linkStr = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    
    //@用户 字符串
    NSString *userStr = @"@[\\w]+";
    
    //话题 字符串
    NSString *topicStr = @"#[\\w]+#";
    
    NSArray *arr = @[linkStr,userStr,topicStr];
    
    for (NSString *str in arr) {
        
        //将字符串初始化为正则对象
        NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:str options:NSRegularExpressionCaseInsensitive error:nil];
        
        //通过正则对象 到文本中找到适配的字符  并且返回一组结果
        NSArray *results = [regular matchesInString:att.string options:NSMatchingReportProgress range:NSMakeRange(0, att.length)];
        
        //遍历结果数组
        for (NSTextCheckingResult *result in results) {
            //获取range
            NSRange range = result.range;
            
            //通过range获取到适配的字符串
            NSString *str = [att.string substringWithRange:range];
            
            //转化字符串为超链接样式
            NSString *linkStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            //在富文本字符串中将适配的字符转化为可连接属性
            [att addAttribute:NSLinkAttributeName value:linkStr range:range];
            
        }
        
    }
}

//查找符合要求的字符串 并且返回一组range范围
-(NSArray *)rangeOfString:(NSString *)str
{
    //将传入的字符串初始化为正则表达式对象
    NSRegularExpression *reguler = [[NSRegularExpression alloc] initWithPattern:str options:NSRegularExpressionCaseInsensitive error:nil];
    
    //通过正则表达式到字符串中匹配正确对象
    NSArray *results = [reguler matchesInString:self.text options:NSMatchingReportProgress range:NSMakeRange(0, self.text.length)];
    
    NSMutableArray *ranges = [NSMutableArray array];
    
    //遍历匹配结果 获取range并放入新的数组
    for (NSTextCheckingResult *result in results) {
        //获取到匹配字符串的range范围
        NSRange range = result.range;
        
        //将range转化为oc对象  目的：放入数组中
        NSValue *value = [NSValue valueWithRange:range];
        
        [ranges addObject:value];
        
    }
    
    //返回数组
    return ranges;
}

//计算高度
-(void)height:(NSMutableAttributedString *)att
{
    //根据富文本字符串 计算文本高度 会以cgrect类型返回
   CGRect frame = [att boundingRectWithSize:CGSizeMake(_textView.frame.size.width, 9999.f) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    if (self.textAttributes) {
        
        NSString *string = [att string];
        frame = [string boundingRectWithSize:CGSizeMake(_textView.frame.size.width, 9999.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.textAttributes context:nil];
    }
    
    CGRect textFrame = _textView.frame;
    
    textFrame.size.height = frame.size.height+18;
    
    _textView.frame = textFrame;
    
}

#pragma mark-------
//点击超链接时执行
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    
    [[UIApplication sharedApplication] openURL:URL];
    
    return YES;
}


@end

@implementation CNTextAttachMent

//修改图像文本的大小
-(CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0, 0, lineFrag.size.height, lineFrag.size.height);
}


@end
