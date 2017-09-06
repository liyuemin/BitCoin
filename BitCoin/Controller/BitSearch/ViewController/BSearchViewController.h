//
//  BSearchViewController.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/23.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^SearchFollowResult) (BOOL result);

@interface BSearchViewController : BaseViewController
@property (nonatomic ,copy)SearchFollowResult followBlock;
@end
