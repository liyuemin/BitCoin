//
//  MSLoadingView.h
//  MSVideo
//
//  Created by mai on 17/7/27.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MSNoResultType)
{
    MSNoResultBlankType = 0, //空白
    MSNoResultNetType, //网络错误
    MSNoResultSysMsgListType, //我的消息
    MSNoResultShowreelType, //本地作品
};

typedef NS_ENUM(NSInteger, MSLoadingType)
{
    MSLoadingBlankType = 0, //空白
    MSLoadingLoadingType, //正在加载...
    MSLoadingNoResultType, //加载无结果
};

@protocol MSLoadingViewDelegate <NSObject>

@optional
- (void)msLoadingRetryAction;

@end



@interface MSLoadingView : UIView
@property (nonatomic, assign) MSLoadingType loadingType;
@property (nonatomic, assign) MSNoResultType noResultType;
@property (nonatomic, assign) id <MSLoadingViewDelegate> delegate;
@property (nonatomic ,strong)UIImage *reloadImage;

@end
