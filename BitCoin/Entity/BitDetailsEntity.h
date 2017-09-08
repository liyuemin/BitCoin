//
//  BitDetailsEntity.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/28.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "MJExtension.h"

@interface BitDetailsEntity : NSObject
@property (nonatomic ,strong)NSString *btc_id;
@property (nonatomic ,strong)NSString *btc_zh_name;
@property (nonatomic ,strong)NSString *btc_en_name;
@property (nonatomic ,strong)NSString *btc_web;
@property (nonatomic ,strong)NSString *btc_title_display;
@property (nonatomic ,strong)NSString *btc_trade_from_name;
@property (nonatomic ,strong)NSString *btc_desc;
@property (nonatomic ,strong)NSString *btc_trade_from_url;
@property (nonatomic ,strong)NSString *btc_price;
@property (nonatomic ,strong)NSString *rising_val;
@property (nonatomic ,strong)NSString *rising;
@property (nonatomic ,strong)NSString *trading;
@property (nonatomic ,assign)BOOL is_follow;

@end
