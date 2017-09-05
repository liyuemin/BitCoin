//
//  BitMessageViewModel.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitMessageViewModel.h"

@implementation BitMessageViewModel
- (void)reqeustMessageData:(NSArray *)param net:(BOOL)net{
    NSMutableString *requestUrl = [NSMutableString stringWithCapacity:10];
    for (NSString *sring in param){
        [requestUrl appendString:[NSString stringWithFormat:@"/%@",sring]];
    }
    
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@%@",API_BitMessage_Code,requestUrl],API_Back_URLCode,nil];
    
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
