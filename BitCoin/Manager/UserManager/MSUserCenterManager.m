//
//  MSUserCenterManager.m
//  MSVideo
//
//  Created by mai on 17/7/14.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "MSUserCenterManager.h"
#import "DBQueueManager.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

#define IDSTRING @"idString"
#define TOKENSTRING @"tokenString"
#define TOKENEXPIRETIME @"tokenExpiretime"
#define TOKENEXPIREBOUND @"tokenExpireBound"

@interface MSUserCenterManager ()

@property (nonatomic, copy) LoginActionResult loginActionResult;

@end


@implementation MSUserCenterManager

SYNTHESIZE_SINGLETON_FOR_CLASS(MSUserCenterManager)





+ (BOOL)deleteUserInformationData:(NSString *)sqlStr
{
    return [[DBQueueManager shareDBQueueManager] deleteDataFromTable:@"USERINFO_TABLE" Where:sqlStr];
}

+(BOOL)deleteShowreVideosmationData:(NSString*)sqlStr
{
 return [[DBQueueManager shareDBQueueManager] deleteDataFromTable:@"MSSHOWEEELVIDEO_TABLE" Where:sqlStr];
}

- (void)setUserID:(NSString *)idString
{
    if (kisNilString(idString))
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:IDSTRING];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:idString forKey:IDSTRING];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)getUserID
{
    NSString * idString = [[NSUserDefaults standardUserDefaults] objectForKey:IDSTRING];
    return idString;
}

- (NSString *)getUserToken
{
    NSString * tokenString = [[NSUserDefaults standardUserDefaults] objectForKey:TOKENSTRING];
    return tokenString;
}

- (void)setUserToken:(NSString *)userToken
{
    if (kisNilString(userToken))
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:TOKENSTRING];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:TOKENSTRING];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)getUserTokenExpire
{
    NSString * tokenExpireString = [[NSUserDefaults standardUserDefaults] objectForKey:TOKENEXPIRETIME];
    return tokenExpireString;
}

- (void)setUserTokenExpire:(NSString *)userTokenExpire
{
    if (kisNilString(userTokenExpire))
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:TOKENEXPIRETIME];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:userTokenExpire forKey:TOKENEXPIRETIME];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)getUserTokenExpireBound
{
    NSString * tokenExpireBoundString = [[NSUserDefaults standardUserDefaults] objectForKey:TOKENEXPIREBOUND];
    return tokenExpireBoundString;
}

- (void)setUserTokenExpireBound:(NSString *)userTokenExpireBound
{
    if (kisNilString(userTokenExpireBound))
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:TOKENEXPIREBOUND];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:userTokenExpireBound forKey:TOKENEXPIREBOUND];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



//退出
- (void)logoutAction
{
    //本地删除登录access_token
    [self setUserToken:nil];
    //本地删除登录access_token expireTime
    [self setUserTokenExpire:nil];
    //本地删除登录access_token expireTimeBound
    [self setUserTokenExpireBound:nil];
    //本地删除userInfo对应ID数据库
    [MSUserCenterManager deleteUserInformationData:[NSString stringWithFormat:@"uid=%@",USERID]];
    //本地删除登录UserID
    [self setUserID:nil];
    // ALIBaichuan Logout
    //    [[SPKitExample sharedInstance] callThisBeforeISVAccountLogout];
}



@end
