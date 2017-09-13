//
//  BitFeatureView.h
//  BitCoin
//
//  Created by yuemin li on 2017/9/8.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitEnity.h"
@protocol BitFeatureViewDelegate;
@interface BitFeatureView : UIView
@property (nonatomic ,strong)UIImageView *bgImageView;
@property (nonatomic ,unsafe_unretained)id <BitFeatureViewDelegate> delegate;
- (void)setFeatureData:(NSArray *)array;
@end

@protocol BitFeatureViewDelegate <NSObject>

@optional
- (void)removeFeatureView:(BitFeatureView *)featrue;

@end
