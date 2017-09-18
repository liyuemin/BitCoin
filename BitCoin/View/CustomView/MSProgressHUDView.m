//
//  MSProgressHUDView.m
//  MSVideo
//
//  Created by mai on 17/7/11.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "MSProgressHUDView.h"
#import "UIImage+GIF.h"
#import "Masonry.h"
@interface MSProgressHUDView()

@property (nonatomic, strong) UIImageView *loadingImageView;

@end

@implementation MSProgressHUDView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - Public methods

- (void)show:(BOOL)animated
{
    NSLog(@"%s",__func__);
    [self.superview bringSubviewToFront:self];
    if (animated)
    {
        self.alpha = 0.0f;
        self.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1.0f;
        } completion:^(BOOL finished) {
        }];
    }
    else
    {
        self.alpha = 1.0f;
        self.hidden = NO;
    }
}

- (void)hide:(BOOL)animated
{
    NSLog(@"%s",__func__);
    if (animated)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
    else
    {
        self.alpha = 0.0f;
        self.hidden = YES;
    }
}

- (void)hideDelayed:(NSNumber *)animated
{
    [self hide:[animated boolValue]];
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay
{
    if (delay>0)
    {
        [self performSelector:@selector(hideDelayed:) withObject:[NSNumber numberWithBool:animated] afterDelay:delay];
    }
    else
    {
        [self hide:animated];
    }
}

#pragma mark - Private methods

- (void)setUpView
{
    [self addSubview:self.loadingImageView];
    
    [self.loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-40);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"bitcion" ofType:@"gif"];
//    UIImage *loadingImage = [UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfFile:path]];
    UIImage *loadingImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"bitcion.gif"]];
    

    self.loadingImageView.image = loadingImage;
}

#pragma mark - GIF

-(UIImageView *)loadingImageView
{
    if (!_loadingImageView)
    {
        _loadingImageView = [[UIImageView alloc] init];
        _loadingImageView.backgroundColor = k_EFEFF4;
    }
    return _loadingImageView;
}



@end
