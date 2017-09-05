//
//  BHomeCell.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/23.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitEnity.h"
#import "MJRefresh.h"

@protocol BHomeCellDelegate;

@interface BHomeCell : UITableViewCell
@property (nonatomic ,unsafe_unretained)id <BHomeCellDelegate>delegate;
-(void)loadData:(NSArray *)array withIndex:(NSInteger)index;
- (void)beginRefreshing;
- (void)endRefreshing;
@end


@protocol BHomeCellDelegate <NSObject>

@optional

- (void)didSelectIndexData:(BitEnity *)entity;
- (void)refreshingData:(BHomeCell *)homecell;
- (void)addBitFollow;
@end
