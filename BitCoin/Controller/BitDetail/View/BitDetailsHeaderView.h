//
//  BitDetailsHeaderView.h
//  BitCoin
//
//  Created by yuemin li on 2017/9/13.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitDetailsEntity.h"
#import "BitDetailsPriceEntity.h"

@protocol BitDetailsHeaderViewDelegate;
@interface BitDetailsHeaderView : UIView
@property (nonatomic ,unsafe_unretained)id <BitDetailsHeaderViewDelegate>delegate;
- (void)setDetailCellData:(BitDetailsEntity *)entity;
- (void)setBitLineData:(NSArray *)array withKey:(NSString *)key;
- (void)setBitLineLasterPrice:(BitDetailsPriceEntity *)entity;
@end

@protocol BitDetailsHeaderViewDelegate <NSObject>

@optional
- (void)selectDetailsHeader:(BitDetailsHeaderView *)header withFollow:(BOOL)follow;
- (void)selectSegmentIndex:(NSInteger)index withKey:(NSString *)key;
@end
