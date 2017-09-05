//
//  BitDetailsViewModel.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/28.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitDetailsViewModel.h"

@implementation BitDetailsViewModel

- (void)requesBitDetailsWithId:(NSString *)bitid net:(BOOL)net {
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@%@",API_BitDetail_Code,bitid],API_Back_URLCode,nil];
    
    if (!net)
    {
        [senderDic setObject:@(true) forKey:API_Back_NotNet];
    }
    
    [self dataWithTaskUrl:API_Base Method:@"GET" Param:nil Sender:senderDic];

}

- (void)requestBitPrice:(NSArray *)pram withkey:(NSString *)key net:(BOOL)net {
    NSMutableString *requestUrl = [NSMutableString stringWithCapacity:10];
    for (NSString *sring in pram){
        [requestUrl appendString:[NSString stringWithFormat:@"/%@",sring]];
    }
    
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@%@",API_BitPrice_Code,requestUrl],API_Back_URLCode,key,API_Back_ExtroInfo,nil];
    
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
