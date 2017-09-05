//
//  BitSearchResultCell.h
//  BitCoin
//
//  Created by yuemin li on 2017/8/31.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitSearchResultEntity.h"
@protocol BitSearchResultCellDelegate;
@interface BitSearchResultCell : UITableViewCell
@property (nonatomic ,unsafe_unretained)id <BitSearchResultCellDelegate>delegate;
- (void)setCellData:(BitSearchResultEntity *)entity withkey:(NSString *)key withfollow:(BOOL)follow;
@end

@protocol BitSearchResultCellDelegate <NSObject>
@optional
- (void)addFollowWithEntity:(BitSearchResultEntity *)entiy;

@end
