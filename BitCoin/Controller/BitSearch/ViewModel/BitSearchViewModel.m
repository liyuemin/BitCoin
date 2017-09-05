//
//  BitSearchViewModel.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/28.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitSearchViewModel.h"

@implementation BitSearchViewModel

- (void)requestSearchWithWord:(NSDictionary *)param withNet:(BOOL)net {
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:API_BitSerach_Code,API_Back_URLCode,nil];
    
    if (!net)
    {
        [senderDic setObject:@(true) forKey:API_Back_NotNet];
    }
    
    [self dataWithTaskUrl:API_Base Method:@"POST" Param:param Sender:senderDic];

}

- (void)requestSearchHotNet:(BOOL)net{
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:API_BitSearchHot_Code,API_Back_URLCode,nil];
    
    if (!net)
    {
        [senderDic setObject:@(true) forKey:API_Back_NotNet];
    }
    
    [self dataWithTaskUrl:API_Base Method:@"GET" Param:nil Sender:senderDic];
}

- (void)requestFollow:(NSDictionary *)param withBackParam:(NSDictionary *)back withNet:(BOOL)net{
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:API_BitFollow_Code,API_Back_URLCode,back,API_Back_ExtroInfo,nil];
    
    if (!net)
    {
        [senderDic setObject:@(true) forKey:API_Back_NotNet];
    }
    
    [self dataWithTaskUrl:API_Base Method:@"POST" Param:param Sender:senderDic];

}

- (NSURLSessionDataTask *)dataWithTaskUrl:(NSString *)url Method:(NSString *)method Param:(id )param Sender:(NSDictionary *)sender
{
    NSURLSessionDataTask *task = [super dataWithTaskUrl:url Method:method Param:param Sender:sender];
    
    return task;
}
@end
