//
//  ZHGridView.h
//  ZongHeng
//
//  Created by 李贺 on 15/10/13.
//  Copyright (c) 2015年 李贺. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZHGridViewType) {
    ZHGridViewTypeHor,
    ZHGridViewTypeVer
};

@interface ZHGridView : UIView
/**
 * @brief 网格间距，默认30
 */
@property (nonatomic, assign) CGFloat   gridSpacing;
/**
 * @brief 网格线宽度，默认为1 pixel (1.0f / [UIScreen mainScreen].scale)
 */
@property (nonatomic, assign) CGFloat   gridLineWidth;
/**
 * @brief 网格颜色，默认蓝色
 */
@property (nonatomic, strong) UIColor   *gridColor;

@property (nonatomic, weak) UIView *callView;

@property (nonatomic, assign) ZHGridViewType gridViewType;

@end
