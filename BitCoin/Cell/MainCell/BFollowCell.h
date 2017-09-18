//
//  BFollowCell.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/23.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitEnity.h"
@protocol BFollowCellDelegate;

@interface BFollowCell : UITableViewCell
@property (nonatomic ,unsafe_unretained)id <BFollowCellDelegate>delegate;
- (void)setFollowData:(BitEnity *)entity withDisPlay:(NSInteger)display withAnimation:(BOOL)animation;


@end

@protocol BFollowCellDelegate <NSObject>

@optional
- (void)didSelect:(BFollowCell *)cell withDisPlay:(NSInteger)display;

@end
