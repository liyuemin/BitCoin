//
//  MSWebViewController.h
//  MSVideo
//
//  Created by mai on 17/7/14.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BaseViewController.h"

@interface MSWebViewController : BaseViewController
@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, copy) NSString *webDefaultTitle;
@property (nonatomic, copy) NSString *webUrlString;
@property (nonatomic, copy) NSDictionary *postBody;
- (void)goBack;

- (void)loadPage;
@end
