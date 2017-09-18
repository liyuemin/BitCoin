//
//  MFileCahcheManager.h
//  MaiMaiMai
//
//  Created by yuemin li on 16/10/14.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import <Foundation/Foundation.h>


#define MFileDecodeKey   @"MSVideo"

@interface MFileCahcheManager : NSObject

+ (instancetype)sharedMFileCahcheManager;

+ (NSString *)validFileName:(NSString *)fileName;

+ (BOOL)isFileExisted:(NSString *)fileName;

+ (BOOL)createDirectoryAtPath:(NSString *)filePath;

+ (BOOL)copyProjFileName:(NSString *)fileName fileType:(NSString *)fileType toPath:(NSString *)targetPath;

- (BOOL)cachWithURLDataFile:(id)jsonData withPath:(NSString *)filePath WithFileName:(NSString *)fileName;

- (id)readDataWithFilePath:(NSString *)filePath withFileName:(NSString *)fileName;

- (id)readJsonDataWithProjFileName:(NSString *)fileName;

- (void)cleanYYWebImageCache;

- (CGFloat )yyWebImageCacheSize;

-(CGFloat )videoCacheSize;
- (void)cleanImageCacheAndvideoCache;

@end
