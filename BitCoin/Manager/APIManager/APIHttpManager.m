//
//  APIHttpManager.m
//  MaiMaiMai
//
//  Created by yuemin li on 16/10/13.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import "APIHttpManager.h"
#import "NSString+AFNetWorkAdditions.h"


@interface APIHttpManager()

@property (nonatomic ,strong)AFHTTPSessionManager *sessionManager;
@property (nonatomic ,strong)NSString *baseUrl;


@end


@implementation APIHttpManager

@synthesize sessionManager;
@synthesize baseUrl;


SYNTHESIZE_SINGLETON_FOR_CLASS(APIHttpManager);

- (id)init
{
    self = [super init];
    if (self)
    {
        self.sessionManager = [[AFHTTPSessionManager alloc] init];
        self.sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
////        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-www-form-urlencoded"];
////        self.sessionManager.requestSerializer  = [AFJSONRequestSerializer serializer];
//        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        //self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (instancetype)initWithSessionUrl:(NSString *)url
{
    self = [super init];
    if (self)
    {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    }
    return self;
}

- (instancetype)initWithBaseUrl:(NSString *)url
{
    self = [super init];
    if (self)
    {
        self.sessionManager = [[AFHTTPSessionManager alloc] init];
    }
    self.baseUrl = url;
    return self;
}

- (NSURLSessionDataTask *)requestTaskUrl:(NSString *)url Param:(NSDictionary *)param withExtroInfo:(NSDictionary *)back blockWithSuccess:(void(^)(id data ,NSDictionary *backSender))block failure:(void(^)(ApiError *error,NSDictionary *backSender))failure
{
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [self.sessionManager.requestSerializer setValue:[requestParam valueForKey:@"x-access-sign"] forHTTPHeaderField:@"x-access-sign"];
    [self.sessionManager.requestSerializer setValue:[requestParam valueForKey:@"x-access-time"] forHTTPHeaderField:@"x-access-time"];
    if ([[requestParam allKeys]containsObject:@"x-access-token"]) {
       [self.sessionManager.requestSerializer setValue:[requestParam valueForKey:@"x-access-token"] forHTTPHeaderField:@"x-access-token"];
        [requestParam removeObjectForKey:@"x-access-token"];
    }
    [requestParam removeObjectForKey:@"x-access-sign"];
    [requestParam removeObjectForKey:@"x-access-time"];
    
     NSLog(@"----%@",[self.sessionManager.requestSerializer HTTPRequestHeaders]);

    return [self.sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"GET requesUrl is:%@ response is %@",url,responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]] ||[responseObject isKindOfClass:[NSArray class]])
        {
            if(block)
            {
                if ([responseObject isKindOfClass:[NSDictionary class]]){
                    
                    block([NSDictionary dictionaryWithDictionary:responseObject],back);
                }
                if ([responseObject isKindOfClass:[NSArray class]]){
                    
                    block(responseObject,back);
                }
               
            }
            else
            {
                if (failure)
                {
                    ApiError *error = [[ApiError alloc]init];
                    error.statusCode = MErrorTypeServerExcuteError;
                    failure(error,back);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"GET url%@ error is:%@",url,error);
        
        if (failure)
        {
            NSLog(@"error is:%@",error.userInfo);
            
            ApiError *tmpError = [[ApiError alloc]initWithDomain:error.domain code:error.code userInfo:error.userInfo];
            tmpError.statusCode = (long)((NSHTTPURLResponse *)task.response).statusCode;
            failure(tmpError,back);
        }
    }];
}

