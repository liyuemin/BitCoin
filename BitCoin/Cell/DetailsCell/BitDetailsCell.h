//
//  BitDetailsCell.h
//  BitCoin
//
//  Created by yuemin li on 2017/9/7.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitDetailsEntity.h"

@protocol BitDetailsCellDelegate;

@interface BitDetailsCell : UITableViewCell
@property (nonatomic ,unsafe_unretained)id <BitDetailsCellDelegate>delegate;
- (void)setDetailCellData:(BitDetailsEntity *)entity;
@end

@protocol BitDetailsCellDelegate <NSObject>

@optional
- (void)selectDetailsCell:(BitDetailsCell *)cell withFollow:(BOOL)follow;

@end
