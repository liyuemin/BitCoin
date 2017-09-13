//
//  APIUrlManager.h
//  MaiMaiMai
//
//  Created by yuemin li on 16/10/13.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+AFNetWorkAdditions.h"

#pragma API 基本参数

/*----------------------------------------------------------------------------- */

extern NSString * const API_Back_URLParam;
extern NSString * const API_Back_ExtroInfo;
extern NSString * const API_Back_CachMd5;
extern NSString * const API_Back_NotNet;

extern NSString * const API_Back_URLCode;
extern NSString * const API_PostUserInfo_Code;
/*----------------------------------------------------------------------------- */

extern NSString * const API_H5_GoVideoDetail;

/*----------------------------------------------------------------------------- */


#pragma ------API 定义
extern NSString *const API_BitHomeList_Code;
extern NSString *const API_BitClassInfo_Code;
extern NSString *const API_BitDetail_Code;
extern NSString *const API_BitSerach_Code;
extern NSString *const API_BitSearchHot_Code;
extern NSString *const API_BitFollow_Code;
extern NSString *const API_BitANPSRegister_Code;
extern NSString *const API_BitMessage_Code;
extern NSString *const API_BitPrice_Code;
extern NSString *const API_BitUnFollow_Code;
extern NSString *const API_BitLaster_Code;
extern NSString *const API_BitStart_Code;

#pragma mark - 登录
extern NSString *const API_Login_Code;
extern NSString *const API_Mobile_Login_Code;

extern NSString *const API_HomeList_Code;




extern NSString *const API_Like_Code;
extern NSString *const API_IsLike_Code;
extern NSString *const API_Follow_Code;
extern NSString *const API_Follow_Check_Code;
extern NSString *const API_DeleteVideo_Code;
extern NSString *const API_VideoComment_Code;
extern NSString *const API_VideoSendComment_Code;
extern NSString *const API_VideoCommentCount_Code;

extern NSString *const API_User_Code;
extern NSString *const API_User_Icon_Code;
extern NSString * const API_User_LikeCount_Code;
extern NSString * const API_User_IssueCount_Codeo;
extern NSString * const API_User_IssueVideo_Codeo;
extern NSString * const API_User_likeVideo_Codeo;
extern NSString * const API_Openim_InfoCode_Code;
extern NSString * const API_Deviceboot_Code_Code;

extern NSString * const API_User_NoticeCount_Codeo;
extern NSString * const API_User_NoticeList_Codeo;
extern NSString * const API_User_Notice_Codeo;

extern NSString * const API_Video_request_Codeo;
extern NSString * const API_Image_request_Codeo;
extern NSString * const API_BgMusic_Codeo;
extern NSString * const API_BgMusics_Codeo;

/*----------------------------------------------------------------------------- */

@interface APIUrlManager : NSObject


+ (NSString *)getdefaultUrl:(NSDictionary *)backDic;
+ (NSString *)getParamUrlSring:(NSDictionary *)param;
+ (NSString *)getURLSign:(NSString *)url;
+ (NSString *)getHttpRequestUrl:(NSString *)url defaultUrl:(NSDictionary *)defauls Param:(NSDictionary *)param;
+ (NSDictionary *)getHeaderInfo;
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;
+ (NSString *)getSingKey;
@end
