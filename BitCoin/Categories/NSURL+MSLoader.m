//
//  NSURL+MSLoader.m
//  MSVideo
//
//  Created by mai on 17/7/19.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "NSURL+MSLoader.h"

@implementation NSURL (MSLoader)
- (NSURL *)customSchemeURL {
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:NO];
    components.scheme = @"streaming";
    return [components URL];
}

- (NSURL *)originalSchemeURL {
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:NO];
    components.scheme = @"http";
    return [components URL];
}

@end
