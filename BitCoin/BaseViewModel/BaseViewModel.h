//
//  BaseViewModel.h
//  MaiMaiMai
//
//  Created by yuemin li on 16/10/13.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APIHttpManager.h"
#import "MFileCahcheManager.h"

typedef NS_ENUM(NSInteger, MDataRequestType) {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    MDataRequestTypeFailure,
    MDataRequestTypeNet
};

typedef NS_ENUM(NSInteger, MNetStatusType) {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    MNetStatusTypeFailure,
    MNetStatusTypeWifi,
    MNetStatusTypeNotWifi
};



typedef void (^SuccessReturnAction) (id returnParam,id extroInfo);
typedef void (^FailureReturnAction) (ApiError* error,id extroInfo);
typedef void (^ErrorReturnAction) (id errorCode,id extroInfo);


@interface BaseViewModel : NSObject


@property (nonatomic ,strong)APIHttpManager *requesManage;
@property (nonatomic, copy) SuccessReturnAction successBlock;
@property (nonatomic, copy) FailureReturnAction failBlock;
@property (nonatomic, copy) ErrorReturnAction errorBlock;

- (NSURLSessionDataTask *)dataWithTaskUrl:(NSString *)url Method:(NSString *)method Param:(id)param Sender:(NSDictionary *)sender;


- (void)setBlockWithReturnBlock: (SuccessReturnAction) returnBlock
                 WithErrorBlock: (ErrorReturnAction) errorBlock
               WithFailureBlock: (FailureReturnAction) failureBlock;

- (NSString *)getTimerString;

+ (BOOL)netSuccessToGetDataWithURLString;

+ (MNetStatusType)applicationNetStatus;

@end
