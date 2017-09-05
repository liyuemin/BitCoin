//
//  MSAppSetManager.m
//  MSVideo
//
//  Created by mai on 17/7/14.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "MSAppSetManager.h"
#import "AppDelegate.h"
#define KEY_UDID_KEY @"com.maibo.tapai.udidkey"

@interface MSAppSetManager ()

@end

@implementation MSAppSetManager
@synthesize appId = _appId;
SYNTHESIZE_SINGLETON_FOR_CLASS(MSAppSetManager);


- (NSString *)getLoctionVersion {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
    return version;
}

- (void)alertUpVersoin:(NSDictionary *)param content:(UIViewController *)controller{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[param valueForKey:@"title"] message:[param valueForKey:@"body"] preferredStyle:(UIAlertControllerStyleAlert)];
    
    if ([[param valueForKey:@"force"] integerValue] == 1){
        UIAlertAction *refuseAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self openAppStroe];
            [self alertUpVersoin:param content:controller];
        }];
        [alertController addAction:refuseAction];
        [controller presentViewController:alertController animated:YES completion:nil];
        
    } else {
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        
        NSInteger theDays = interval / (24 * 60 * 60);
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *update = [userDefaults valueForKey:@"update"];
        BOOL alert = NO;
        if (update){
            if ([update isEqualToString:@"1"]){
                alert = YES;
            } else {
                NSString *uptime = [userDefaults valueForKey:@"updateTime"];
                if (theDays - [uptime intValue] >5 ){
                    alert = YES;
                } else {
                    alert = NO;
                }
            }
        } else {
            alert = YES;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (alert){
            UIAlertAction *refuseAction = [UIAlertAction actionWithTitle:@"升级" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                [userDefaults setObject:@"1" forKey:@"update"];
                [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"updateTime"];
                
                [self openAppStroe];
            }];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                [userDefaults setObject:@"0" forKey:@"update"];
                [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"updateTime"];
            }];
            [alertController addAction:refuseAction];
            [alertController addAction:okAction];
            
            [controller presentViewController:alertController animated:YES completion:nil];
        }
     });
    }
    
}

- (void)openAppStroe {
    NSString *str = [NSString stringWithFormat:
                     @"https://itunes.apple.com/cn/app/id%@?mt=8",
                     self.appId];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

+ (void)generateIdentifierStr
{
    if (![MSAppSetManager getUDID])
    {
        NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [MSAppSetManager saveUDID:udid];
    }
}

+ (void)saveUDID:(id)data
{
    [self saveKeyChain:data withKey:KEY_UDID_KEY];
}

+ (NSString *)getUDID
{
    return [self getKeyChainWithKey:KEY_UDID_KEY];
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}


+ (void)saveKeyChain:(id)data withKey:(NSString *)key
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+ (id)getKeyChainWithKey:(NSString *)key
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}





@end
