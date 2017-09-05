//
//  BitMessageEntity.h
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "MJExtension.h"

@interface BitMessageEntity : NSObject
@property (nonatomic ,strong)NSString *btc_id;
@property (nonatomic ,strong)NSString *content;
@property (nonatomic ,strong)NSString *content_link;
@property (nonatomic ,strong)NSString *create_time;
@property (nonatomic ,strong)NSString *device_id;
@property (nonatomic ,strong)NSString *event;
@property (nonatomic ,strong)NSString *msg_id;
@property (nonatomic ,strong)NSString *read_status;
@property (nonatomic ,strong)NSString *uid;
@end
