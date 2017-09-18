//
//  BitDetailsHeaderView.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/13.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitDetailsHeaderView.h"
#import "BitLineChartView.h"

@interface BitDetailsHeaderView()

@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *tradePlatformLabel;
@property (nonatomic ,strong)UILabel *tradeAmountLabel;
@property (nonatomic ,strong)UILabel *priceLabel;
@property (nonatomic ,strong)UILabel *roseRateLabel;
@property (nonatomic ,strong)UILabel *rosePriceLabel;
@property (nonatomic ,strong)UIButton *followButton;
@property (nonatomic ,strong)UIView *linBgView;

@property (nonatomic ,strong)BitLineChartView *lineChart;
@property (nonatomic ,strong)UISegmentedControl *segmentControl;

@end
@implementation BitDetailsHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    if (self){
        [self setUpViews];
        [self setConstraintsViews];
    }
    return self;
}

- (void)setUpViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.tradePlatformLabel];
    [self addSubview:self.tradeAmountLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.roseRateLabel];
    [self addSubview:self.rosePriceLabel];
    [self addSubview:self.followButton];
    [self addSubview:self.linBgView];
    [self.linBgView addSubview:self.segmentControl];
    [self.linBgView addSubview:self.lineChart];
}

- (void)setConstraintsViews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self).offset(18);
        maker.width.mas_equalTo(150);
        maker.height.mas_equalTo(20);
    }];
    [self.tradePlatformLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        maker.width.mas_equalTo(200);
        maker.height.mas_equalTo(20);
    }];
    
    [self.tradeAmountLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self).offset(15);
        maker.top.mas_equalTo(self.tradePlatformLabel.mas_bottom).offset(14);
        maker.width.mas_equalTo(200);
        maker.height.mas_equalTo(20);
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.top.mas_equalTo(self).offset(16);
        maker.width.mas_equalTo(60);
        maker.height.mas_equalTo(24);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        maker.width.mas_equalTo(150);
        maker.height.mas_equalTo(20);
    }];
    
    [self.roseRateLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(-15);
        maker.top.mas_equalTo(self.priceLabel.mas_bottom).offset(14);
        maker.width.mas_equalTo(80);
        maker.height.mas_equalTo(20);
    }];
    
    [self.rosePriceLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self.roseRateLabel.mas_left).offset(-15);
        maker.top.mas_equalTo(self.priceLabel.mas_bottom).offset(14);
        maker.width.mas_equalTo(80);
        maker.height.mas_equalTo(20);
    }];
    [self.linBgView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.mas_equalTo(self).offset(0);
        maker.top.mas_equalTo(self.rosePriceLabel.mas_bottom).offset(14);
        maker.left.mas_equalTo(self).offset(0);
        maker.bottom.mas_equalTo(self).offset(0);
    }];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.linBgView).offset(15);
        maker.top.mas_equalTo(self.linBgView).offset(15);
        maker.right.mas_equalTo(self.linBgView).offset(-15);
        maker.height.mas_equalTo(30);
    }];
    
    
    [self.lineChart mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.linBgView).offset(20);
        maker.top.mas_equalTo(self.linBgView).offset(55);
        maker.right.mas_equalTo(self.linBgView).offset(0);
        maker.bottom.mas_equalTo(self.linBgView).offset(0);
    }];


    
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setFont:SYS_FONT(16)];
        [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [_titleLabel setTextColor:k_3C3C3C];
    }
    return _titleLabel;
}

- (UILabel *)tradePlatformLabel{
    if (!_tradePlatformLabel){
        _tradePlatformLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_tradePlatformLabel setTextColor:k_9596AB];
        [_tradePlatformLabel setFont:SYS_FONT(12)];
    }
    return _tradePlatformLabel;
}

