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
@end

@implementation BitFeatureView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setBackgroundColor:k_3C424A];
        [self setUpViews];
        [self setConstraintViews];
    }
    return self;
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
}

- (void)setConstraintViews{
    [self.jumpButton mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.top.mas_equalTo(self).offset(15);
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
        maker.right.mas_equalTo(self).offset(ScreenWidth/2 - 15);
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.oneMoneyLabel.mas_bottom).offset(55);
        maker.height.mas_equalTo(25);
    }];
    
    [self.twoRoseLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(ScreenWidth/2 - 15);
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.twoTitleLabel.mas_bottom).offset(4);
        maker.height.mas_equalTo(20);
    }];
    [self.twoMoneyLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(ScreenWidth/2 - 15);
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.twoRoseLabel.mas_bottom).offset(12);
        maker.height.mas_equalTo(40);
    }];
    
    [self.twoUnitLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(ScreenWidth/2 - 15);
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.twoMoneyLabel.mas_bottom).offset(12);
        maker.height.mas_equalTo(20);
    }];
    
    [self.threeTitleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(- 15);
        maker.left.mas_equalTo(self).offset(ScreenWidth/2 - 15);
        maker.top.mas_equalTo(self.oneMoneyLabel.mas_bottom).offset(55);
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
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.centerX.mas_equalTo(self);
        maker.centerY.mas_equalTo(self).offset(ScreenHeight - 54);
        maker.width.mas_equalTo(142);
        maker.height.mas_equalTo(45);
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.bottom.mas_equalTo(self.iconImageView.mas_top).offset(30);
        maker.left.mas_equalTo(self).offset(15);
        maker.right.mas_equalTo(self).offset(-15);
        maker.height.mas_equalTo(20);
    }];



}

- (UIButton *)jumpButton{
    if (!_jumpButton){
        _jumpButton = [[UIButton alloc] init];
    }
    return _jumpButton;
}

- (UILabel *)oneTitleLabel{
    if (!_oneTitleLabel){
        _oneTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _oneTitleLabel;
}
- (UILabel *)oneRoseLabel{
    if (!_oneRoseLabel){
        _oneRoseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _oneRoseLabel;
}

- (UILabel *)oneMoneyLabel{
    if (!_oneMoneyLabel){
        _oneMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _oneMoneyLabel;
}

- (UILabel *)oneUnitLabel{
    if (!_oneUnitLabel){
        _oneUnitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _oneUnitLabel;
}
- (UILabel *)twoTitleLabel{
    if (!_twoTitleLabel){
        _twoTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _twoTitleLabel;
}
- (UILabel *)twoRoseLabel{
    if (!_twoRoseLabel){
        _twoRoseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _twoRoseLabel;
}

- (UILabel *)twoMoneyLabel{
    if (!_twoMoneyLabel){
        _twoMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _twoMoneyLabel;
}

- (UILabel *)twoUnitLabel{
    if (!_twoUnitLabel){
        _twoUnitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _oneUnitLabel;
}
- (UILabel *)threeTitleLabel{
    if (!_threeTitleLabel){
        _threeTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _oneTitleLabel;
}
- (UILabel *)threeRoseLabel{
    if (!_threeRoseLabel){
        _threeRoseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _threeRoseLabel;
}

- (UILabel *)threeMoneyLabel{
    if (!_threeMoneyLabel){
        _threeMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _threeMoneyLabel;
}

- (UILabel *)threeUnitLabel{
    if (!_threeUnitLabel){
        _threeUnitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _threeUnitLabel;
}





-(UIImageView *)iconImageView{
    if (!_iconImageView){
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _iconImageView;
}

- (UILabel *)timeLabel{
    if (!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _timeLabel;
}



- (void)setFeatureData:(NSArray *)array{
    BitEnity *oneEntity = [array objectAtIndex:0];
    BitEnity *twoEntity  = [array objectAtIndex:1];
    BitEnity *threeEntity = [array objectAtIndex:2];
    [self.oneTitleLabel setText:oneEntity.btc_title_display];
    [self.oneRoseLabel setText:[NSString stringWithFormat:@"%.2lf%%",[oneEntity.rising floatValue]/100.0]];
    [self.oneMoneyLabel setText:[NSString stringWithFormat:@"￥%.2lf",[oneEntity.btc_price floatValue]]];
    [self.oneUnitLabel setText:@"元／个"];
    
    [self.twoTitleLabel setText:twoEntity.btc_title_display];
    [self.twoRoseLabel setText:[NSString stringWithFormat:@"%.2lf%%",[twoEntity.rising floatValue]/100.0]];
    [self.twoMoneyLabel setText:[NSString stringWithFormat:@"￥%.2lf",[twoEntity.btc_price floatValue]]];
    [self.twoUnitLabel setText:@"元／个"];
    
    [self.threeTitleLabel setText:threeEntity.btc_title_display];
    [self.threeRoseLabel setText:[NSString stringWithFormat:@"%.2lf%%",[threeEntity.rising floatValue]/100.0]];
    [self.threeMoneyLabel setText:[NSString stringWithFormat:@"￥%.2lf",[threeEntity.btc_price floatValue]]];
    [self.threeUnitLabel setText:@"元／个"];
    [self.iconImageView setImage:[UIImage imageNamed:@"home_feature_icon"]];
    
    NSDate *date = [NSDate date];
    NSLog(@"当前零时区时间 %@", date);
    
    //2.获得本地时间 东八区 晚八个小时 以秒计时
    NSDate *date1 = [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60];
    
    [self.timeLabel setText:[NSString stringWithFormat:@"北京时间 %@     %@",[date1 stringWithFormat:@"HH:mm"],[date1 stringWithFormat:@"yyyy-MM-dd"]]];
    
    
}



@end
