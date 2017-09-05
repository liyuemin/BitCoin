//
//  MSTextView.h
//  MSVideo
//
//  Created by mai on 17/8/8.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MSTextViewPlaceholderType)
{
    MSTextViewPlaceholderCenterType,
    MSTextViewPlaceholderLeftType,
};

@interface MSTextView : UITextView
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) MSTextViewPlaceholderType placeholderType;
@property (nonatomic, strong) UILabel *placeholderLable;

@end
