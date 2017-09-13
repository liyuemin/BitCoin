//
//  BitDetailsTextCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitDetailsTextCell.h"
#import "ZHGridView.h"

@interface BitDetailsTextCell()
@property (nonatomic ,strong)UIView *lineView;
@property (nonatomic ,strong)ZHGridView *gridView;

@end

@implementation BitDetailsTextCell

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
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.gridView];
    [self.contentView addSubview:self.destailLabe];
    
}
- (void)setConstraintsViews{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.contentView).offset(15);
        maker.width.mas_equalTo(3);
        maker.height.mas_equalTo(16);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.lineView).offset(5);
        maker.top.mas_equalTo(self.contentView).offset(15);
        maker.height.mas_equalTo(16);
        maker.right.mas_equalTo(self.contentView).offset(-10);
    }];
    
    [self.gridView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(0);
        maker.top.mas_equalTo(self.contentView).offset(40);
        maker.height.mas_equalTo(1);
        maker.right.mas_equalTo(self.contentView).offset(0);
    }];
    
    [self.destailLabe mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.contentView).offset(45);
        maker.bottom.mas_equalTo(-15);
        maker.right.mas_equalTo(self.contentView).offset(-15);
    }];

}
-(UIView *)lineView{
    if (!_lineView){
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        [_lineView setBackgroundColor:k_4471BC];
        [_destailLabe setFont:SYS_FONT(16)];
    }
    return _lineView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _titleLabel;
}

- (UILabel *)destailLabe{
    if (!_destailLabe){
        _destailLabe  = [[UILabel alloc] initWithFrame:CGRectZero];
        [_destailLabe setTextColor:k_999999];
        [_destailLabe setNumberOfLines:0];
        [_destailLabe setFont:SYS_FONT(14)];
    }
    return _destailLabe;
}

- (ZHGridView *)gridView{
    if (!_gridView){
        _gridView =  [[ZHGridView alloc] initWithFrame:CGRectZero];
        [_gridView setGridViewType:ZHGridViewTypeHor];
        [_gridView setGridColor:k_EFEFF4];
        [_gridView setGridLineWidth:1];
    }
    return _gridView;
}

@end
