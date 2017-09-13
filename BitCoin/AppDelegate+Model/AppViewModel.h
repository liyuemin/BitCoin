//
//  AppDelegate+ViewModel.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/31.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BaseViewModel.h"

@interface AppViewModel : BaseViewModel
- (void)requestAPNS:(NSDictionary *)param;
- (void)requestStart;
@end
