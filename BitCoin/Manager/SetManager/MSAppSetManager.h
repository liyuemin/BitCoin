//
//  MSAppSetManager.h
//  MSVideo
//
//  Created by mai on 17/7/14.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSAppSetManager : NSObject
@property (nonatomic ,strong)NSString *appId;

+ (instancetype)sharedMSAppSetManager;

/**
 * 跳转到登录
 */
+ (void)presentLoginViewController;

- (void)getAppStroeVersion:(UIViewController *)controller;
- (void)openAppStroe;

+ (void)saveUDID:(NSString *)data;

+ (NSString *)getUDID;
+ (void)generateIdentifierStr;

@end
