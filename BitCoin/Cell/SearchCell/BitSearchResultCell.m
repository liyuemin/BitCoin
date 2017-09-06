//
//  BitSearchResultCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/31.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitSearchResultCell.h"

@interface BitSearchResultCell()
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *desLabel;
@property (nonatomic ,strong)UIButton *addButton;
@property (nonatomic ,strong)BitSearchResultEntity *resultEntity;
@end

@implementation BitSearchResultCell
@synthesize delegate;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpViews];
        [self setViewConstraints];
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
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setFont:SYS_FONT(16)];
    [self.contentView addSubview:_titleLabel];
    
    _desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_desLabel setFont:SYS_FONT(12)];
    [_desLabel setTextColor:k_9596AB];
    [self.contentView addSubview:_desLabel];
    
    _addButton = [[UIButton alloc] init];
    [_addButton.layer setCornerRadius:2];
    [_addButton.layer setBorderWidth:1];
    [_addButton.layer setBorderColor:k_D1D6E0.CGColor];
    [_addButton addTarget:self action:@selector(addfollow:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addButton];
}

- (void)setViewConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.contentView).offset(10);
        maker.width.mas_equalTo(150);
        maker.height.mas_equalTo(20);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        maker.width.mas_equalTo(150);
        maker.height.mas_equalTo(15);
    }];

    [self.addButton mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self.contentView).offset(-15);
        maker.centerY.mas_equalTo(self.contentView.mas_centerY);
        maker.width.mas_equalTo(60);
        maker.height.mas_equalTo(30);
    }];

}

- (void)setCellData:(BitSearchResultEntity *)entity withkey:(NSString *)key{
    self.resultEntity = entity;
    [self.titleLabel setText:entity.btc_title_display];
    NSLog(@"%@",self.titleLabel.text);
    NSLog(@"--%@",key);
    NSRange textRange = [self.titleLabel.text rangeOfString:key];
    if (textRange.location != NSNotFound){
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:entity.btc_title_display];
        [str addAttribute:NSForegroundColorAttributeName value:k_5080D8 range:textRange];
        [str addAttribute:NSForegroundColorAttributeName value:k_636363 range:NSMakeRange(0, textRange.location)];
        [str addAttribute:NSForegroundColorAttributeName value:k_636363 range:NSMakeRange(textRange.length, entity.btc_title_display.length - textRange.length - textRange.location)];
        [self.titleLabel setAttributedText:str];
    }
    [self.desLabel setText:entity.btc_trade_from_name];
    if (entity.is_follow){
        [self.addButton setImage:[UIImage imageNamed:@"search_follow_icon"] forState:UIControlStateNormal];
        [self.addButton setEnabled:NO];

    }else {
        [self.addButton setImage:[UIImage imageNamed:@"search_addfollow_icon"] forState:UIControlStateNormal];
        [self.addButton setEnabled:YES];
    }
}

- (void)addfollow:(id)sender{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(addFollowWithEntity:)]){
        [self.delegate addFollowWithEntity:self.resultEntity];
    }
}

@end
