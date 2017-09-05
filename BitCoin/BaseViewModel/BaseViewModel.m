//
//  BaseViewModel.m
//  MaiMaiMai
//
//  Created by yuemin li on 16/10/13.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import "BaseViewModel.h"
#import "MSAppSetManager.h"
#import "MSUserCenterManager.h"
#import "APIUrlManager.h"
#define MRsponsJsonFilePath @"MSVideoJsonFile"

@interface BaseViewModel()

@end


@implementation BaseViewModel
@synthesize requesManage = _requesManage;


- (instancetype)init {
    self = [super init];
    if (self){
    
    }
    return self;
}




-  (APIHttpManager *)requesManage {
    if (!_requesManage){
        _requesManage  = [[APIHttpManager alloc] initWithBaseUrl:API_Base];
    }
    return _requesManage;
}


- (void)dealloc
{
    NSLog(@"%s",__func__);
    self.successBlock = nil;
    self.failBlock = nil;
    self.errorBlock = nil;
}



- (void)setBlockWithReturnBlock:(SuccessReturnAction)returnBlock
                 WithErrorBlock:(ErrorReturnAction)errorBlock
               WithFailureBlock:(FailureReturnAction)failureBlock
{
    self.successBlock = returnBlock;
    self.failBlock = failureBlock;
    self.errorBlock = errorBlock;
}


