//
//  ZHGridView.m
//  ZongHeng
//
//  Created by 李贺 on 15/10/13.
//  Copyright (c) 2015年 李贺. All rights reserved.
//

#import "ZHGridView.h"
#import "UIColor+more.h"
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@implementation ZHGridView

@synthesize gridColor = _gridColor;
@synthesize gridSpacing = _gridSpacing;

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return self.callView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _gridColor = k_E5E5E5;
        _gridLineWidth = SINGLE_LINE_WIDTH;
        _gridSpacing = 30;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _gridColor = k_E5E5E5;
        _gridLineWidth = SINGLE_LINE_WIDTH;
        _gridSpacing = 30;
    }
    
    return self;
}

- (void)setGridColor:(UIColor *)gridColor
{
    _gridColor = gridColor;
    
    [self setNeedsDisplay];
}
- (void)setGridSpacing:(CGFloat)gridSpacing
{
    _gridSpacing = gridSpacing;
    
    [self setNeedsDisplay];
}
- (void)setGridLineWidth:(CGFloat)gridLineWidth
{
    _gridLineWidth = gridLineWidth;
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);

    CGFloat pixelAdjustOffset = 0;
    
    if (((int)(self.gridLineWidth * [UIScreen mainScreen].scale) + 1) % 2 == 0)
    {
        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    }
    
    if (self.gridViewType)
    {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, self.bounds.size.height);
    }
    else
    {
        CGFloat yPos = self.bounds.size.height - pixelAdjustOffset;
        CGContextMoveToPoint(context, 0, yPos);
        CGContextAddLineToPoint(context, self.bounds.size.width, yPos);
    }
    CGContextSetLineWidth(context, self.gridLineWidth);
    CGContextSetStrokeColorWithColor(context, self.gridColor.CGColor);
    CGContextStrokePath(context);
}

@end
