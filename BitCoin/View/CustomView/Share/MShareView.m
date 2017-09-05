//
//  MShareView.m
//  MaiMaiMai
//
//  Created by yuemin li on 16/10/28.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import "MShareView.h"
#import "UIButton+More.h"
#define ShareButtonLeftDistance 15
#define ShareButtonTopDistance 15
#define ButtonCount   4
#define ShareButtonWidth (ScreenWidth-30.0)/ButtonCount
#define CancelButtonHeight 49


@interface MShareView()
@property (nonatomic ,strong)UIView *contentView;
//@property (nonatomic ,strong)UIVisualEffectView *bgView;
@property (nonatomic ,strong)UIView *bgView;

@end

@implementation MShareView
@synthesize bgView = _bgView;
@synthesize contentView = _contentView;
@synthesize delegate = _delegate;

+ (void)initWithDelegate:(id)del withDataPlist:(NSString *)plist {
    
}


- (void)dealloc {

    _contentView = nil;
    _bgView = nil;
}

- (instancetype)init {
    self = [super init];
    if (self){

    }
    return self;
}


@end
