//
//  NSString+MSLoader.m
//  MSVideo
//
//  Created by mai on 17/7/19.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "NSString+MSLoader.h"

@implementation NSString (MSLoader)
+ (NSString *)tempFilePath {
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"Video"];
}


+ (NSString *)cacheFolderPath {
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"VideoCaches"];
}

+ (NSString *)fileNameWithURL:(NSURL *)url {
    return [[url.path componentsSeparatedByString:@"/"] lastObject];
}
@end
