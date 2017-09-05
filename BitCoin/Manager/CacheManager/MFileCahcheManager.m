//
//  MFileCahcheManager.m
//  MaiMaiMai
//
//  Created by yuemin li on 16/10/14.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import "MFileCahcheManager.h"
#import "YYImageCache.h"
#import "YYDiskCache.h"
//#import "NSString+MSLoader.h"
#import "MSFileHandle.h"
@implementation MFileCahcheManager


SYNTHESIZE_SINGLETON_FOR_CLASS(MFileCahcheManager);

+ (NSString *)validFileName:(NSString *)fileName
{
    if ([fileName containsString:@"/"])
    {
        fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    }
    return fileName;
}

+ (BOOL)isFileExisted:(NSString *)fileName
{
    if (kisNilString(fileName))
    {
        NSLog(@"filename is nil!");
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [self getFilePath:fileName];
    
    if(![fileManager fileExistsAtPath:filePath])
    {
        return NO;
    }
    
    return YES;
}

+ (BOOL)createDirectoryAtPath:(NSString *)filePath
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[array objectAtIndex:0] stringByAppendingPathComponent:filePath];
    NSLog(@"lipeiranfile-----%@", path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path])
    {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        return YES;
    }
    
    return NO;
}

+ (BOOL)copyProjFileName:(NSString *)fileName fileType:(NSString *)fileType toPath:(NSString *)targetPath
{
    if (kisNilString(fileName))
    {
        NSLog(@"filename is nil!");
        return NO;
    }
    if ([fileName containsString:@"/"])
    {
        fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    if (filePath)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        [fileManager copyItemAtPath:filePath toPath:targetPath error:&error];
        if (error)
        {
            NSLog(@"%@",error.description);
            return NO;
        }
    }
    else
    {
        return NO;
    }
    
    return YES;
}

+ (NSString *)getFilePath:(NSString *)fileName
{
    if (kisNilString(fileName))
    {
        NSLog(@"filename is nil!");
        return nil;
    }
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[array objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    return path;
}

- (BOOL)cachWithURLDataFile:(id)jsonData withPath:(NSString *)filePath WithFileName:(NSString *)fileName
{
    @synchronized (self)
    {
        if (kisNilString(fileName))
        {
            NSLog(@"filename is nil!");
            return NO;
        }
        if ([fileName containsString:@"/"])
        {
            fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        }
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *foldPath=[[paths objectAtIndex:0]stringByAppendingPathComponent:filePath];
        NSString *Json_path=[foldPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",fileName]];
        
        if (![jsonData isKindOfClass:[NSData class]])
        {
            NSMutableData *writeData = [[NSMutableData alloc] init];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:writeData];
            [archiver encodeObject:jsonData forKey:MFileDecodeKey];
            [archiver finishEncoding];
            
            return [writeData writeToFile:Json_path atomically:YES];
        }
        return [jsonData writeToFile:Json_path atomically:YES];
    }
}

- (id)readDataWithFilePath:(NSString *)filePath withFileName:(NSString *)fileName
{
    @synchronized (self)
    {
        if (kisNilString(fileName))
        {
            NSLog(@"filename is nil!");
            return nil;
        }
        if ([fileName containsString:@"/"])
        {
            fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        }
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *foldPath=[[paths objectAtIndex:0]stringByAppendingPathComponent:filePath];
        NSString *Json_path=[foldPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",fileName]];
        NSData *data=[NSData dataWithContentsOfFile:Json_path];
        if (!data)
        {
            return nil;
        }
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDictionary *myDictionary = nil;
        
        //        return nil;//lipeirannil
        myDictionary = [unarchiver decodeObjectForKey:MFileDecodeKey];
        
        [unarchiver finishDecoding];
        
        return myDictionary;
    }
}

- (id)readJsonDataWithProjFileName:(NSString *)fileName
{
    @synchronized (self)
    {
        if (kisNilString(fileName))
        {
            NSLog(@"filename is nil!");
            return nil;
        }
        if ([fileName containsString:@"/"])
        {
            fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        }
        NSBundle *bundle=[NSBundle mainBundle];
        NSString *path=[bundle pathForResource:fileName ofType:@"json"];
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDictionary *myDictionary = [unarchiver decodeObjectForKey:MFileDecodeKey];
        [unarchiver finishDecoding];
        
        return myDictionary;
    }
}

- (void)cleanYYWebImageCache
{
    YYImageCache *cache = [YYImageCache sharedCache];
    [cache.diskCache removeAllObjects];
   
}

- (void)cleanImageCacheAndvideoCache
{
    YYImageCache *cache = [YYImageCache sharedCache];
    [cache.diskCache removeAllObjects];
    [MSFileHandle clearCache];
}

- (CGFloat)yyWebImageCacheSize
{
    YYImageCache *cache = [YYImageCache sharedCache];
    float sizeString = [self folderSizeAtPath:cache.diskCache.path];
    NSLog(@"size string is:%f",sizeString);
    return sizeString;
//    [NSString stringWithFormat:@"%.1fM",sizeString<0.2?0:sizeString];
}

-(CGFloat)videoCacheSize
{
     float sizeString = [self folderSizeAtPath:[NSString cacheFolderPath]];
    return sizeString;
//    [NSString stringWithFormat:@"%.1fM",sizeString<0.2?0:sizeString];
}

#pragma mark - 清除path文件夹下缓存大小
- (BOOL)clearCacheWithFilePath:(NSString *)path
{
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSString *filePath = nil;
    NSError *error = nil;
    for (NSString *subPath in subPathArr)
    {
        filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }
    }
    return YES;
}

//#pragma mark - 获取path路径下文件夹大小
//- (double)getCacheSizeWithFilePath:(NSString *)path
//{
//    // 获取“path”文件夹下的所有文件
//    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
//    
//    NSString *filePath  = nil;
//    NSInteger totleSize = 0;
//    
//    for (NSString *subPath in subPathArr){
//        
//        // 1. 拼接每一个文件的全路径
//        filePath =[path stringByAppendingPathComponent:subPath];
//        // 2. 是否是文件夹，默认不是
//        BOOL isDirectory = NO;
//        // 3. 判断文件是否存在
//        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
//        
//        // 4. 以上判断目的是忽略不需要计算的文件
//        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
//            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
//            continue;
//        }
//        
//        // 5. 指定路径，获取这个路径的属性
//        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
//        /**
//         attributesOfItemAtPath: 文件夹路径
//         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
//         */
//        
//        // 6. 获取每一个文件的大小
//        NSInteger size = [dict[@"NSFileSize"] integerValue];
//        
//        // 7. 计算总大小
//        totleSize += size;
//    }
//    return totleSize/1000.00f;
//}

//单个文件的大小
- (long long)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
- (float)folderSizeAtPath:(NSString*)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

@end

