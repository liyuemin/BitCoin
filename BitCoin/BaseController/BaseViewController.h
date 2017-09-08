//
//  BaseViewController.h
//  MaiMaiMai
//
//  Created by yuemin li on 16/10/13.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSProgressHUDView.h"
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController<MBProgressHUDDelegate>

@property (nonatomic, strong) MSProgressHUDView *loadHUD;
@property (nonatomic, assign) BOOL haveBackBtn;
@property (nonatomic, assign) BOOL haveMyNavBar;
@property (nonatomic, assign) BOOL noMyNavBarBackBtn;
@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) UIColor * navBarColor;
@property (nonatomic ,strong) NSString *backImageName;
@property (nonatomic ,strong)MBProgressHUD *HUD;
@property (nonatomic,assign)CGFloat navBarH;
@property (nonatomic, assign) BOOL lineBool;

- (void)setViewModelData;
- (void)setViewModelCallBack;
- (void)showAlertToast:(NSString *)alertString;
- (void)showAlertToast:(NSString *)alertString withHide:(BOOL)hide;
- (void)hideAlertToast;
- (void)hideNavBar;
- (void)showNavBar;
- (void)setNavBarOverlayAlpha:(float)alphaF;


- (NSArray *)propertyNameList;

- (void)goBack;



@end
