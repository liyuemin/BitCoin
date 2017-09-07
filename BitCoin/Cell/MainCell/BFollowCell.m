//
//  BFollowCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/23.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BFollowCell.h"
@interface BFollowCell()
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *desLable;
@property (nonatomic ,strong)UILabel *moneyLabel;
@property (nonatomic ,strong)UIButton *preButton;
@end

@implementation BFollowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpViews];
        [self setConstraintViews];
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

- (void)setUpViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.desLable];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.preButton];
}

- (void)setConstraintViews{
    
    [self.preButton mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self.contentView).offset(-15);
        maker.centerY.mas_equalTo(self.contentView.mas_centerY);
        maker.width.mas_equalTo(80);
        maker.height.mas_equalTo(32);
    }];

    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self.preButton.mas_left).offset(-20);
        maker.centerY.mas_equalTo(self.contentView.mas_centerY);
        maker.width.mas_equalTo(100);
        maker.height.mas_equalTo(20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.contentView).offset(18);
        maker.right.mas_equalTo(self.moneyLabel.mas_left).offset(-15);
        maker.height.mas_equalTo(20);
    }];
    
    [self.desLable mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.titleLabel.mas_bottom).offset(6);
        maker.right.mas_equalTo(self.moneyLabel.mas_left).offset(-15);
        maker.height.mas_equalTo(20);

    }];


   
}

//- (void)upConstraintViews {
//    [self.titleLabel sizeToFit];
//    [self.desLable sizeToFit];
//    [self.titleLabel setFrame:CGRectMake(15, 18, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
//    [self.desLable setCenter:CGPointMake(self.titleLabel.center.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 8)];
//}

- (UILabel *)titleLabel {
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:k_3C3C3C];
        [_titleLabel setFont:SYS_FONT(16)];
        
    }
    return _titleLabel;
}

- (UILabel *)desLable{
    if (!_desLable){
        _desLable = [[UILabel alloc] init];
        [_desLable setTextColor:k_9596AB];
        [_desLable setTextAlignment:NSTextAlignmentLeft];
        [_desLable setFont:SYS_FONT(12)];
        
    }
    return _desLable;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel){
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_moneyLabel setTextAlignment:NSTextAlignmentRight];
        [_moneyLabel setTextColor:k_D0402D];
        [_moneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    }
    return _moneyLabel;
}
-(UIButton *)preButton {
    if (!_preButton){
        _preButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_preButton.layer setCornerRadius:2];
        [_preButton setTitleColor:k_FAFAFA forState:UIControlStateNormal];
        [_preButton setClipsToBounds:YES];
        [_preButton.titleLabel setFont:SYS_FONT(14)];
        
    }
    return _preButton;
}

- (void)setFollowData:(BitEnity *)entity {
    [self.titleLabel setText:entity.btc_title_display];
    [self.desLable setText:entity.btc_trade_from_name];
    //[self upConstraintViews];
    [self.moneyLabel setText:[NSString stringWithFormat:@"￥%.2lf",[entity.btc_price floatValue]]];
    [self.preButton setTitle:[NSString stringWithFormat:@"%.2lf%%",[entity.rising floatValue]/100.0] forState:UIControlStateNormal];
    if ([entity.rising floatValue] > 0){
        [self.preButton setBackgroundColor:k_D0402D];
        [self.moneyLabel setTextColor:k_D0402D];
    }else {
        [self.preButton setBackgroundColor:k_17B03E];
        [self.moneyLabel setTextColor:k_17B03E];
    }

}

- (void)setDetailCellData:(BitDetailsEntity *)entity{
    [self.titleLabel setText:entity.btc_title_display];
    [self.desLable setText:entity.btc_trade_from_name];
    //[self upConstraintViews];
    [self.moneyLabel setText:[NSString stringWithFormat:@"￥%.2lf",[entity.btc_price floatValue]]];
    [self.preButton setTitle:[NSString stringWithFormat:@"%.2lf%%",[entity.rising floatValue]/100.0] forState:UIControlStateNormal];
    if ([entity.rising floatValue] > 0){
        [self.preButton setBackgroundColor:k_D0402D];
        [self.moneyLabel setTextColor:k_D0402D];
    }else {
        [self.preButton setBackgroundColor:k_17B03E];
         [self.moneyLabel setTextColor:k_17B03E];
    }

}

@end