- (NSURLSessionDataTask *)dataWithTaskUrl:(NSString *)url Method:(NSString *)method Param:(id)param Sender:(NSDictionary *)sender {

    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",url,[sender valueForKey:API_Back_URLCode]];
    NSMutableDictionary *requestParam = nil;
    if (param && [param isKindOfClass:[NSDictionary class]]){
        requestParam  = [[NSMutableDictionary alloc] initWithDictionary:param];
    } else {
        requestParam = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    
    NSString *timeSring = [self getTimerString];
    
    [requestParam setObject:timeSring forKey:@"x-access-time"];
#warning user
    if ([[MSUserCenterManager sharedMSUserCenterManager] getUserToken])
    {
        [requestParam setObject:[[MSUserCenterManager sharedMSUserCenterManager]getUserToken] forKey:@"x-access-token"];
    }
    
    NSLog(@"%@",[sender valueForKey:API_Back_URLCode]);
    NSString *signSring = [[NSString stringWithFormat:@"%@#%@#%@",[sender valueForKey:API_Back_URLCode],timeSring,[APIUrlManager getSingKey]] md5];
    
    if ([requestParam valueForKey:API_PostUserInfo_Code] != nil){
        NSMutableDictionary *signParam = [[NSMutableDictionary alloc] initWithDictionary:requestParam];
        [signParam removeObjectForKey:API_PostUserInfo_Code];
        
    }
    
    [requestParam setObject:signSring forKey:@"x-access-sign"];
    
   
    
    
    return  [self requestDataWithTaskUrl:requestUrl Param:requestParam Method:method withExtroInfo:sender blockWithSuccess:^(NSDictionary *data, NSDictionary *backSender) {
        if (self.successBlock)
        {
            self.successBlock(data,backSender);
        }
    } failure:^(ApiError *error, NSDictionary *backSender) {
        if (self.failBlock)
        {
            if (error.statusCode == 401)
            {
                [MSAppSetManager presentLoginViewController];
            }
            self.failBlock(error,backSender);
        }
    }];
    
    
}



- (NSURLSessionDataTask *)requestDataWithTaskUrl:(NSString *)url Param:(id)param Method:(NSString *)methodString withExtroInfo:(NSDictionary *)back blockWithSuccess:(void(^)(id data ,NSDictionary *backSender))block failure:(void(^)(ApiError *error,NSDictionary *backSender))failure
{
    
     NSMutableDictionary *requestParam = [[NSMutableDictionary alloc] initWithDictionary:param];
    if ([requestParam valueForKey:API_PostUserInfo_Code] != nil){
        [requestParam removeObjectForKey:API_PostUserInfo_Code];
    }
    
    if ([back objectForKey:API_Back_NotNet] && [[back objectForKey:API_Back_NotNet] integerValue] == 1)
    {
        NSMutableString *jsonString = nil;
        NSMutableDictionary *mutBack = [NSMutableDictionary dictionaryWithDictionary:back];
        [mutBack removeObjectForKey:API_Back_NotNet];
        if (requestParam)
        {
            jsonString = [NSMutableString stringWithString:[APIUrlManager getParamUrlSring:requestParam]];
            
            [jsonString appendString:[APIUrlManager getParamUrlSring:mutBack]];
        }
        else
        {
            jsonString = [NSMutableString stringWithString:[APIUrlManager getParamUrlSring:mutBack]];
        }
        NSString *tmpBackCachMd5 = [[NSString stringWithFormat:@"%@/%@",url,jsonString] md5];
        NSLog(@"Cache local:%@",[NSString stringWithFormat:@"%@/%@",url,jsonString]);
        NSDictionary *tmpData = [[MFileCahcheManager sharedMFileCahcheManager] readDataWithFilePath:MRsponsJsonFilePath withFileName:tmpBackCachMd5];
        if (block)
        {
            NSLog(@"back dic is:%@",back);
            block(tmpData,back);
        }
        return nil;
    }
    
    else
    {
        NSMutableString *jsonString = nil;
        if (requestParam)
        {
            
            if ([requestParam isKindOfClass:[NSDictionary class]])
            {
                jsonString = [NSMutableString stringWithString:[APIUrlManager getParamUrlSring:requestParam]];
                
                [jsonString appendString:[APIUrlManager getParamUrlSring:back]];
            }
        }
        else
        {
            jsonString = [NSMutableString stringWithString:[APIUrlManager getParamUrlSring:back]];
        }
        NSMutableDictionary *tmpMutDic = [NSMutableDictionary dictionaryWithDictionary:back];
        
        if ([back objectForKey:API_Back_CachMd5])
        {
            NSString *tmpString = [NSString stringWithFormat:@"%@/%@",url,jsonString];
            NSLog(@"Request Cache key:%@",tmpString);
            NSString *tmpBackCachMd5 = [tmpString md5];
            [tmpMutDic setObject:tmpBackCachMd5 forKey:API_Back_CachMd5];
        }
        
        
        
        
        if ([[methodString uppercaseString] isEqualToString:@"POST"])
        {
//            NSMutableDictionary *userInfoDic = [NSMutableDictionary new];
//           
//            if (USERID)
//            {
//                [userInfoDic setObject:USERID forKey:@"uid"];
//            }
////            [userInfoDic setObject:[MAppConfigManager getUDID] forKey:@"device_id"];
//            
            NSURLSessionDataTask *task =  [self.requesManage postTaskUrl:url Param:requestParam withExtroInfo:tmpMutDic SuceessBlock:^(NSDictionary *data, NSDictionary *backSender) {
                if (block)
                {
                    if ([backSender objectForKey:API_Back_CachMd5])
                    {
                        [[MFileCahcheManager sharedMFileCahcheManager] cachWithURLDataFile:data withPath:MRsponsJsonFilePath WithFileName:[backSender objectForKey:API_Back_CachMd5]];
                    }
                    block(data,backSender);
                }
            } failure:^(ApiError *error, NSDictionary *backSender) {
                if (failure)
                {
                    failure(error,backSender);
                }
            }];
            return task;
        }
        else if ([[methodString uppercaseString] isEqualToString:@"GET"])
        {
            
            NSString *paramUrl = [APIUrlManager getParamUrlSring:requestParam];
            NSString * urlTmp = [NSString stringWithFormat:@"%@?%@",url,paramUrl];
            NSLog(@"urlTmp is:%@",urlTmp);
            
            
            NSURLSessionDataTask *task =   [self.requesManage requestTaskUrl:url Param:requestParam withExtroInfo:back blockWithSuccess:^(id data, NSDictionary *backSender) {
                if (block)
                {
                    if ([backSender objectForKey:API_Back_CachMd5])
                    {
                        [[MFileCahcheManager sharedMFileCahcheManager] cachWithURLDataFile:data withPath:MRsponsJsonFilePath WithFileName:[backSender objectForKey:API_Back_CachMd5]];
                    }
                    block(data,backSender);
                }
            } failure:^(ApiError *error, NSDictionary *backSender) {
                if (failure)
                {
                    failure(error,backSender);
                }
            }];
            return task;
        }else if ([[methodString uppercaseString] isEqualToString:@"DELETE"])
        {
            
            NSString *paramUrl = [APIUrlManager getParamUrlSring:requestParam];
            NSString * urlTmp = [NSString stringWithFormat:@"%@?%@",url,paramUrl];
            NSLog(@"urlTmp is:%@",urlTmp);
            
            NSURLSessionDataTask *task =   [self.requesManage deleteTaskUrl:url Param:requestParam withExtroInfo:back SuceessBlock:^(NSDictionary *data, NSDictionary *backSender) {
                if (block)
                {
                    if ([backSender objectForKey:API_Back_CachMd5])
                    {
                        [[MFileCahcheManager sharedMFileCahcheManager] cachWithURLDataFile:data withPath:MRsponsJsonFilePath WithFileName:[backSender objectForKey:API_Back_CachMd5]];
                    }
                    block(data,backSender);
                }

                
            } failure:^(ApiError *error, NSDictionary *backSender) {
                
                if (failure)
                {
                    failure(error,backSender);
                }
            }];
            return task;
        }
        return nil;
    }
    
    
    

}




- (NSString *)getTimerString
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
//    [[NSDate date] timeIntervalSince1970];

//    [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    
    return [NSString stringWithFormat:@"%lld",date];
}




