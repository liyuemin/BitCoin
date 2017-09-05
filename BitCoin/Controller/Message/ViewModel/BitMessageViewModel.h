//
//  BitMessageViewModel.h
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BaseViewModel.h"

@interface BitMessageViewModel : BaseViewModel
- (void)reqeustMessageData:(NSArray *)param net:(BOOL)net;
@end
