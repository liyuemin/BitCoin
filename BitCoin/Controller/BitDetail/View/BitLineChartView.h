//
//  BitLineChartView.h
//  BitCoin
//
//  Created by yuemin li on 2017/9/2.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitDetailsPriceEntity.h"

typedef enum {
    BitLineTimeTypeMinutes = 5,
    BitLineTimeTypeHours = 6,
    BitLineTimeTypeDays = 7,
    BitLineTimeTypeMonth = 8
    
}BitLineTimeType;

@interface BitLineChartView : UIView
@property (nonatomic ,assign)NSInteger verticalCount;
@property (nonatomic ,assign)NSInteger horizontalCount;
@property (nonatomic ,assign)BitLineTimeType timeType;
@property (nonatomic ,strong)UIColor *lineColor;
@property (nonatomic ,strong)UIColor *lineXYColor;
@property (nonatomic ,strong)UIColor *verticalTextColor;
@property (nonatomic ,strong)UIColor *horizontalTextColor;
@property (nonatomic ,strong)BitDetailsPriceEntity *lasterPrice;
- (void)clearChartData;
- (void)setDataArray:(NSArray *)dataArray withLaster:(BitDetailsPriceEntity *)entity;
@end
