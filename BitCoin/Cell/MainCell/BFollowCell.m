//
//  BFollowCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/23.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BFollowCell.h"
#import "UIImageView+YYWebImage.h"

@interface BFollowCell()
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *desLable;
@property (nonatomic ,strong)UILabel *moneyLabel;
@property (nonatomic ,strong)UIButton *preButton;
@property (nonatomic ,assign)NSInteger is_disPlay;
@property (nonatomic ,strong)UIImageView *iconImageView;
@property (nonatomic ,strong)UIImageView *countryImageView;
@end

@implementation BFollowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpViews];
        [self setConstraintViews];
        self.is_disPlay = 0;
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
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.countryImageView];
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
        maker.left.mas_equalTo(self.contentView).offset(30);
        maker.top.mas_equalTo(self.contentView).offset(18);
        maker.right.mas_equalTo(self.moneyLabel.mas_left).offset(-15);
        maker.height.mas_equalTo(20);
    }];
    
    [self.desLable mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(30);
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
        [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        
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
        [_preButton addTarget:self action:@selector(clictButton:) forControlEvents:UIControlEventTouchUpInside];
        [_preButton.titleLabel setFont:SYS_FONT(14)];
        
    }
    return _preButton;
}

- (UIImageView *)iconImageView{
    
    if (!_iconImageView){
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _iconImageView;
}

- (UIImageView *)countryImageView{
    
    if (!_countryImageView){
        _countryImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _countryImageView;
}

- (void)setFollowData:(BitEnity *)entity withDisPlay:(NSInteger)display withAnimation:(BOOL)animation {
    
    if (![self.moneyLabel.text isEqualToString:[NSString stringWithFormat:@"￥%.2lf",[entity.btc_price floatValue]]]){
        if (animation){
            [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                if ([entity.rising floatValue] > 0){
                    [self.contentView setBackgroundColor:k_D0402D];
                } else {
                    [self.contentView setBackgroundColor:k_17B03E];
                }
                
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:1 animations:^{
                        //self.contentView.alpha = 1.0;
                        [self.contentView setBackgroundColor:[UIColor clearColor]];
                    }];
                }
            }];
        }

    }
    
    [self.titleLabel setText:entity.btc_title_display];
    [self.desLable setText:entity.btc_trade_from_name];
    self.is_disPlay = display;
    
    if (display == 1){
        [self.preButton setTitle:[NSString stringWithFormat:@"%.2lf",[entity.rising_val floatValue]] forState:UIControlStateNormal];

    }else if (display == 2){
        [self.preButton setTitle:[NSString stringWithFormat:@"%@",entity.trading] forState:UIControlStateNormal];

    } else {
        [self.preButton setTitle:[NSString stringWithFormat:@"%.2lf%%",[entity.rising floatValue]/100.0] forState:UIControlStateNormal];
    }
    [self.moneyLabel setText:[NSString stringWithFormat:@"￥%.2lf",[entity.btc_price floatValue]]];
        if ([entity.rising floatValue] > 0){
            [self.preButton setBackgroundColor:k_D0402D];
            [self.moneyLabel setTextColor:k_D0402D];
    }else {
         [self.moneyLabel setTextColor:k_17B03E];
         [self.preButton setBackgroundColor:k_17B03E];
        
    }

    @weakify(self)
    [self.iconImageView setImageWithURL:[NSURL URLWithString:entity.imgurl] placeholder:nil options:kNilOptions completion:^(UIImage * _Nullable image,
                                    NSURL *url,
                       YYWebImageFromType from,
                          YYWebImageStage stage,
                         NSError * _Nullable error){
        @strongify(self)
        if (image){
             [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *maker){
                maker.left.mas_equalTo(self.contentView).offset(5);
                maker.centerY.mas_equalTo(self.contentView.mas_centerY);
                maker.width.height.mas_equalTo(30);
                
            }];
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *maker){
                maker.left.mas_equalTo(self.contentView).offset(40);
            }];
            [self.desLable mas_updateConstraints:^(MASConstraintMaker *maker){
                maker.left.mas_equalTo(self.contentView).offset(40);
            }];
        } else {
            
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *maker){
                maker.left.mas_equalTo(self.contentView).offset(15);
            }];
            [self.desLable mas_updateConstraints:^(MASConstraintMaker *maker){
                maker.left.mas_equalTo(self.contentView).offset(15);
            }];
        }
    }];
    [self.countryImageView setImageWithURL:[NSURL URLWithString:entity.flag_imgurl] placeholder:nil options:kNilOptions completion:^(UIImage * _Nullable image,NSURL *url,YYWebImageFromType from,YYWebImageStage stage,NSError * _Nullable error){
          @strongify(self)
        if (image){
            CGSize titleSize = [entity.btc_title_display boundingRectWithSize:CGSizeMake(ScreenWidth - 245, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:16]} context:nil].size;
            CGFloat width = 15;
            if (entity.imgurl.length != 0){
                width = 40;
                
            }
             [self.countryImageView mas_updateConstraints:^(MASConstraintMaker *maker){
                 maker.top.mas_equalTo(self.contentView).offset(19);
                 maker.left.mas_equalTo(titleSize.width + width + image.size.height/20 * image.size.width + 5);
                 maker.height.mas_equalTo(18);
                 maker.width.mas_equalTo(18/image.size.height * image.size.width);
            
        }];
        }
    }];
    
}

- (void)clictButton:(UIButton *)button {
    self.is_disPlay++;
    if (self.is_disPlay > 2){
        self.is_disPlay = 0;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didSelect:withDisPlay:)]){
        [_delegate didSelect:self withDisPlay:self.is_disPlay];
    }
}

@end
