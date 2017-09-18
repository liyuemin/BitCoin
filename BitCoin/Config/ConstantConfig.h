//
//  ConstantConfig.h
//  MaiMaiMai
//
//  Created by 李沛然 on 2016/11/14.
//  Copyright © 2016年 李沛然. All rights reserved.
//

#ifndef ConstantConfig_h
#define ConstantConfig_h

//发布到AppStore打开
//#define Distribution


#pragma mark - 系统版本
/*系统版本*/
#ifndef SystemVersion
#define SystemVersion [UIDevice currentDevice].systemVersion.doubleValue
#endif
#ifndef iOS6Later
#define iOS6Later (SystemVersion >= 6)
#endif
#ifndef iOS7Later
#define iOS7Later (SystemVersion >= 7)
#endif
#ifndef iOS8Later
#define iOS8Later (SystemVersion >= 8)
#endif
#ifndef iOS9Later
#define iOS9Later (SystemVersion >= 9)
#endif

#pragma mark - 屏幕size
/*屏幕size*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define SizeWidth(W) (W *CGRectGetWidth([[UIScreen mainScreen] bounds])/320)
#define SizeHeight(H) (H *(ScreenHeight)/568)

#pragma mark - NotificationName


#pragma mark - EdgeInsets
/*EdgeInsets*/
#define TOPBAR_BACKEDGE                         UIEdgeInsetsMake(0, -5, 0, 5)
#define TOPBAR_RIGHTEDGE                         UIEdgeInsetsMake(0, 10, 0, -10)

#pragma mark - Proj颜色
/*Proj颜色*/
#define Sys_Blue [UIColor color16WithHexString:@"#5c75cc" alpha:1]
#define Sys_Nav_Bar_Color [UIColor color16WithHexString:@"#4471BC" alpha:1]
#define Sys_Nav_Title_Color k_FFFFFF//[UIColor color16WithHexString:@"#FFFFFF" alpha:1]

#define USERID [[MSUserCenterManager sharedMSUserCenterManager] getUserID]
#define USERENTITY [MSUserCenterManager getUserEntityFromeDB:[NSString stringWithFormat:@"uid = %@",USERID]]
/* ------------------------------- 标准颜色 在这里添加 ----------------------------------------*/

#define k_999999 [UIColor color16WithHexString:@"#999999" alpha:1]
#define k_5080D8 [UIColor color16WithHexString:@"#5080D8" alpha:1]
#define k_3C3C3C [UIColor color16WithHexString:@"#3C3C3C" alpha:1]
#define k_9596AB [UIColor color16WithHexString:@"#9596AB" alpha:1]
#define k_D0402D [UIColor color16WithHexString:@"#D0402D" alpha:1]
#define k_17B03E [UIColor color16WithHexString:@"#17B03E" alpha:1]
#define k_E5E5E5 [UIColor color16WithHexString:@"#E5E5E5" alpha:1]
#define k_636363 [UIColor color16WithHexString:@"#636363" alpha:1]
#define k_F4F5F9 [UIColor color16WithHexString:@"#F4F5F9" alpha:1]
#define k_D1D6E0 [UIColor color16WithHexString:@"#D1D6E0" alpha:1]
#define k_9596AB [UIColor color16WithHexString:@"#9596AB" alpha:1]
#define k_111D37 [UIColor color16WithHexString:@"#111D37" alpha:1]
#define k_4471BC [UIColor color16WithHexString:@"#4471BC" alpha:1]
#define k_4689FA [UIColor color16WithHexString:@"#4689FA " alpha:1]
#define k_3A4455 [UIColor color16WithHexString:@"#3A4455 " alpha:1]
#define k_333333 [UIColor color16WithHexString:@"#333333" alpha:1]
#define k_EFEFF4 [UIColor color16WithHexString:@"#EFEFF4" alpha:1]
#define k_5080D8 [UIColor color16WithHexString:@"#5080D8" alpha:1]
#define k_D3D3D3 [UIColor color16WithHexString:@"#D3D3D3" alpha:1]
#define k_3C424A [UIColor color16WithHexString:@"#3C424A" alpha:1]
#define k_EFEFF4 [UIColor color16WithHexString:@"#EFEFF4" alpha:1]
#define k_292929 [UIColor color16WithHexString:@"#292929" alpha:1]
#define k_BDBDBD [UIColor color16WithHexString:@"#BDBDBD" alpha:1]
#define k_A0A0A0 [UIColor color16WithHexString:@"#A0A0A0" alpha:1]
#define k_EFEFF4 [UIColor color16WithHexString:@"#EFEFF4" alpha:1]

#define k_DCDCDC [UIColor color16WithHexString:@"#DCDCDC" alpha:1]
#define k_2A2A2A [UIColor color16WithHexString:@"#2A2A2A" alpha:1]
#define k_F4F4F4 [UIColor color16WithHexString:@"#F4F4F4" alpha:1]
#define k_666666 [UIColor color16WithHexString:@"#666666" alpha:1]
#define k_FFFFFF [UIColor color16WithHexString:@"#FFFFFF" alpha:1]
#define k_000000 [UIColor color16WithHexString:@"#000000" alpha:1]
#define k_FF9DB0 [UIColor color16WithHexString:@"#FF9DB0" alpha:1] 
#define k_B5B5B5 [UIColor color16WithHexString:@"#B5B5B5" alpha:1]
#define k_FFD8D8 [UIColor color16WithHexString:@"#FFD8D8" alpha:1]
#define k_FFAA33 [UIColor color16WithHexString:@"#FFAA33" alpha:0.15]
#define k_FF2626 [UIColor color16WithHexString:@"#FF2626" alpha:1]
#define k_59D174 [UIColor color16WithHexString:@"#59D174" alpha:1]
#define k_67A7F2 [UIColor color16WithHexString:@"#67A7F2" alpha:1]
#define k_FF524D [UIColor color16WithHexString:@"#FF524D" alpha:1]
#define k_5376A0 [UIColor color16WithHexString:@"#5376A0" alpha:1]
#define k_FF9DB0 [UIColor color16WithHexString:@"#FF9DB0" alpha:1]

