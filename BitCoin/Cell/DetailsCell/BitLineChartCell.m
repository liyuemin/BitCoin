//
//  BitLineChartCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitLineChartCell.h"
#import "BitLineChartView.h"

@interface BitLineChartCell()
@property (nonatomic ,strong)BitLineChartView *lineChart;
@property (nonatomic ,strong)UISegmentedControl *segmentControl;
@end
@implementation BitLineChartCell
@synthesize delegate = _delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self.contentView setBackgroundColor:k_111D37];
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
    [self.contentView addSubview:self.lineChart];
    [self.contentView addSubview:self.segmentControl];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.contentView).offset(15);
        maker.right.mas_equalTo(self.contentView).offset(-15);
        maker.height.mas_equalTo(30);
    }];

    
    [self.lineChart mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(0);
        maker.top.mas_equalTo(self.contentView).offset(60);
        maker.right.mas_equalTo(self.contentView).offset(0);
        maker.bottom.mas_equalTo(self.contentView).offset(0);
    }];
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
        [self.lineChart setDataArray:array];
    }
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

- (BitLineChartView *)lineChart {
    if (!_lineChart){
        _lineChart = [[BitLineChartView alloc] initWithFrame:CGRectZero];
        [self.lineChart setVerticalCount:5];
        [self.lineChart setHorizontalCount:8];
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

@end
