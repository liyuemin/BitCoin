//
//  BHomeViewModel.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/24.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BHomeViewModel.h"

@implementation BHomeViewModel

- (void)requestBitClassInfoListWithNet:(BOOL)net {
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:API_BitClassInfo_Code,API_Back_URLCode,nil];
    
    if (!net)
    {
        [senderDic setObject:@(true) forKey:API_Back_NotNet];
    }
    
    [self dataWithTaskUrl:API_Base Method:@"GET" Param:nil Sender:senderDic];

}
- (void)requesBitHomeList:(NSArray *)prarm withKey:(NSString *)key net:(BOOL)net
{
    NSMutableString *requestUrl = [NSMutableString stringWithCapacity:10];
    for (NSString *sring in prarm){
        [requestUrl appendString:[NSString stringWithFormat:@"/%@",sring]];
    }
    
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@%@",API_BitHomeList_Code,requestUrl],API_Back_URLCode,key,API_Back_ExtroInfo,nil];
    
    if (!net)
    {
        [senderDic setObject:@(true) forKey:API_Back_NotNet];
    }
    
    [self dataWithTaskUrl:API_Base Method:@"GET" Param:nil Sender:senderDic];
    
}

- (NSURLSessionDataTask *)dataWithTaskUrl:(NSString *)url Method:(NSString *)method Param:(id )param Sender:(NSDictionary *)sender
{
    NSURLSessionDataTask *task = [super dataWithTaskUrl:url Method:method Param:param Sender:sender];
    
    return task;
}

@end
