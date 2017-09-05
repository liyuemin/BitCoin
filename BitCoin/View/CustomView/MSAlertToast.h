//
//  MSAlertToast.h
//  MSVideo
//
//  Created by mai on 17/7/28.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSAlertToast : UIView
- (void)setShowText:(NSString *)tmpText;
- (void)showInView:(UIView *)tmpSuperView WithHidden:(BOOL)tmpHidden withCancelOtherBool:(BOOL)cancelBool;
- (void)setMyOrigin:(float)tmpOrigin;

- (void)hidden;
@end
