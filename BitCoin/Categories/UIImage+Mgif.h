//
//  UIImage+Mgif.h
//  MSVideo
//
//  Created by 李沛然 on 2017/8/16.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (MGIF)

+ (UIImage *)sdm_animatedGIFNamed:(NSString *)name;

+ (UIImage *)sdm_animatedGIFWithData:(NSData *)data;

- (UIImage *)sdm_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
