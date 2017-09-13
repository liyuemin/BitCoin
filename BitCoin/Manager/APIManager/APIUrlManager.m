//
//  APIUrlManager.m
//  MaiMaiMai
//
//  Created by yuemin li on 16/10/13.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import "APIUrlManager.h"





/*----------------------------------------------------------------------------- */
NSString * const API_Back_URLParam = @"API_Back_URLParam";
NSString * const API_Back_ExtroInfo = @"API_Back_ExtroInfo";
NSString * const API_Back_CachMd5 = @"API_Back_CachMd5";
NSString * const API_Back_NotNet = @"API_Back_NotNet";
NSString * const API_Back_URLCode = @"API_Back_URLCode";
NSString * const API_PostUserInfo_Code = @"API_PostUserInfo_Code";  //有业务逻辑传入统计数据放在请求参数里面
/*----------------------------------------------------------------------------- */

#pragma mark - H5 URL

/*----------------------------------------------------------------------------- */
NSString * const API_H5_GoVideoDetail = @"/tapai?id=";
/*----------------------------------------------------------------------------- */

NSString *const API_BitHomeList_Code = @"/v1/btc/index";
NSString *const API_BitClassInfo_Code = @"/v1/btc/type";
NSString *const API_BitDetail_Code = @"/v1/btc/detail";
NSString *const API_BitSerach_Code = @"/v1/btc/search";
NSString *const API_BitSearchHot_Code = @"/v1/btc/hot_search";
NSString *const API_BitFollow_Code = @"/v1/device/follow";
NSString *const API_BitANPSRegister_Code = @"/v1/device/register";
NSString *const API_BitMessage_Code = @"/v1/device/message/";
NSString *const API_BitPrice_Code = @"/v1/btc/price";
NSString *const API_BitUnFollow_Code = @"/v1/device/un_follow";
NSString *const API_BitLaster_Code   = @"/v1/btc/latest";
NSString *const API_BitStart_Code = @"/v1/btc/start";


NSString *const API_Login_Code = @"/V1/Login";
NSString *const API_Mobile_Login_Code = @"/V1/Mobile";

NSString *const API_HomeList_Code = @"/V1/Video/all/";


NSString *const API_Like_Code = @"/V1/Like";
NSString *const API_IsLike_Code = @"/V1/Like/check/";
NSString *const API_Follow_Code = @"/V1/Follow";
NSString *const API_Follow_Check_Code = @"/V1/Follow/check/";
NSString *const API_DeleteVideo_Code = @"/V1/Video";
NSString *const API_VideoComment_Code = @"/Comment/";
NSString *const API_VideoSendComment_Code = @"/Comment";
NSString *const API_VideoCommentCount_Code = @"/Comment/count/";

NSString *const API_User_Code = @"/V1/User";
NSString *const API_User_Icon_Code = @"/V1/User/icon";
NSString *const API_User_LikeCount_Code = @"/V1/Like/count";
NSString *const API_User_IssueCount_Codeo = @"/V1/Video/count";
NSString *const API_User_IssueVideo_Codeo = @"/V1/Video/oneself/";
NSString *const API_User_likeVideo_Codeo = @"/V1/Like/";
NSString *const API_Openim_InfoCode_Code = @"/V1/User/feedback";
NSString *const API_Deviceboot_Code_Code = @"/V1/Device/boot";


NSString *const API_User_NoticeCount_Codeo = @"/V1/Notice/count";
NSString *const API_User_NoticeList_Codeo = @"/V1/Notice/";
NSString *const API_User_Notice_Codeo = @"/V1/Notice";

NSString *const API_Video_request_Codeo = @"/V1/Video/request";
NSString *const API_Image_request_Codeo = @"/V1/Video/imageRequest";

NSString *const API_BgMusic_Codeo = @"/V1/BgMusic/category";
NSString *const API_BgMusics_Codeo = @"/V1/BgMusic/";


/*----------------------------------------------------------------------------- */

#define SIGN_KEY   @"bA@k5|k4#Lg{Vo&ZM?x4!7Lz-uG+aH\P*E6}3$Q/L"   // 0cb49b9d3257ffa0  调试签名


@implementation APIUrlManager


+ (NSString *)getSingKey {
    return SIGN_KEY;
}

+ (NSString *)getdefaultUrl:(NSDictionary *)backDic
{
    return [backDic objectForKey:API_Back_URLParam];
}



+ (NSString *)getParamUrlSring:(NSDictionary *)param {
    NSMutableString *sign = [[NSMutableString alloc] init];
    NSArray *keys = [[param allKeys] sortedArrayWithOptions:NSSortStable usingComparator:^(id objOne , id objTwo)
                     {
                         return[objOne compare:objTwo];
                     }];
    for(int i = 0 ; i < keys.count ; i++){
        NSString *key = [keys objectAtIndex:i];
        if(i == 0){
            [sign appendFormat:@"%@=%@",key,[param valueForKey:key]];
        }else{
            [sign appendFormat:@"#%@=%@",key,[param valueForKey:key]];
        }
    }
    NSLog(@"sign is:%@",sign);
    return sign;
}

+ (NSString *)getURLSign:(NSString *)url{
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@%@",SIGN_KEY,url,SIGN_KEY]);
    return [[NSString stringWithFormat:@"%@%@%@",SIGN_KEY,url,SIGN_KEY] md5];
}

+(NSString *)getHttpRequestUrl:(NSString *)url defaultUrl:(NSDictionary *)defauls Param:(NSDictionary *)param {
    NSString *paramUrl = [APIUrlManager getParamUrlSring:param];
    NSString *sign = [APIUrlManager getURLSign:paramUrl];
    
    NSString * urlTmp = nil;
//    [NSString stringWithFormat:@"%@%@%@&sign=%@",API_Base, [APIUrlManager getdefaultUrl:defauls],paramUrl, sign];
    
    return urlTmp;
}

+ (NSDictionary *)getHeaderInfo
{
    return nil;
}

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr
{
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}
@end
