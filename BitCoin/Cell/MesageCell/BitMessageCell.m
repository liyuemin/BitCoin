//
//  BitMessageCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitMessageCell.h"

@interface BitMessageCell()

@property (nonatomic ,strong)UILabel *titleLable;
@property (nonatomic ,strong)UILabel *desLabel;
@end

@implementation BitMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpViews];
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
    _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLable setTextColor:k_3C3C3C];
    [_titleLable setNumberOfLines:0];
    [_titleLable setFont:SYS_FONT(14)];
    [self.contentView addSubview:_titleLable];
    
    _desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_desLabel setTextColor:k_9596AB];
    [_desLabel setFont:SYS_FONT(12)];
    [self.contentView addSubview:_desLabel];
}

- (void)setContronsView:(CGSize)size{
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(self.contentView).offset(10);
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.right.mas_equalTo(self.contentView).offset(-15);
        maker.height.mas_equalTo(size.height);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(self.titleLable.mas_bottom).offset(10);
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.right.mas_equalTo(self.contentView).offset(-15);
        maker.height.mas_equalTo(20);

    }];
}



- (void)setMessageCellData:(BitMessageEntity *)entity {
    CGSize titleSize = [entity.content boundingRectWithSize:CGSizeMake(ScreenWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    [self setContronsView:titleSize];
    [self.titleLable setText:entity.content];
    [self.desLabel setText:entity.create_time];

}

@end
