//
//  MSProgressHUDView.h
//  MSVideo
//
//  Created by mai on 17/7/11.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSProgressHUDView : UIView
- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;
@end
