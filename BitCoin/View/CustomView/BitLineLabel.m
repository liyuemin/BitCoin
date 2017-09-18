//
//  BitLineLabel.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/18.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitLineLabel.h"

@implementation BitLineLabel

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGSize fontSize =[self.text sizeWithFont:self.font
//                                    forWidth:self.frame.size.width
//                               lineBreakMode:NSLineBreakByTruncatingTail];
    
    CGSize fontSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    CGContextSetStrokeColorWithColor(ctx, self.textColor.CGColor);
    CGContextSetLineWidth(ctx, 0.6f);
    //起点坐标
    CGPoint leftPoint = CGPointMake(0,
                                    self.frame.size.height/2);
    CGPoint rightPoint = CGPointMake(fontSize.width,
                                     self.frame.size.height/2);
    CGContextMoveToPoint(ctx, leftPoint.x, leftPoint.y);
    CGContextAddLineToPoint(ctx, rightPoint.x, rightPoint.y);
    CGContextStrokePath(ctx);
}

@end
