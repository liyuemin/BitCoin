//
//  BitDetailsViewModel.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/28.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BaseViewModel.h"

@interface BitDetailsViewModel : BaseViewModel

- (void)requesBitDetailsWithId:(NSArray *)param net:(BOOL)net;
- (void)requestBitPrice:(NSArray *)pram withkey:(NSString *)key net:(BOOL)net;
- (void)requestUnFollow:(NSArray *)param withBackParam:(NSDictionary *)back withNet:(BOOL)net;
- (void)requestFollow:(NSDictionary *)param withBackParam:(NSDictionary *)back withNet:(BOOL)net;
- (void)requestLasterPrice:(NSArray *)pram withKey:(NSString *)key withNet:(BOOL)net;
@end
