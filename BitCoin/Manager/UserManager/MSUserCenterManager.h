//
//  MSUserCenterManager.h
//  MSVideo
//
//  Created by mai on 17/7/14.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MSThirdLoginType){
    MSThirdLoginWeixin,
    MSThirdLoginQQ,
    MSThirdLoginWeibo
};

typedef void(^ LoginActionResult)(id userInfo, NSInteger error, NSString *errormsg);

@interface MSUserCenterManager : NSObject
+ (instancetype)sharedMSUserCenterManager;

+ (BOOL)insertToDBWithUserEntity:(NSString *)userModel;

+ (BOOL)insertToDBWithDatailEntity:(NSString *)DatailModel;

+ (BOOL)insertToDBWithShowreVideoModel:(NSString *)showreVideoModel;

+ (NSDictionary *)getUserDictionaryFromeDB:(NSString *)key;

+(NSArray*)getShowreVideosFromeDB;

+ (BOOL)deleteUserInformationData:(NSString *)sqlStr;

+(BOOL)deleteShowreVideosmationData:(NSString*)sqlStr;

+ (BOOL)upDateUserInfo:(NSDictionary *)dict;

- (void)setUserID:(NSString *)idString;

- (NSString *)getUserID;

- (NSString *)getUserToken;

- (void)setUserToken:(NSString *)userToken;

- (NSString *)getUserTokenExpire;

- (void)setUserTokenExpire:(NSString *)userTokenExpire;

- (NSString *)getUserTokenExpireBound;

- (void)setUserTokenExpireBound:(NSString *)userTokenExpireBound;



//退出




#pragma mark - Third login

/**
 * 第三方登录统一入口
 */
- (void)loginThirdWithThirdType:(NSInteger)thirdType withResultBlock:(LoginActionResult)resultBlock;

/**
 * 微信登录
 */
- (void)loginWeiXinAction;

/**
 * QQ登录
 */
- (void)loginQQAction;

/**
 * 微博登录
 */
- (void)loginWeiBoAction;
/**
 * 阿里im
 */
- (void)aliIMLogin:(NSString *)userid withPassword:(NSString*)password withVC:(UIViewController *)tmpVC;

@end
