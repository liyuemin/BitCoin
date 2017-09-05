//
//  BitDetailsWebCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitDetailsWebCell.h"
@interface BitDetailsWebCell()
@end
@implementation BitDetailsWebCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpViews];
        [self setConstraintsView];
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
    [self.contentView addSubview:self.webLabel];
}

- (void)setConstraintsView{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.contentView).offset(10);
        maker.width.mas_equalTo(200);
        maker.bottom.mas_equalTo(self.contentView).offset(-10);
        
    }];
    [self.webLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self.contentView).offset(-15);
        maker.top.mas_equalTo(self.contentView).offset(10);
        maker.width.mas_equalTo(200);
        maker.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
}

-(UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setTextColor:k_999999];
        [_titleLabel setFont:SYS_FONT(14)];
    }
    return _titleLabel;
}

- (UILabel *)webLabel{
    if (!_webLabel){
        _webLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_webLabel setFont:SYS_FONT(14)];
        [_webLabel setTextAlignment:NSTextAlignmentRight];
        [_webLabel setTextColor:k_4471BC];
    }
    return _webLabel;
}

@end
