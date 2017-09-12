//
//  BitDetailsWebCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitDetailsWebCell.h"
#import "NSString+AFNetWorkAdditions.h"
@interface BitDetailsWebCell()
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *webLabel;

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
        maker.width.mas_equalTo(ScreenWidth - 250);
        maker.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
}

- (void)upConstraintsView:(CGSize)size{
    [self.webLabel mas_updateConstraints:^(MASConstraintMaker *maker){
        maker.width.mas_equalTo(size.width + 20);
    }];
}


- (void)setWebCellData:(BitPlatformEntity *)entity {
    
    [self upConstraintsView:[entity.v boundingRectWithSize:CGSizeMake(ScreenWidth - 250, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size];
    [self.titleLabel setText:entity.k];
    if ([entity.v isValidUrl]){
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:entity.v];
        NSRange contentRange = {0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        [self.webLabel setAttributedText:content];

    }else {
      [self.webLabel setText:entity.v];
    }

}

-(UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setTextColor:k_999999];
        [_titleLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setFont:SYS_FONT(14)];
    }
    return _titleLabel;
}

- (UILabel *)webLabel{
    if (!_webLabel){
        _webLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_webLabel setFont:SYS_FONT(14)];
        [_webLabel setNumberOfLines:0];
        [_webLabel setTextAlignment:NSTextAlignmentLeft];
        [_webLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_webLabel setTextColor:k_4471BC];
    }
    return _webLabel;
}

@end
