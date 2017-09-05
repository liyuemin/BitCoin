//
//  UIButton+More.m
//  TRAiDuoBao
//
//  Created by liyuemin on 16/7/27.
//  Copyright © 2016年 李沛然. All rights reserved.
//

#import "UIButton+More.h"

@implementation UIButton (More)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    
    
    [self setImage:image forState:stateType];
   
    [self setTitle:title forState:stateType];
    
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0,
                                              0.0,
                                              0.0,
                                              0.0)];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0,
                                              10.0,
                                              0.0,
                                              0.0)];
}

- (void)setImage:(UIImage *)image withTitle:(NSString *)title withContentStyle:(ButtonContentStyle)style forState:(UIControlState)stateType {

    
    [self.imageView setContentMode:UIViewContentModeCenter];
    

    [self setImage:image forState:stateType];
    //[self.titleLabel setBackgroundColor:[UIColor yellowColor]];
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    //[self.titleLabel setBackgroundColor:[UIColor clearColor]];
    //[self.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
   // [self.titleLabel setTextColor:[UIColor blackColor]];

    [self setTitle:title forState:stateType];
    [self setImageStyle:style.imageMode];
    [self setTitleStyle:style.textMode];
}

- (void)setImageStyle:(ButtonImageViewContentMode)type {
    
    
    CGSize imageSize = self.imageView.image.size;
    
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    
    if (type == ButtonImageViewContentModeRight){
        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0,
                                                  self.frame.size.width -imageSize.width ,
                                                  0.0,
                                                  0.0)];
    } else if (type == ButtonImageViewContentModeTopCenter){
        [self setImageEdgeInsets:UIEdgeInsetsMake(-titleSize.height - 10,
                                                  0.0,
                                                  0.0,
                                                  -titleSize.width)];
    } else if (type == ButtonImageViewContentModeLeft){
        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0,
                                                  0.0,
                                                  0.0,
                                                  self.frame.size.width - imageSize.width-10)];

    }
    
}

- (void)setTitleStyle:(ButtonTextContentMode)type {
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize imageSize = self.imageView.image.size;
    
    if (type == ButtonTextContentModeLeft){
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0,
                                                  0.0,
                                                  0.0,
                                                  self.frame.size.width - titleSize.width - self.imageView.image.size.width)];
    } else if (type == ButtonTextContentModeBottomCenter){
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height,
                                                  -imageSize.width,
                                                  0.0,
                                                  0.0)];
    }
}

- (void)verticalImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName :self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width-20, - (totalHeight - titleSize.height), -20);
}

- (void)setHorizontalImageAndTitle:(CGFloat)spacing {
//    CGSize imageSize = self.imageView.frame.size;
//    CGSize titleSize = self.titleLabel.frame.size;
//    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName :self.titleLabel.font}];
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0,0.0,0.0,spacing/2);
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0,spacing/2,0.0,0.0);

}


- (void)setImage:(UIImage *)image forState:(UIControlState)state withurl:(NSString *)url {
    YYWebImageManager *manager =  [YYWebImageManager sharedManager];
    NSURL *imageURL  = [NSURL URLWithString:url];
    UIImage *imageFromMemory = nil;
    if (manager.cache) {
        imageFromMemory = [manager.cache getImageForKey:[manager cacheKeyForURL:imageURL] withType:YYImageCacheTypeMemory];
        
    }
    if (imageFromMemory) {
        [self setImage:imageFromMemory forState:state];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
    } else{
        [self setImage:image forState:state];
    }
}


@end
