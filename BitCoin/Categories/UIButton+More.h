//
//  UIButton+More.h
//  TRAiDuoBao
//
//  Created by liyuemin on 16/7/27.
//  Copyright © 2016年 李沛然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+YYWebImage.h"

typedef enum {
    ButtonTextContentModeLeft,
    ButtonTextContentModeRight,
    ButtonTextContentModeBottomCenter,

}ButtonTextContentMode;

typedef enum {
    ButtonImageViewContentModeLeft,
    ButtonImageViewContentModeRight,
    ButtonImageViewContentModeTopCenter,

}ButtonImageViewContentMode;

struct ButtonContentStyle {
    ButtonTextContentMode textMode;
    ButtonImageViewContentMode imageMode;
};
typedef struct ButtonContentStyle ButtonContentStyle;

CG_INLINE ButtonContentStyle
ButtonStyleMake(ButtonTextContentMode text ,ButtonImageViewContentMode image){
    ButtonContentStyle style;
    style.textMode = text;
    style.imageMode = image;
    return style;
}


//CG_INLINE ButtonContentStyle


@interface UIButton (More)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;

- (void)setImage:(UIImage *)image withTitle:(NSString *)title withContentStyle:(ButtonContentStyle)style forState:(UIControlState)stateType;

- (void)verticalImageAndTitle:(CGFloat)spacing;
- (void)setHorizontalImageAndTitle:(CGFloat)spacing;

- (void)setImage:(UIImage *)image forState:(UIControlState)state withurl:(NSString *)url;
@end
