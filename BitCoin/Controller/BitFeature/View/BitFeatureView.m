//
//  BitFeatureView.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/8.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitFeatureView.h"
#import "NSDate+YYAdd.h"

@interface BitFeatureView()
@property (nonatomic ,strong)UIButton *jumpButton;
@property (nonatomic ,strong)UILabel *oneTitleLabel;
@property (nonatomic ,strong)UILabel *oneRoseLabel;
@property (nonatomic ,strong)UILabel *oneMoneyLabel;
@property (nonatomic ,strong)UILabel *oneUnitLabel;
@property (nonatomic ,strong)UILabel *twoTitleLabel;
@property (nonatomic ,strong)UILabel *twoRoseLabel;
@property (nonatomic ,strong)UILabel *twoMoneyLabel;
@property (nonatomic ,strong)UILabel *twoUnitLabel;
@property (nonatomic ,strong)UILabel *threeTitleLabel;
@property (nonatomic ,strong)UILabel *threeRoseLabel;
@property (nonatomic ,strong)UILabel *threeMoneyLabel;
@property (nonatomic ,strong)UILabel *threeUnitLabel;
@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)UIImageView *iconImageView;
@property (nonatomic ,assign)NSInteger count;
@property (nonatomic ,strong)NSTimer *timer;
@end

@implementation BitFeatureView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setBackgroundColor:k_3C424A];
        [self setUpViews];
        [self setConstraintViews];
        self.count = 4;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(apperJupButtonTitle:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)apperJupButtonTitle:(NSTimer *)atimer{
    self.count --;
    if (self.count >=0){
        [self.jumpButton setTitle:[NSString stringWithFormat:@"跳过%lds",self.count] forState:UIControlStateNormal];
    }if (self.count == 0){
        [self removeAll:self.jumpButton];
        [_timer invalidate];
        _timer = nil;
    }

}

- (void)setUpViews{
    [self addSubview:self.jumpButton];
    [self addSubview:self.oneTitleLabel];
    [self addSubview:self.oneRoseLabel];
    [self addSubview:self.oneMoneyLabel];
    [self addSubview:self.oneUnitLabel];
    [self addSubview:self.twoUnitLabel];
    [self addSubview:self.twoTitleLabel];
    [self addSubview:self.twoRoseLabel];
    [self addSubview:self.twoMoneyLabel];
    [self addSubview:self.threeTitleLabel];
    [self addSubview:self.threeMoneyLabel];
    [self addSubview:self.threeRoseLabel];
    [self addSubview:self.threeUnitLabel];
    [self addSubview:self.iconImageView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.bgImageView];
}

- (void)setConstraintViews{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(0);
        maker.top.mas_equalTo(self).offset(0);
        maker.bottom.mas_equalTo(self).offset(0);
        maker.left.mas_equalTo(self).offset(0);
    }];
    [self.jumpButton mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.top.mas_equalTo(self).offset(20);
        maker.width.mas_equalTo(60);
        maker.height.mas_equalTo(30);
    }];
    
    [self.oneTitleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self).offset(150);
        maker.height.mas_equalTo(20);
    }];
    [self.oneRoseLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.oneTitleLabel.mas_bottom).offset(8);
        maker.height.mas_equalTo(20);
    }];
    [self.oneMoneyLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.oneRoseLabel.mas_bottom).offset(16);
        maker.height.mas_equalTo(40);
    }];
    
    [self.oneUnitLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.oneMoneyLabel.mas_bottom).offset(12);
        maker.height.mas_equalTo(20);
    }];
    
    [self.twoTitleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-(ScreenWidth/2 + 15));
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.oneUnitLabel.mas_bottom).offset(31);
        maker.height.mas_equalTo(25);
    }];
    
    [self.twoRoseLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-(ScreenWidth/2 + 15));
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.twoTitleLabel.mas_bottom).offset(4);
        maker.height.mas_equalTo(20);
    }];
    [self.twoMoneyLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-(ScreenWidth/2 + 15));
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.twoRoseLabel.mas_bottom).offset(12);
        maker.height.mas_equalTo(40);
    }];
    
    [self.twoUnitLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-(ScreenWidth/2 + 15));
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.twoMoneyLabel.mas_bottom).offset(12);
        maker.height.mas_equalTo(20);
    }];
    
    [self.threeTitleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(- 15);
        maker.left.mas_equalTo(self).offset(ScreenWidth/2 + 15);
        maker.top.mas_equalTo(self.oneUnitLabel.mas_bottom).offset(31);
        maker.height.mas_equalTo(25);
    }];
    
    [self.threeRoseLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(- 15);
        maker.left.mas_equalTo(self).offset(ScreenWidth/2 + 15);
        maker.top.mas_equalTo(self.threeTitleLabel.mas_bottom).offset(4);
        maker.height.mas_equalTo(20);
    }];
    [self.threeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.left.mas_equalTo(self).offset(ScreenWidth/2 + 15);
        maker.top.mas_equalTo(self.threeRoseLabel.mas_bottom).offset(12);
        maker.height.mas_equalTo(40);
    }];
    
    [self.threeUnitLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.left.mas_equalTo(self).offset(ScreenWidth/2 + 15);
        maker.top.mas_equalTo(self.threeMoneyLabel.mas_bottom).offset(12);
        maker.height.mas_equalTo(20);
    }];
    

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.bottom.mas_equalTo(self).offset(-120);
        maker.left.mas_equalTo(self).offset(15);
        maker.right.mas_equalTo(self).offset(-15);
        maker.height.mas_equalTo(20);
    }];



}

