//
//  BitHomeFooterView.h
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BitHomeFooterViewDelegate;

@interface BitHomeFooterView : UIView

@end

@protocol BitHomeFooterViewDelegate <NSObject>

@optional
- (void)addBitWithFollow;

@end
