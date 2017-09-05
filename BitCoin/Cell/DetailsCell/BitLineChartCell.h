//
//  BitLineChartCell.h
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitDetailsPriceEntity.h"

@protocol BitLineChartCellDelegate;

@interface BitLineChartCell : UITableViewCell
@property (nonatomic ,unsafe_unretained)id <BitLineChartCellDelegate> delegate;
- (void)setBitLineData:(NSArray *)array;
@end

@protocol BitLineChartCellDelegate <NSObject>

@optional
- (void)selectSegmentIndex:(NSInteger)index withKey:(NSString *)key;

@end
