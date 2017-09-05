//
//  MShareView.h
//  MaiMaiMai
//
//  Created by yuemin li on 16/10/28.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MShareViewDelegate;


@interface MShareView : UIView
@property (nonatomic ,unsafe_unretained)id<MShareViewDelegate> delegate;
+ (void)initWithDelegate:(id)del withDataPlist:(NSString *)plist;
@end

@protocol MShareViewDelegate <NSObject>

@optional
- (void)didClictButton:(NSString *)text;
-(void)shareViewdisappear;
@end
