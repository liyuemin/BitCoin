//
//  BitLineChartView.h
//  BitCoin
//
//  Created by yuemin li on 2017/9/2.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BitLineTimeTypeMinutes = 0,
    BitLineTimeTypeHours = 1,
    BitLineTimeTypeDays = 2,
    BitLineTimeTypeMonth = 3
    
}BitLineTimeType;

@interface BitLineChartView : UIView
@property (nonatomic ,assign)NSInteger verticalCount;
@property (nonatomic ,assign)NSInteger horizontalCount;
@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,assign)BitLineTimeType timeType;
@property (nonatomic ,strong)UIColor *lineColor;
@property (nonatomic ,strong)UIColor *lineXYColor;
@property (nonatomic ,strong)UIColor *verticalTextColor;
@property (nonatomic ,strong)UIColor *horizontalTextColor;
- (void)clearChartData;
@end
