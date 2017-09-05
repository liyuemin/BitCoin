//
//  MSTextView.m
//  MSVideo
//
//  Created by mai on 17/8/8.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "MSTextView.h"
#import "UIView+Extension.h"
@interface MSTextView()<UITextViewDelegate>
@end

@implementation MSTextView

- (UILabel *)placeholderLable{
    if (!_placeholderLable) {
        //添加占位文字的label
        UILabel *placeholderLable = [[UILabel alloc] init];
        placeholderLable.textColor = [UIColor lightGrayColor];
        placeholderLable.font = self.font;
        placeholderLable.numberOfLines = 0;
        [self addSubview:placeholderLable];
        _placeholderLable = placeholderLable;
    }
    return _placeholderLable;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:15];
        
    }
    return self;
}


- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    //设置文字
    self.placeholderLable.text = placeholder;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    
    //设置占位文字的位置
    self.placeholderLable.x = 4;
    self.placeholderLable.centerX = self.centerX;
    
    self.placeholderLable.size = CGSizeMake(self.width - 10, self.height);
    
    //    self.placeholderLable.size = [placeholder boundingRectWithSize:CGSizeMake(self.width - 10, MAXFLOAT)
    //                                                           options:NSStringDrawingUsesLineFragmentOrigin
    //                                                        attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName ,nil]
    //                                                           context:nil].size;
}

- (void)textDidChange{
    self.placeholderLable.hidden = self.text.length;
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    
    //去调整placeholder的字体大小
    self.placeholderLable.font = font;
    
    //因为更新了字体大小，所以同时需要调整站位字符的位置
    [self setPlaceholder:self.placeholder];
}

-(void)setPlaceholderType:(MSTextViewPlaceholderType)placeholderType
{
    _placeholderType = placeholderType;
    
    switch (placeholderType) {
        case MSTextViewPlaceholderCenterType:
        {
            self.placeholderLable.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case MSTextViewPlaceholderLeftType:
        {
            self.placeholderLable.textAlignment = NSTextAlignmentLeft;
            
        }
            break;
            
            
        default:
            break;
    }
    
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
