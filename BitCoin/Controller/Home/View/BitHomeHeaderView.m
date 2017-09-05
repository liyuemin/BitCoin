//
//  BitHomeHeaderView.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitHomeHeaderView.h"
@interface BitHomeHeaderView()
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
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.roseLabel];
}

- (void)setConstraintsViews{
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self).offset(10);
        maker.top.mas_equalTo(self).offset(5);
        maker.bottom.mas_equalTo(self).offset(-5);
        maker.width.mas_equalTo(100);
    }];
    [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(self).offset(5);
        maker.centerX.mas_equalTo(self.mas_centerX);
        maker.bottom.mas_equalTo(self).offset(-5);
        maker.width.mas_equalTo(100);
    }];
    [self.roseLabel mas_updateConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-10);
        maker.top.mas_equalTo(self).offset(5);
        maker.bottom.mas_equalTo(self).offset(-5);
        maker.width.mas_equalTo(100);
    }];


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
        [_priceLabel setTextAlignment:NSTextAlignmentCenter];
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
