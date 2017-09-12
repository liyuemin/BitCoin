//
//  BitUpDateView.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/11.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitUpDateView.h"
@interface BitUpDateView()
@property (nonatomic ,strong)UIImageView *imageView;
@end
@implementation BitUpDateView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        _imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_imageView setImage:[UIImage imageNamed:@"details_ ripple_cion"]];
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, frame.size.width - 8, frame.size.height)];
        [_label setTextColor:k_4689FA];
        [_label setFont:SYS_FONT(9)];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setText:@"更新价格"];
        [self addSubview:_label];
    }
    return self;
}
@end
