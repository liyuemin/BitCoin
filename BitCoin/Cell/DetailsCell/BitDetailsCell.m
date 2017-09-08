//
//  BitDetailsCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/7.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitDetailsCell.h"

@interface BitDetailsCell()
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *tradePlatformLabel;
@property (nonatomic ,strong)UILabel *tradeAmountLabel;
@property (nonatomic ,strong)UILabel *priceLabel;
@property (nonatomic ,strong)UILabel *roseRateLabel;
@property (nonatomic ,strong)UILabel *rosePriceLabel;
@property (nonatomic ,strong)UIButton *followButton;
@end

@implementation BitDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpViews];
        [self setConstraintsViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setUpViews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.tradePlatformLabel];
    [self.contentView addSubview:self.tradeAmountLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.roseRateLabel];
    [self.contentView addSubview:self.rosePriceLabel];
    [self.contentView addSubview:self.followButton];
}

- (void)setConstraintsViews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.contentView).offset(18);
        maker.width.mas_equalTo(150);
        maker.height.mas_equalTo(20);
    }];
    [self.tradePlatformLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        maker.width.mas_equalTo(200);
        maker.height.mas_equalTo(20);
    }];

    [self.tradeAmountLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.tradePlatformLabel.mas_bottom).offset(14);
        maker.width.mas_equalTo(200);
        maker.height.mas_equalTo(20);
    }];

    [self.followButton mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self.contentView).offset(-15);
        maker.top.mas_equalTo(self.contentView).offset(16);
        maker.width.mas_equalTo(60);
        maker.height.mas_equalTo(24);
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self.contentView).offset(-15);
        maker.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        maker.width.mas_equalTo(150);
        maker.height.mas_equalTo(20);
    }];

    [self.roseRateLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self.contentView).offset(-15);
        maker.top.mas_equalTo(self.priceLabel.mas_bottom).offset(14);
        maker.width.mas_equalTo(80);
        maker.height.mas_equalTo(20);
    }];

    [self.rosePriceLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self.roseRateLabel.mas_left).offset(30);
        maker.top.mas_equalTo(self.priceLabel.mas_bottom).offset(14);
        maker.width.mas_equalTo(80);
        maker.height.mas_equalTo(20);
    }];

}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setFont:SYS_FONT(15)];
        [_titleLabel setTextColor:k_3C3C3C];
    }
    return _titleLabel;
}

- (UILabel *)tradePlatformLabel{
    if (!_tradePlatformLabel){
        _tradePlatformLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_tradePlatformLabel setTextColor:k_9596AB];
        [_tradePlatformLabel setFont:SYS_FONT(14)];
    }
    return _tradePlatformLabel;
}

- (UILabel *)tradeAmountLabel{
    if (!_tradeAmountLabel){
        _tradeAmountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_tradeAmountLabel setTextColor:k_9596AB];
        [_tradeAmountLabel setFont:SYS_FONT(14)];
    }
    return _tradeAmountLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel){
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [_priceLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _priceLabel;
}

- (UILabel *)roseRateLabel{
    if (!_roseRateLabel){
        _roseRateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_roseRateLabel setFont:SYS_FONT(14)];
         [_roseRateLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _roseRateLabel;
}

- (UILabel *)rosePriceLabel{
    if (!_rosePriceLabel){
        _rosePriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_rosePriceLabel setFont:SYS_FONT(14)];
    }
    return _rosePriceLabel;
}

- (UIButton *)followButton{
    if (!_followButton){
        _followButton = [[UIButton alloc] init];
        [_followButton.layer setCornerRadius:2];
        [_followButton.layer setBorderWidth:1];
        [_followButton.titleLabel setFont:SYS_FONT(12)];
        [_followButton.layer setBorderColor:k_666666.CGColor];
        [_followButton setClipsToBounds:YES];
        [_followButton addTarget:self action:@selector(clictButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}

- (void)setDetailCellData:(BitDetailsEntity *)entity{
    [self.titleLabel setText:entity.btc_title_display];
    [self.tradePlatformLabel setText:[NSString stringWithFormat:@"交易平台：%@",entity.btc_trade_from_name]];
    [self.tradeAmountLabel setText:[NSString stringWithFormat:@"24小时交易量：%@",entity.trading]];
    
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%.2lf",[entity.btc_price floatValue]]];
    if ([entity.rising floatValue] > 0){
        [self.priceLabel setTextColor:k_D0402D];
        [self.roseRateLabel setTextColor:k_D0402D];
        [self.rosePriceLabel setTextColor:k_D0402D];
        [self.roseRateLabel setText:[NSString stringWithFormat:@"+%.2lf%%",[entity.rising floatValue]/100.0]];
        [self.rosePriceLabel setText:[NSString stringWithFormat:@"+%@",entity.rising_val]];

    }else {
        [self.priceLabel setTextColor:k_17B03E];
        [self.roseRateLabel setTextColor:k_17B03E];
        [self.rosePriceLabel setTextColor:k_17B03E];
        [self.roseRateLabel setText:[NSString stringWithFormat:@"%.2lf%%",[entity.rising floatValue]/100.0]];
        [self.rosePriceLabel setText:[NSString stringWithFormat:@"%@",entity.rising_val]];

    }
    if (entity.is_follow){
        [self.followButton setImage:nil forState:UIControlStateNormal];
        [self.followButton setTitle:@"已关注" forState:UIControlStateNormal];
        [self.followButton setTitleColor:k_9596AB forState:UIControlStateNormal];
    }else {
       [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setImage:[UIImage imageNamed:@"details_follow_icon"] forState:UIControlStateNormal];
        [self.followButton setTitleColor:k_666666 forState:UIControlStateNormal];
    }
}


- (void)clictButton:(UIButton *)button {
    NSString *textSring = [button.titleLabel text];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(selectDetailsCell:withFollow:)]){
        BOOL isFollow = NO;
        if ([textSring isEqualToString:@"关注"]){
            isFollow = YES;
        }else {
            isFollow = NO;
        }
        [_delegate selectDetailsCell:self withFollow:isFollow];
    }

}


@end