- (UIButton *)jumpButton{
    if (!_jumpButton){
        _jumpButton = [[UIButton alloc] init];
        [_jumpButton addTarget:self action:@selector(removeAll:) forControlEvents:UIControlEventTouchUpInside];
        [_jumpButton setBackgroundColor:k_292929];
        [_jumpButton setTitle:@"跳过3s" forState:UIControlStateNormal];
        [_jumpButton.titleLabel setTextColor:k_BDBDBD];
        [_jumpButton.titleLabel setFont:SYS_FONT(14)];
    }
    return _jumpButton;
}

- (UILabel *)oneTitleLabel{
    if (!_oneTitleLabel){
        _oneTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_oneTitleLabel setTextColor:[UIColor whiteColor]];
        [_oneTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [_oneTitleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _oneTitleLabel;
}
- (UILabel *)oneRoseLabel{
    if (!_oneRoseLabel){
        _oneRoseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_oneRoseLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _oneRoseLabel;
}

- (UILabel *)oneMoneyLabel{
    if (!_oneMoneyLabel){
        _oneMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_oneMoneyLabel setTextAlignment:NSTextAlignmentCenter];
        [_oneMoneyLabel setTextColor:[UIColor whiteColor]];
        [_oneMoneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:36]];

    }
    return _oneMoneyLabel;
}

- (UILabel *)oneUnitLabel{
    if (!_oneUnitLabel){
        _oneUnitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_oneUnitLabel setTextAlignment:NSTextAlignmentCenter];
        [_oneUnitLabel setTextColor:k_A0A0A0];
        [_oneUnitLabel setFont:SYS_FONT(12)];
    }
    return _oneUnitLabel;
}
- (UILabel *)twoTitleLabel{
    if (!_twoTitleLabel){
        _twoTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_twoTitleLabel setTextAlignment:NSTextAlignmentRight];
        [_twoTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [_twoTitleLabel setTextColor:[UIColor whiteColor]];
    }
    return _twoTitleLabel;
}
- (UILabel *)twoRoseLabel{
    if (!_twoRoseLabel){
        _twoRoseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_twoRoseLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _twoRoseLabel;
}

- (UILabel *)twoMoneyLabel{
    if (!_twoMoneyLabel){
        _twoMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
         [_twoMoneyLabel setTextAlignment:NSTextAlignmentRight];
        [_twoMoneyLabel setTextColor:[UIColor whiteColor]];
        [_twoMoneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];

    }
    return _twoMoneyLabel;
}

- (UILabel *)twoUnitLabel{
    if (!_twoUnitLabel){
        _twoUnitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_twoUnitLabel setTextAlignment:NSTextAlignmentRight];
        [_twoUnitLabel setTextColor:k_A0A0A0];
        [_twoUnitLabel setFont:SYS_FONT(12)];

    }
    return _twoUnitLabel;
}
- (UILabel *)threeTitleLabel{
    if (!_threeTitleLabel){
        _threeTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_threeTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_threeTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [_threeTitleLabel setTextColor:[UIColor whiteColor]];

    }
    return _threeTitleLabel;
}
- (UILabel *)threeRoseLabel{
    if (!_threeRoseLabel){
        _threeRoseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
         [_threeRoseLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _threeRoseLabel;
}

- (UILabel *)threeMoneyLabel{
    if (!_threeMoneyLabel){
        _threeMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_threeMoneyLabel setTextAlignment:NSTextAlignmentLeft];
        [_threeMoneyLabel setTextColor:[UIColor whiteColor]];
        [_threeMoneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];

    }
    return _threeMoneyLabel;
}

- (UILabel *)threeUnitLabel{
    if (!_threeUnitLabel){
        _threeUnitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
         [_threeUnitLabel setTextAlignment:NSTextAlignmentLeft];
        [_threeUnitLabel setTextColor:k_A0A0A0];
        [_threeUnitLabel setFont:SYS_FONT(12)];

    }
    return _threeUnitLabel;
}





-(UIImageView *)iconImageView{
    if (!_iconImageView){
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)timeLabel{
    if (!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_timeLabel setTextColor:k_A0A0A0];
        [_timeLabel setFont:SYS_FONT(14)];
        [_timeLabel setTextAlignment:NSTextAlignmentCenter];

    }
    return _timeLabel;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView){
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _bgImageView;
}

- (void)removeAll:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(removeFeatureView:)]){
        [_delegate removeFeatureView:self];
    }
}

