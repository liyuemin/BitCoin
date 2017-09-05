//
//  BitSearchHotWordCell.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/31.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitSearchHotEntity.h"

@protocol BitSearchHotWordCellDelegate;

@interface BitSearchHotWordCell : UITableViewCell
@property (nonatomic ,unsafe_unretained)id <BitSearchHotWordCellDelegate>delegate;
- (void)setCellData:(NSArray *)data;
@end


@protocol BitSearchHotWordCellDelegate <NSObject>

@optional

- (void)selectBitItem:(BitSearchHotEntity *)entity;

@end
