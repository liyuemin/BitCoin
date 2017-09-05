//
//  MSAlertToast.m
//  MSVideo
//
//  Created by mai on 17/7/28.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "MSAlertToast.h"
#import "UIColor+more.h"
#define kToastViewHeight  60    //toast高度

#define kToastLabelY 24         //toast文字纵坐标

#define kToastLabelHeight 13    //toast文字高度

#define kToastLabelLeftMargin 33//toast文字左边距

@interface MSAlertToast ()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIView *textBgView;

@end

@implementation MSAlertToast

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    NSLog(@"%s",__func__);
    [self.textLabel removeFromSuperview];
    self.textLabel = nil;
    [self.textBgView removeFromSuperview];
    self.textBgView = nil;
}


- (void)setShowText:(NSString *)tmpText
{
    CGSize maxSize = CGSizeMake(self.bounds.size.width, 60);
    
    CGSize textSize = MB_MULTILINE_TEXTSIZE(tmpText, [UIFont systemFontOfSize:13], maxSize, NSLineBreakByWordWrapping);
    
    [self calculateBgBlackView:textSize];
    
    self.textLabel.text = tmpText;
    
    if (![self viewWithTag:102])
    {
        [self addSubview:self.textLabel];
    }
    
}

- (void)showInView:(UIView *)tmpSuperView WithHidden:(BOOL)tmpHidden withCancelOtherBool:(BOOL)cancelBool
{
    BOOL existBool = NO;
    
    for (UIView * v in tmpSuperView.subviews)
    {
        if ([v isKindOfClass:[MSAlertToast class]])
        {
            if (v == self)
            {
                existBool = YES;
            }
            else
            {
                if (cancelBool)
                {
                    [v removeFromSuperview];
                }
            }
        }
    }
    
    self.alpha = 0;
    
    if (!existBool)
    {
        [tmpSuperView addSubview:self];
    }
    else
    {
        [tmpSuperView bringSubviewToFront:self];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    [self hideWithBool:tmpHidden];
}

- (void)setMyOrigin:(float)tmpOrigin
{
    CGRect myFrame = self.frame;
    
    myFrame.origin.y = tmpOrigin;
    
    self.frame = myFrame;
}

#pragma mark - Private Method

- (void)hideWithBool:(BOOL)tmpHidden
{
    if (tmpHidden)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideMyView) object:nil];
        
        [self performSelector:@selector(hideMyView) withObject:nil afterDelay:2 inModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    }
}

- (void)hideMyView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)calculateBgBlackView:(CGSize)textSize
{
    CGRect textBgFrame = self.textBgView.frame;
    
    textBgFrame.size.width = textSize.width + kToastLabelLeftMargin * 2;
    
    self.textBgView.frame = textBgFrame;
    
    self.textBgView.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    
    if (![self viewWithTag:101])
    {
        [self addSubview:self.textBgView];
    }
}

- (void)hidden
{
    [self hideMyView];
}

#pragma mark - LazyLoad

- (UILabel *)textLabel
{
    if (!_textLabel)
    {
        CGRect labelRect = self.bounds;
        
        labelRect.origin.y = kToastLabelY;
        
        labelRect.size.height = kToastLabelHeight;
        
        _textLabel = [[UILabel alloc]initWithFrame:labelRect];
        
        _textLabel.backgroundColor = [UIColor clearColor];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
        _textLabel.textColor = [UIColor whiteColor];
        
        _textLabel.font = SYS_FONT(13);
        
        _textLabel.tag = 102;
    }
    
    return _textLabel;
}

- (UIView *)textBgView
{
    if (!_textBgView)
    {
        _textBgView = [[UIView alloc]initWithFrame:self.bounds];
        
        _textBgView.backgroundColor = [UIColor color16WithHexString:@"#222222" alpha:0.9];
        
        _textBgView.layer.cornerRadius = 10;
        
        _textBgView.tag = 101;
    }
    
    return _textBgView;
}


@end