- (UILabel *)tradeAmountLabel{
    if (!_tradeAmountLabel){
        _tradeAmountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_tradeAmountLabel setTextColor:k_9596AB];
        [_tradeAmountLabel setFont:SYS_FONT(12)];
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
        [_roseRateLabel setFont:SYS_FONT(12)];
        [_roseRateLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _roseRateLabel;
}

- (UILabel *)rosePriceLabel{
    if (!_rosePriceLabel){
        _rosePriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_rosePriceLabel setFont:SYS_FONT(12)];
        [_rosePriceLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _rosePriceLabel;
}

- (UIButton *)followButton{
    if (!_followButton){
        _followButton = [[UIButton alloc] init];
        [_followButton.layer setCornerRadius:2];
        [_followButton.titleLabel setFont:SYS_FONT(12)];
        [_followButton setClipsToBounds:YES];
        [_followButton addTarget:self action:@selector(clictButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}

- (UIView *)linBgView{
    if (!_linBgView){
        _linBgView = [[UIView alloc] initWithFrame:CGRectZero];
        [_linBgView setBackgroundColor:k_111D37];
    }
    return _linBgView;
}

- (BitLineChartView *)lineChart {
    if (!_lineChart){
        _lineChart = [[BitLineChartView alloc] initWithFrame:CGRectZero];
        [self.lineChart setVerticalCount:5];
        [self.lineChart setHorizontalCount:5];
        [self.lineChart setLineColor:k_4689FA];
        [self.lineChart setLineXYColor:k_3A4455];
        [self.lineChart setVerticalTextColor:k_3A4455];
        [self.lineChart setHorizontalTextColor:k_3A4455];
    }
    return _lineChart;
}

- (UISegmentedControl *)segmentControl{
    if (!_segmentControl){
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"分时",@"6小时",@"日线",@"月线"]];
        [_segmentControl setSelectedSegmentIndex:0];
        [_segmentControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
        [_segmentControl setTintColor:k_FFFFFF];
        
    }
    return _segmentControl;
}

- (void)didClicksegmentedControlAction:(UISegmentedControl *)segment{
    NSString *sring = nil;
    switch (segment.selectedSegmentIndex) {
        case 0:
            sring = [NSString stringWithFormat:@"minute"];
            break;
        case 1:
            sring = [NSString stringWithFormat:@"hour"];
            break;
            
        case 2:
            sring = [NSString stringWithFormat:@"day"];
            break;
            
        case 3:
            sring = [NSString stringWithFormat:@"month"];
            break;
            
            
        default:
            break;
    }
    [self.lineChart clearChartData];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(selectSegmentIndex:withKey:)]){
        [_delegate selectSegmentIndex:segment.selectedSegmentIndex withKey:sring];
    }
    
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
        [self.rosePriceLabel setText:[NSString stringWithFormat:@"+%.2f",[entity.rising_val floatValue]]];
        
    }else {
        [self.priceLabel setTextColor:k_17B03E];
        [self.roseRateLabel setTextColor:k_17B03E];
        [self.rosePriceLabel setTextColor:k_17B03E];
        [self.roseRateLabel setText:[NSString stringWithFormat:@"%.2lf%%",[entity.rising floatValue]/100.0]];
        [self.rosePriceLabel setText:[NSString stringWithFormat:@"%.2f",[entity.rising_val floatValue]]];
        
    }
    if (entity.is_follow){
        [self.followButton setImage:nil forState:UIControlStateNormal];
        [self.followButton setTitle:@"已关注" forState:UIControlStateNormal];
        [self.followButton setTitleColor:k_9596AB forState:UIControlStateNormal];
        [self.followButton setBackgroundColor:k_EFEFF4];
        [self.followButton.layer setBorderColor:[UIColor clearColor].CGColor];
        [self.followButton.layer setBorderWidth:0];
        
        
    }else {
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setImage:[UIImage imageNamed:@"details_follow_icon"] forState:UIControlStateNormal];
        [self.followButton setTitleColor:k_4471BC forState:UIControlStateNormal];
        [self.followButton setBackgroundColor:[UIColor whiteColor]];
        [self.followButton.layer setBorderColor:k_4471BC.CGColor];
        [self.followButton.layer setBorderWidth:1];
        
        
    }
}

- (void)setBitLineData:(NSArray *)array withKey:(NSString *)key {
    if(array && array.count > 0){
        if ([key isEqualToString:@"minute"]){
            [self.lineChart setTimeType:BitLineTimeTypeMinutes];
        }else if ([key isEqualToString:@"hour"]){
            [self.lineChart setTimeType:BitLineTimeTypeHours];
        }else if ([key isEqualToString:@"day"]){
            [self.lineChart setTimeType:BitLineTimeTypeDays];
        }else if ([key isEqualToString:@"month"]){
            [self.lineChart setTimeType:BitLineTimeTypeMonth];
        }
        [self.lineChart setLineData:array];
        //[self.lineChart setDataArray:array withLaster:entity];
    }
}

- (void)setBitLineLasterPrice:(BitDetailsPriceEntity *)entity {
    [self.lineChart setLasterPrice:entity];
}



- (void)clictButton:(UIButton *)button {
    NSString *textSring = [button.titleLabel text];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(selectDetailsHeader:withFollow:)]){
        BOOL isFollow = NO;
        if ([textSring isEqualToString:@"关注"]){
            isFollow = YES;
        }else {
            isFollow = NO;
        }
        [_delegate selectDetailsHeader:self withFollow:isFollow];
    }
    
}

@end
