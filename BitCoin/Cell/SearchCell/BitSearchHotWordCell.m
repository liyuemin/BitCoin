//
//  BitSearchHotWordCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/31.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitSearchHotWordCell.h"

#define BitSearchHotButtonTag 100

@interface BitSearchHotWordCell()

@property (nonatomic ,strong)UIButton *oneButton;
@property (nonatomic ,strong)UIButton *twoButton;
@property (nonatomic ,strong)UIButton *threeButton;
@property (nonatomic ,strong)UIButton *fourButton;
@property (nonatomic ,strong)NSArray *dataArray;
@end

@implementation BitSearchHotWordCell
@synthesize delegate = _delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpViews];
        [self setConstraint];
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
    _oneButton = [[UIButton alloc] init];
    [_oneButton setTitleColor:k_636363 forState:UIControlStateNormal];
    [_oneButton.layer setCornerRadius:2];
    [_oneButton.titleLabel setFont:SYS_FONT(12)];
    [_oneButton setTag:BitSearchHotButtonTag];
    [_oneButton setClipsToBounds:YES];
    [_oneButton addTarget:self action:@selector(clictButton:) forControlEvents:UIControlEventTouchUpInside];
    [_oneButton setBackgroundColor:k_F4F5F9];
    [self.contentView addSubview:_oneButton];
    
    _twoButton = [[UIButton alloc] init];
    [_twoButton setTitleColor:k_636363 forState:UIControlStateNormal];
    [_twoButton.layer setCornerRadius:2];
    [_twoButton.titleLabel setFont:SYS_FONT(12)];
    [_twoButton setClipsToBounds:YES];
    [_twoButton setTag:BitSearchHotButtonTag+1];
    [_twoButton addTarget:self action:@selector(clictButton:) forControlEvents:UIControlEventTouchUpInside];
    [_twoButton setBackgroundColor:k_F4F5F9];
    [self.contentView addSubview:_twoButton];
    
    _threeButton = [[UIButton alloc] init];
    [_threeButton setTitleColor:k_636363 forState:UIControlStateNormal];
    [_threeButton.layer setCornerRadius:2];
    [_threeButton setClipsToBounds:YES];
    [_threeButton.titleLabel setFont:SYS_FONT(12)];
    [_threeButton setTag:BitSearchHotButtonTag+2];
    [_threeButton addTarget:self action:@selector(clictButton:) forControlEvents:UIControlEventTouchUpInside];
    [_threeButton setBackgroundColor:k_F4F5F9];
    [self.contentView addSubview:_threeButton];
    
    _fourButton = [[UIButton alloc] init];
    [_fourButton setTitleColor:k_636363 forState:UIControlStateNormal];
    [_fourButton.layer setCornerRadius:2];
    [_fourButton setClipsToBounds:YES];
    [_fourButton.titleLabel setFont:SYS_FONT(12)];
    [_fourButton addTarget:self action:@selector(clictButton:) forControlEvents:UIControlEventTouchUpInside];
    [_fourButton setTag:BitSearchHotButtonTag+3];
    [_fourButton setBackgroundColor:k_F4F5F9];
    [self.contentView addSubview:_fourButton];
}

- (void)setConstraint{
    CGFloat buttonWidth = (ScreenWidth - 30 - 60) / 4.0;
    [self.oneButton mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(15);
        maker.top.mas_equalTo(self.contentView).offset(5);
        maker.width.mas_equalTo(buttonWidth);
        maker.bottom.mas_equalTo(self.contentView).offset(-5);
    }];
    [self.twoButton mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.oneButton.mas_right).offset(20);
        maker.top.mas_equalTo(self.contentView).offset(5);
        maker.width.mas_equalTo(buttonWidth);
        maker.bottom.mas_equalTo(self.contentView).offset(-5);

    }];
    [self.threeButton mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.twoButton.mas_right).offset(20);
        maker.top.mas_equalTo(self.contentView).offset(5);
        maker.width.mas_equalTo(buttonWidth);
        maker.bottom.mas_equalTo(self.contentView).offset(-5);

    }];
    [self.fourButton mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.threeButton.mas_right).offset(20);
        maker.top.mas_equalTo(self.contentView).offset(5);
        maker.width.mas_equalTo(buttonWidth);
        maker.bottom.mas_equalTo(self.contentView).offset(-5);

    }];
}

- (void)setCellData:(NSArray *)data {
    self.dataArray = data;
    if (data.count > 3){
        [self.oneButton setTitle:[(BitSearchHotEntity *)[data objectAtIndex:0] title] forState:UIControlStateNormal];
        [self.twoButton setTitle:[(BitSearchHotEntity *)[data objectAtIndex:1] title] forState:UIControlStateNormal];
        [self.threeButton setTitle:[(BitSearchHotEntity *)[data objectAtIndex:2] title] forState:UIControlStateNormal];
        [self.fourButton setTitle:[(BitSearchHotEntity *)[data objectAtIndex:3] title] forState:UIControlStateNormal];
        [self.oneButton setHidden:NO];
        [self.twoButton setHidden:NO];
        [self.threeButton setHidden:NO];
        [self.fourButton setHidden:NO];
        
    }else if (data.count > 2){
        [self.oneButton setHidden:NO];
        [self.twoButton setHidden:NO];
        [self.threeButton setHidden:NO];
        [self.oneButton setTitle:[(BitSearchHotEntity *)[data objectAtIndex:0] title] forState:UIControlStateNormal];
        [self.twoButton setTitle:[(BitSearchHotEntity *)[data objectAtIndex:1] title] forState:UIControlStateNormal];
        [self.threeButton setTitle:[(BitSearchHotEntity *)[data objectAtIndex:2] title] forState:UIControlStateNormal];
        [self.fourButton setHidden:YES];
    
    }else if (data.count > 1){
        [self.oneButton setHidden:NO];
        [self.twoButton setHidden:NO];
        [self.oneButton setTitle:[(BitSearchHotEntity *)[data objectAtIndex:0] title] forState:UIControlStateNormal];
        [self.twoButton setTitle:[(BitSearchHotEntity *)[data objectAtIndex:1] title] forState:UIControlStateNormal];
        [self.threeButton setHidden:YES];
        [self.fourButton setHidden:YES];
    
    }else {
        [self.oneButton setHidden:NO];
        [self.oneButton setTitle:[(BitSearchHotEntity *)[data objectAtIndex:0] title] forState:UIControlStateNormal];
        [self.twoButton setHidden:YES];
        [self.threeButton setHidden:YES];
        [self.fourButton setHidden:YES];
    
    }

}

- (void)clictButton:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (!button.hidden){
        if (_delegate != nil && [_delegate respondsToSelector:@selector(selectBitItem:)]){
            [_delegate selectBitItem:[self.dataArray objectAtIndex:button.tag - BitSearchHotButtonTag]];
        }
    }
}

@end
