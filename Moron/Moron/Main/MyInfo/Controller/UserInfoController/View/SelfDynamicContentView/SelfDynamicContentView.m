//
//  SelfDynamicContentView.m
//  Moron
//
//  Created by bever on 16/4/14.
//  Copyright © 2016年 清风. All rights reserved.
//

#import "SelfDynamicContentView.h"
#import "PhotoView.h"
#import "SelfDynamicViewCell.h"


@implementation SelfDynamicContentView

{
    
    PhotoView *_photoView;

    SelfDynamicContentView *_contentView;
    
    NSMutableArray *_urls;
    
    UIImageView *_bgImageView;
    
}

- (void)awakeFromNib {
    
    _contentView = [[SelfDynamicContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-30, 0)];
    [self addSubview:_contentView];

    _contentLabel = [[CNLabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW-30, 0)];
    _contentLabel.textAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [self addSubview:_contentLabel];
    
    _photoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-30, 0)];
    [self addSubview:_photoView];
    
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [[UIImage imageNamed:@"timeline_rt_border_9@2x"] stretchableImageWithLeftCapWidth:25 topCapHeight:15];
        _bgImageView.userInteractionEnabled = YES;
        [self addSubview:_bgImageView];
        
        //文本内容
        _contentLabel = [[CNLabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW-30, 0)];
        _contentLabel.textAttributes = @{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]};
        [self addSubview:_contentLabel];
        
        //图片
        _photoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-30, 0)];
        [self addSubview:_photoView];
        
    }
    return self;
}

- (void)setModel:(SelfDynamicModel *)model {
    
    _model = model;
    
    //contentLabel
    int contentLabelH = 0;
    if (model.text) {
        
        _contentLabel.text = [NSString stringWithFormat:@"%@",_model.text];
        contentLabelH = _contentLabel.height+6;
    }
    
    //photoView
    int photoViewH = 0;
    if ([_model.pic_urls count]>0) {
        
        //修改imgV的Y轴
        _photoView.top = _contentLabel.bottom;
        
        NSMutableArray *imgUrls = [NSMutableArray arrayWithCapacity:9];
        
        for (NSDictionary *dic in _model.pic_urls) {
            
            NSString *imgUrl = [dic objectForKey:@"thumbnail_pic"];
            
            NSMutableString *urls = [NSMutableString stringWithString:imgUrl];
            [urls replaceCharactersInRange:[imgUrl rangeOfString:@"thumbnail"] withString:@"bmiddle"];
            
            [imgUrls addObject:urls];
        }
        
        //设置图片
        _photoView.dataList = imgUrls;
        
        //显示imgV
        _photoView.hidden = NO;
        
        photoViewH = _photoView.height;
        
    }
    else
    {
        //隐藏imgV
        _photoView.hidden = YES;
    }
    
    //contentViewH
    int contentViewH = 0;
    if (_model.retweetedModel) {
        
        //设置y轴
        _contentView.top = _contentLabel.bottom;
        
        _contentView.hidden = NO;
        
        _contentView.model = _model.retweetedModel;
        contentViewH = _contentView.height;
        
    }
    else
    {
        _contentView.hidden = YES;
    }
    
    //设置微博View的高度
    self.height = _contentLabel.height + photoViewH + contentViewH;
    
    //背景视图的高度设定
    if (_bgImageView) {
        _bgImageView.height = self.height;
    }
}





@end
