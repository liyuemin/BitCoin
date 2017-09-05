//
//  BitDetailsViewModel.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/28.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BaseViewModel.h"

@interface BitDetailsViewModel : BaseViewModel

- (void)requesBitDetailsWithId:(NSString *)bitid net:(BOOL)net;
- (void)requestBitPrice:(NSArray *)pram withkey:(NSString *)key net:(BOOL)net;
@end
