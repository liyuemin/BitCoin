//
//  MSLoadingView.m
//  MSVideo
//
//  Created by mai on 17/7/27.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "MSLoadingView.h"
#import "Masonry.h"

@interface MSLoadingView ()
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIButton *centerBtn;
@end

@implementation MSLoadingView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = k_F4F4F4;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)cleanSubView
{
    if (_centerImageView)
    {
        [self.centerImageView removeFromSuperview];
        self.centerImageView = nil;
    }
    if (_centerLabel)
    {
        [self.centerLabel removeFromSuperview];
        self.centerLabel = nil;
    }
    if (_centerBtn)
    {
        [self.centerBtn removeFromSuperview];
        self.centerBtn = nil;
    }
}

- (void)setLoadingType:(MSLoadingType)loadingType
{
    self.hidden = NO;
//    [self cleanSubView];
    
    _loadingType = loadingType;
    switch (loadingType)
    {
        case MSLoadingBlankType:
        {
        }
            break;
        case MSLoadingLoadingType:
        {
        }
            break;
        case MSLoadingNoResultType:
        {
            _noResultType = MSNoResultBlankType;
        }
            break;
        default:
            break;
    }
}

- (void)setNoResultType:(MSNoResultType)noResultType
{
    self.hidden = NO;
    self.loadingType = MSLoadingNoResultType;
    _noResultType = noResultType;
    
    for (UIView *v in self.subviews)
    {
        [v removeFromSuperview];
    }
    
    switch (noResultType) {
        case MSNoResultBlankType:
        {
            
        }
            break;
        case MSNoResultNetType:
        {
            
            [self reloadCenterImageWithName:self.networkImage];
            [self reloadRetryBtn];
        }
            break;
        case MSNoResultSysMsgListType:
        {
            [self reloadCenterImageWithName:@"load_wuxiaoxi"];
             [self reloadCenterLabelWithName:@"暂无消息提醒"];
        }
            break;
       
        case MSNoResultShowreelType:
        {
            [self reloadRetryBtn];
             [self reloadUpLabelWithName:@"点击添加币种\n体验智能预警超强功能"];
        }
        default:
            break;
    }
}

- (void)reloadCenterImageWithName:(NSString *)imageName
{
    [self addSubview:self.centerImageView];
    [self.centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-80);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
    }];
    self.centerImageView.image = [UIImage imageNamed:imageName];
}

- (void)reloadCenterLabelWithName:(NSString *)labelName
{
    [self addSubview:self.centerLabel];
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerImageView.mas_centerY).offset(120);//120 是centerImageView的高度*0.5
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(20);
    }];
    self.centerLabel.text = labelName;
}

- (void)reloadUpLabelWithName:(NSString *)labelName{
    [self addSubview:self.centerLabel];
    [self.centerLabel setNumberOfLines:0];
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.centerBtn.mas_top).offset(-20);//120 是centerImageView的高度*0.5
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(40);
    }];
    self.centerLabel.text = labelName;

}

- (void)reloadRetryBtn
{
    if (_reloadImage != nil){
        [self.centerBtn setImage:[UIImage imageNamed:_reloadImage] forState:UIControlStateNormal];
    }
    [self addSubview:self.centerBtn];
    if (self.networkImage != nil){
         [self.centerBtn setTitle:@"刷新" forState:UIControlStateNormal];
        [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self.centerImageView.mas_centerY).offset(60+20);//120 是centerImageView的高度*0.5，20是vertical高度
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
    } else {
        [self.centerBtn sizeToFit];
        [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-30);//120 是centerImageView的高度*0.5，20是vertical高度
        }];

    }
    self.centerBtn.layer.cornerRadius = 3.0;
    self.centerBtn.layer.borderColor = k_E5E5E5.CGColor;
    self.centerBtn.layer.borderWidth = 1/[UIScreen mainScreen].scale;
}

- (void)clickRetry
{
    NSLog(@"%s",__func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(msLoadingRetryAction)])
    {
        [self.delegate msLoadingRetryAction];
    }
}

#pragma mark - Custom accessors

- (UIImageView *)centerImageView
{
    if (!_centerImageView)
    {
        _centerImageView = [[UIImageView alloc]init];
    }
    return _centerImageView;
}


- (UIButton *)centerBtn
{
    if (!_centerBtn)
    {
        _centerBtn = [[UIButton alloc]init];
        [_centerBtn setTitleColor:k_B5B5B5 forState:UIControlStateNormal];
        _centerBtn.backgroundColor = k_F4F4F4;
        [_centerBtn addTarget:self action:@selector(clickRetry) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

- (UILabel *)centerLabel
{
    if (!_centerLabel)
    {
        _centerLabel = [[UILabel alloc]init];
        _centerLabel.textColor = k_666666;
        _centerLabel.font = SYS_FONT(15);
        _centerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _centerLabel;
}

@end
