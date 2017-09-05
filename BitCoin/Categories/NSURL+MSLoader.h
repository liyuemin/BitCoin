//
//  NSURL+MSLoader.h
//  MSVideo
//
//  Created by mai on 17/7/19.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (MSLoader)
/**
 *  自定义scheme
 */
- (NSURL *)customSchemeURL;

/**
 *  还原scheme
 */
- (NSURL *)originalSchemeURL;
@end
