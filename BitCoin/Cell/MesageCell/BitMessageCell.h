//
//  BitMessageCell.h
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitMessageEntity.h"
@interface BitMessageCell : UITableViewCell
- (void)setMessageCellData:(BitMessageEntity *)entity;
@end