#define k_FF9DB0 [UIColor color16WithHexString:@"#FF9DB0" alpha:1]
#define k_FF5D7C [UIColor color16WithHexString:@"#FF5D7C" alpha:0.65]
#define k_000000_035 [UIColor color16WithHexString:@"#000000" alpha:0.35]
#define k_5AC83D [UIColor color16WithHexString:@"#5AC83D" alpha:1]
#define k_FAFAFA [UIColor color16WithHexString:@"#FAFAFA" alpha:1]
#define K_FF80AE [UIColor color16WithHexString:@"#FF80AE" alpha:1]
#define k_FDFDFD [UIColor color16WithHexString:@"#FDFDFD" alpha:1]

//#define k_FAFAFA [UIColor color16WithHexString:@"#FAFAFA" alpha:1]
/* ----------------------------------- 标准颜色 在这里添加 -----------------------------------------*/

//QQ 个推 微博 微信
#pragma mark - 第三方Key

#ifdef Distribution
    /*网络BaseUrl*/
    #define API_H5Url @"http://www.hidida.com"
    #define API_Base @"https://api.hidida.com"
    /*阿里百川feedback AppKey*/
    #define AliBaiChuan_FeedBackAppKey @"24567589"
    #define AliBaiChuan_FeedBackAppSecret @"5b6b4a690370c79774a7fa5dc1941cd5"
    #define AliBaiChuan_mmPid @"mm_24440483_0_0"
    /*UMeng AppKey*/
    #define YOUMENG_APPKEY @"58bd02d076661304ec001add"
    /*UMeng Channel*/
    #define UMENG_CHANNEL @"AppStore"
    /*QQ*/
    #define QQ_APPID @"1105943573"
    /*微信*/
    #define WECHAT_APPID @"wxc550b2d0dc9df39e"
    #define WECHAT_APPSECRET @"f0fe0ae4ca5b10c947c96fca9b52de6e"
    /*微博*/
    #define WEIBO_APPKEY @"857997971"
    #define WEIBO_APPSECRET @"72c9dd08c149d7a512ecb51dde205227"
    /*AppStore*/
    #define APPSTORE_APPID @"1211119245"
    /*个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret*/
    #define kGtAppId           @"VYWfkrlKtc84gOJ6az3Wp9"
    #define kGtAppKey          @"PRfcirW0Ym8VWyocPwDf66"
    #define kGtAppSecret       @"VYdKXTyUXGAntZrQ8QVbv"
#else
    /*网络BaseUrl*/
    #define API_H5Url @"http://www.hidida.com"
    #define API_Base @"https://api.caigeqiua.cn"
    /*阿里百川feedback AppKey*/
    #define AliBaiChuan_FeedBackAppKey @"24567589"
    #define AliBaiChuan_FeedBackAppSecret @"5b6b4a690370c79774a7fa5dc1941cd5"
    #define AliBaiChuan_mmPid @"mm_24440483_0_0"

    /*UMeng AppKey*/
    #define YOUMENG_APPKEY @"58bd02d076661304ec001add"
    /*UMeng Channel*/
    #define UMENG_CHANNEL @"AppStore"
    /*QQ*/
    #define QQ_APPID @"1105943573"
    /*微信*/
    #define WECHAT_APPID @"wxc550b2d0dc9df39e"
    #define WECHAT_APPSECRET @"f0fe0ae4ca5b10c947c96fca9b52de6e"
    /*微博*/
    #define WEIBO_APPKEY @"857997971"
    #define WEIBO_APPSECRET @"72c9dd08c149d7a512ecb51dde205227"
    /*AppStore*/
    #define APPSTORE_APPID @"1211119245"
    /*个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret*/
    #define kGtAppId           @"VYWfkrlKtc84gOJ6az3Wp9"
    #define kGtAppKey          @"PRfcirW0Ym8VWyocPwDf66"
    #define kGtAppSecret       @"VYdKXTyUXGAntZrQ8QVbv"


#endif

#pragma mark - Local Config Cache
/*Local Config Cache*/
#define Config_Cache_Folder @"ConfigCache"

#define Proj_Cache_Folder @"ProjCache"

#pragma mark - APPStore Link
/**/
#define APPStore_Link @"https://itunes.apple.com/cn/app/id1211119245?mt=8"

#define ALIMServiceID @"ALIMServiceID"
#pragma mark - IOS today widget



#pragma mark - IOS ALIYUN DEMO
#define kQPResourceHostUrl @"https://m.api.qupaicloud.com"
#define BundleID [[NSBundle mainBundle] bundleIdentifier]


#endif /* ConstantConfig_h */
