//
//  NSString+MSLoader.h
//  MSVideo
//
//  Created by mai on 17/7/19.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MSLoader)
/**
 *  临时文件路径
 */
+ (NSString *)tempFilePath;

/**
 *  缓存文件夹路径
 */
+ (NSString *)cacheFolderPath;

/**
 *  获取网址中的文件名
 */
+ (NSString *)fileNameWithURL:(NSURL *)url;
@end