+ (BOOL)netSuccessToGetDataWithURLString
{
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    NSLog(@"type is net:%d",type);
    if (type == 0) {
        return NO;
    }else if(type == 1){
        return YES;
    }else if(type == 2){
        return YES;
    }else if(type == 3){
        return YES;
    }else if(type == 5){
        return YES;
    }else if(type == 6){
        return YES;
    }else if(type == 7){
        return YES;
    }else
    {
        return NO;
    }
}

+ (MNetStatusType)applicationNetStatus
{
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    NSLog(@"type is net:%d",type);
    if (type == 0) {
        return MNetStatusTypeFailure;
    }else if(type == 1){
        return MNetStatusTypeNotWifi;
    }else if(type == 2){
        return MNetStatusTypeNotWifi;
    }else if(type == 3){//4G
        return MNetStatusTypeNotWifi;
    }else if(type == 5){
        return MNetStatusTypeWifi;
    }else if(type == 6){
        return MNetStatusTypeNotWifi;
    }else if(type == 7){
        return MNetStatusTypeNotWifi;
    }else
    {
        return MNetStatusTypeFailure;
    }
}


- (NSMutableDictionary *)getUserInfo:(NSDictionary *)param {
    NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] init];
    if (param){
        [userInfoDic setDictionary:param];
    }
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
    [userInfoDic setObject:version forKey:@"app_version"];
    
    if (USERID)
    {
        [userInfoDic setObject:USERID forKey:@"uid"];
    }

//    [userInfoDic setObject:[MAppConfigManager getUDID] forKey:@"device_id"];
    
    [userInfoDic setObject:@"appstore" forKey:@"form"];
//    [userInfoDic setObject:[MAppConfigManager getSessionid] forKey:@"session_id"];
    [userInfoDic setObject:[UIDevice currentDevice].systemVersion forKey:@"system"];
    return userInfoDic;
}



@end