- (void)setFeatureData:(NSArray *)array{
    BitEnity *oneEntity = [array objectAtIndex:0];
    BitEnity *twoEntity  = [array objectAtIndex:1];
    BitEnity *threeEntity = [array objectAtIndex:2];
    [self.oneTitleLabel setText:oneEntity.btc_title_display];
    if ([oneEntity.rising floatValue] >= 0){
        [self.oneRoseLabel setTextColor:k_D0402D];
        [self.oneRoseLabel setText:[NSString stringWithFormat:@"+%.2lf%%",[oneEntity.rising floatValue]/100.0]];
        UIView *aview =     [self creatLabelView:[NSString stringWithFormat:@"%.2lf",[oneEntity.btc_price floatValue]] withFont:[UIFont fontWithName:@"Helvetica-Bold" size:36] withColor:k_D0402D withHeight:20];
        [self addSubview:aview];
        [self sendSubviewToBack:aview];
        [aview setCenter:CGPointMake(self.oneMoneyLabel.center.x, self.oneMoneyLabel.center.y + 8)];

    }else {
        [self.oneRoseLabel setTextColor:k_17B03E];
        [self.oneRoseLabel setText:[NSString stringWithFormat:@"%.2lf%%",[oneEntity.rising floatValue]/100.0]];
        UIView *aview =     [self creatLabelView:[NSString stringWithFormat:@"%.2lf",[oneEntity.btc_price floatValue]] withFont:[UIFont fontWithName:@"Helvetica-Bold" size:36] withColor:k_17B03E withHeight:20];
        [self addSubview:aview];
        [self sendSubviewToBack:aview];
        [aview setCenter:CGPointMake(self.oneMoneyLabel.center.x, self.oneMoneyLabel.center.y + 8)];

    }
    
    [self.oneMoneyLabel setText:[NSString stringWithFormat:@"%.2lf",[oneEntity.btc_price floatValue]]];

    [self.oneUnitLabel setText:@"元／个"];
    
    [self.twoTitleLabel setText:twoEntity.btc_title_display];
    [self.twoRoseLabel setText:[NSString stringWithFormat:@"%.2lf%%",[twoEntity.rising floatValue]/100.0]];
    if ([twoEntity.rising floatValue] >= 0){
        [self.twoRoseLabel setTextColor:k_D0402D];
            [self.twoRoseLabel setText:[NSString stringWithFormat:@"+%.2lf%%",[twoEntity.rising floatValue]/100.0]];
        UIView *aview =     [self creatLabelView:[NSString stringWithFormat:@"%.2lf",[twoEntity.btc_price floatValue]] withFont:[UIFont fontWithName:@"Helvetica-Bold" size:30] withColor:k_D0402D withHeight:12];
        [self addSubview:aview];
        [self sendSubviewToBack:aview];
        [aview setCenter:CGPointMake((ScreenWidth/2 - 15) - aview.frame.size.width/2, self.twoMoneyLabel.center.y + 8)];

    }else {
        [self.twoRoseLabel setTextColor:k_17B03E];
        [self.twoRoseLabel setText:[NSString stringWithFormat:@"%.2lf%%",[twoEntity.rising floatValue]/100.0]];
        UIView *aview =     [self creatLabelView:[NSString stringWithFormat:@"%.2lf",[twoEntity.btc_price floatValue]] withFont:[UIFont fontWithName:@"Helvetica-Bold" size:30] withColor:k_17B03E withHeight:12];
        [self addSubview:aview];
        [self sendSubviewToBack:aview];
        [aview setCenter:CGPointMake((ScreenWidth/2 - 15) - aview.frame.size.width/2, self.twoMoneyLabel.center.y + 8)];

    }

    [self.twoMoneyLabel setText:[NSString stringWithFormat:@"%.2lf",[twoEntity.btc_price floatValue]]];
    [self.twoUnitLabel setText:@"元／个"];
    
    [self.threeTitleLabel setText:threeEntity.btc_title_display];
    
    if ([threeEntity.rising floatValue] >= 0){
        [self.threeRoseLabel setTextColor:k_D0402D];
        [self.threeRoseLabel setText:[NSString stringWithFormat:@"+%.2lf%%",[threeEntity.rising floatValue]/100.0]];
        UIView *aview =     [self creatLabelView:[NSString stringWithFormat:@"%.2lf",[threeEntity.btc_price floatValue]] withFont:[UIFont fontWithName:@"Helvetica-Bold" size:30] withColor:k_D0402D withHeight:12];
        [self addSubview:aview];
        [self sendSubviewToBack:aview];
        [aview setCenter:CGPointMake((ScreenWidth/2 + 15) + aview.frame.size.width/2, self.threeMoneyLabel.center.y + 8)];

    }else {
        [self.threeRoseLabel setTextColor:k_17B03E];
        [self.threeRoseLabel setText:[NSString stringWithFormat:@"%.2lf%%",[threeEntity.rising floatValue]/100.0]];
        UIView *aview =     [self creatLabelView:[NSString stringWithFormat:@"%.2lf",[threeEntity.btc_price floatValue]] withFont:[UIFont fontWithName:@"Helvetica-Bold" size:30] withColor:k_17B03E withHeight:12];
        [self addSubview:aview];
        [self sendSubviewToBack:aview];
        [aview setCenter:CGPointMake((ScreenWidth/2 + 15) + aview.frame.size.width/2, self.threeMoneyLabel.center.y + 8)];

    }

    [self.threeMoneyLabel setText:[NSString stringWithFormat:@"%.2lf",[threeEntity.btc_price floatValue]]];
    

    [self.threeUnitLabel setText:@"元／个"];
    [self.iconImageView setImage:[UIImage imageNamed:@"home_feature_icon"]];
    [self.iconImageView sizeToFit];
    
    [self.iconImageView  setCenter:CGPointMake(ScreenWidth/2, ScreenHeight - 50)];
    
    NSDate *date = [NSDate date];
    NSLog(@"当前零时区时间 %@", date);
    
    
    [self.timeLabel setText:[NSString stringWithFormat:@"北京时间 %@:%@    %ld.%@.%@",[self getDoubleIntSring:[date hour]],[self getDoubleIntSring:[date minute]],[date year],[self getDoubleIntSring:[date month]],[self getDoubleIntSring:[date day]]]];
}

- (UIView *)creatLabelView:(NSString *)sring withFont:(UIFont *)font withColor:(UIColor *)color withHeight:(CGFloat)height{
    
    CGSize size = [sring boundingRectWithSize:CGSizeMake(ScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, height)];
    [aview setBackgroundColor:color];
    return aview;
}

- (NSString *)getDoubleIntSring:(NSInteger )terger{
    if (terger >= 10){
        return [NSString stringWithFormat:@"%ld",terger];
    }else {
        return [NSString stringWithFormat:@"0%ld",terger];
    }
}



@end
