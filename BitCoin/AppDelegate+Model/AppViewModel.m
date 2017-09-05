//
//  AppDelegate+ViewModel.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/31.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "AppViewModel.h"

@implementation AppViewModel
- (void)requestAPNS:(NSDictionary *)param{
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:API_BitANPSRegister_Code,API_Back_URLCode,nil];
    
    [self dataWithTaskUrl:API_Base Method:@"POST" Param:param Sender:senderDic];
}

- (NSURLSessionDataTask *)dataWithTaskUrl:(NSString *)url Method:(NSString *)method Param:(id )param Sender:(NSDictionary *)sender
{
    NSURLSessionDataTask *task = [super dataWithTaskUrl:url Method:method Param:param Sender:sender];
    
    return task;
}
@end