-(NSURLSessionDataTask *)postTaskUrl:(NSString *)url Param:(id)param withExtroInfo:(NSDictionary *)back SuceessBlock:(void(^)(id data ,NSDictionary *backSender))block failure:(void(^)(ApiError *error ,NSDictionary *backSender))failure
{
    NSLog(@"param == %@",param);
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithDictionary:param];
    
    //self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-www-form-urlencoded"];
    //self.sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //[self.sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.sessionManager.requestSerializer setValue:[requestParam valueForKey:@"x-access-sign"] forHTTPHeaderField:@"x-access-sign"];
    [self.sessionManager.requestSerializer setValue:[requestParam valueForKey:@"x-access-time"] forHTTPHeaderField:@"x-access-time"];
    if ([[requestParam allKeys]containsObject:@"x-access-token"]) {
        [self.sessionManager.requestSerializer setValue:[requestParam valueForKey:@"x-access-token"] forHTTPHeaderField:@"x-access-token"];
        [requestParam removeObjectForKey:@"x-access-token"];
    }
    [requestParam removeObjectForKey:@"x-access-sign"];
    [requestParam removeObjectForKey:@"x-access-time"];
    
    NSLog(@"----%@",[self.sessionManager.requestSerializer HTTPRequestHeaders]);
    
    
    return [self.sessionManager POST:url parameters:requestParam progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"POST requesUrl is:%@ response is %@",url,responseObject);
        if(block){
            if ([responseObject isKindOfClass:[NSArray class]]){
                
                block(responseObject,back);
            }else if ([responseObject isKindOfClass:[NSDictionary class]]){
                block([NSDictionary dictionaryWithDictionary:responseObject],back);
            }else if (responseObject == nil){
                block(nil ,back);
            }

        } else {
            if (failure)
            {
                ApiError *error = [[ApiError alloc]init];
                error.statusCode = MErrorTypeServerExcuteError;
                failure(error,back);
            }

        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"RESTAPI:Fail:%@",error.description);
        if (failure)
        {
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if(data != nil){
                NSDictionary *body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",body);
                
                ApiError *tmpError = [[ApiError alloc]initWithDomain:error.domain code:error.code userInfo:error.userInfo];
                tmpError.statusCode = (long)((NSHTTPURLResponse *)task.response).statusCode;
                tmpError.message = [body objectForKey:@"msg"];
                NSLog(@"%@",tmpError.message);
                failure(tmpError,back);
            }else
            {
                NSLog(@"error is:%@",error.userInfo);
                
                ApiError *tmpError = [[ApiError alloc]initWithDomain:error.domain code:error.code userInfo:error.userInfo];
                tmpError.statusCode = (long)((NSHTTPURLResponse *)task.response).statusCode;
                failure(tmpError,back);
            }
        }
    }];
}

-(NSURLSessionDataTask *)deleteTaskUrl:(NSString *)url Param:(id)param withExtroInfo:(NSDictionary *)back SuceessBlock:(void(^)(id data ,NSDictionary *backSender))block failure:(void(^)(ApiError *error ,NSDictionary *backSender))failure
{
    NSLog(@"param == %@",param);
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithDictionary:param];
    
    [self.sessionManager.requestSerializer setValue:[requestParam valueForKey:@"x-access-sign"] forHTTPHeaderField:@"x-access-sign"];
    [self.sessionManager.requestSerializer setValue:[requestParam valueForKey:@"x-access-time"] forHTTPHeaderField:@"x-access-time"];
    if ([[requestParam allKeys]containsObject:@"x-access-token"]) {
        [self.sessionManager.requestSerializer setValue:[requestParam valueForKey:@"x-access-token"] forHTTPHeaderField:@"x-access-token"];
        [requestParam removeObjectForKey:@"x-access-token"];
    }
    [requestParam removeObjectForKey:@"x-access-sign"];
    [requestParam removeObjectForKey:@"x-access-time"];
    
    NSLog(@"----%@",[self.sessionManager.requestSerializer HTTPRequestHeaders]);
    self.sessionManager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];

   return [self.sessionManager DELETE:url parameters:requestParam success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
       NSLog(@"DELETE requesUrl is:%@ response is %@",url,responseObject);
       if ([responseObject isKindOfClass:[NSDictionary class]] ||[responseObject isKindOfClass:[NSArray class]])
       {
           if(block)
           {
               if ([responseObject isKindOfClass:[NSDictionary class]]){
                   
                   block([NSDictionary dictionaryWithDictionary:responseObject],back);
               }
               if ([responseObject isKindOfClass:[NSArray class]]){
               
                   block(responseObject,back);
               }
               
           }
           
           else
           {
               if (failure)
               {
                   ApiError *error = [[ApiError alloc]init];
                   error.statusCode = MErrorTypeServerExcuteError;
                   failure(error,back);
               }
           }
       }

       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
       if (failure)
       {
           NSLog(@"error is:%@",error.userInfo);
           
           ApiError *tmpError = [[ApiError alloc]initWithDomain:error.domain code:error.code userInfo:error.userInfo];
           tmpError.statusCode = (long)((NSHTTPURLResponse *)task.response).statusCode;
           failure(tmpError,back);
       }

       
   }];

}

-(NSURLSessionDataTask *)productGET:(NSString *)interfacePath
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    AFHTTPSessionManager *httpSessionManager =[AFHTTPSessionManager manager];
    httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [httpSessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSString *key = interfacePath;
    NSString *date = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if(date != nil && ![date isEqualToString:@""])
    {
        [httpSessionManager.requestSerializer setValue:date forHTTPHeaderField:@"If-Modified-Since"];
    }
    NSString *path = [NSString stringWithFormat:@"%@",interfacePath];
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [httpSessionManager GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    return nil;
}

@end

