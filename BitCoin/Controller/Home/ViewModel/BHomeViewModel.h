//
//  BHomeViewModel.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/24.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BaseViewModel.h"

@interface BHomeViewModel : BaseViewModel
- (void)requesBitHomeList:(NSArray *)prarm withKey:(NSString *)key net:(BOOL)net;
- (void)requestBitClassInfoListWithNet:(BOOL)net;
@end
