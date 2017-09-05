//
//  BitSearchViewModel.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/28.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BaseViewModel.h"

@interface BitSearchViewModel : BaseViewModel
- (void)requestSearchWithWord:(NSDictionary *)param withNet:(BOOL)net;
- (void)requestSearchHotNet:(BOOL)net;
- (void)requestFollow:(NSDictionary *)param withBackParam:(NSDictionary *)back withNet:(BOOL)net;
@end
