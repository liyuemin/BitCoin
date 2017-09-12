//
//  BitHomeHeaderView.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitHomeHeaderView.h"
@interface BitHomeHeaderView()
@property (nonatomic ,strong)UIView *lineView;
@end

@implementation BitHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setUpView];
        [self setConstraintsViews];
    }
    return self;
}

- (void)setUpView{
    [self addSubview:self.lineView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.roseLabel];
}

- (void)setConstraintsViews{
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(0);
        maker.top.mas_equalTo(self).offset(0);
        maker.left.mas_equalTo(self).offset(0);
        maker.height.mas_equalTo(5);
    }];

    [self.roseLabel mas_updateConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.top.mas_equalTo(self).offset(5);
        maker.bottom.mas_equalTo(self).offset(0);
        maker.width.mas_equalTo(80);
    }];
    

    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self).offset(5);
        maker.bottom.mas_equalTo(self).offset(0);
        maker.width.mas_equalTo(100);
    }];
    [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(self).offset(5);
        maker.right.mas_equalTo(self.roseLabel.mas_left).offset(-20);
        maker.bottom.mas_equalTo(self).offset(0);
        maker.width.mas_equalTo(100);
    }];

}
-(UIView *)lineView{
    if (!_lineView){
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        [_lineView setBackgroundColor:k_EFEFF4];
    }
    return _lineView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setTextColor:k_9596AB];
        [_titleLabel setFont:SYS_FONT(12)];
    }
    return _titleLabel;
}
- (UILabel *)priceLabel{
    if (!_priceLabel){
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_priceLabel setTextColor:k_9596AB];
        [_priceLabel setTextAlignment:NSTextAlignmentRight];
        [_priceLabel setFont:SYS_FONT(12)];
    }
    return _priceLabel;
}

- (UILabel *)roseLabel{
    if (!_roseLabel){
        _roseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_roseLabel setTextColor:k_9596AB];
        [_roseLabel setTextAlignment:NSTextAlignmentRight];
        [_roseLabel setFont:SYS_FONT(12)];
    }
    return _roseLabel;
}


@end
