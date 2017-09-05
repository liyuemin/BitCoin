//
//  BitLineChartView.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/2.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitLineChartView.h"
#import "NSDate+YYAdd.h"
@interface BitLineChartView()

@property (nonatomic ,assign)CGFloat bounceX;
@property (nonatomic ,assign)CGFloat bounceY;
@property (nonatomic ,assign)long maxPointX;
@property (nonatomic ,assign)long minPointX;
@property (nonatomic ,assign)CGFloat maxPointY;
@property (nonatomic ,assign)CGFloat minPointY;
@property (nonatomic ,strong)NSMutableArray *layers;

@end

@implementation BitLineChartView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setBackgroundColor:k_111D37];
        _bounceX = frame.size.width - 60;
        _bounceY = 60;
        self.lineColor = [UIColor whiteColor];
        self.lineXYColor = [UIColor whiteColor];
        self.verticalTextColor = [UIColor whiteColor];
        self.horizontalTextColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    if (dataArray.count == 0 || dataArray == nil){
        return;
    }
    _dataArray = dataArray;
    NSArray *resultArray = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber *number1 = [NSNumber numberWithFloat:[[(NSDictionary *)obj1 valueForKey:@"btc_price"] floatValue]];
        NSNumber *number2 = [NSNumber numberWithFloat:[[(NSDictionary *)obj2 valueForKey:@"btc_price"] floatValue]];
        
        NSComparisonResult result = [number1 compare:number2];
        return result == NSOrderedDescending; // 升序
    }];
    _minPointY = [[[resultArray objectAtIndex:0] valueForKey:@"btc_price"]floatValue];
    _maxPointY = [[[resultArray lastObject] valueForKey:@"btc_price"] floatValue];
    
    
    long dmaxTime = [[[self.dataArray objectAtIndex:0] valueForKey:@"create_time"] longLongValue];
    long dmixTime = [[[self.dataArray lastObject] valueForKey:@"create_time"] longLongValue];
    
    if (dmaxTime >= dmixTime){
        _maxPointX = dmaxTime;
        _minPointX = dmixTime;
    } else {
        _maxPointX =  dmixTime;
        _minPointX = dmaxTime;
    }

    [self setNeedsDisplay];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    _bounceX = rect.size.width - 60;
    _bounceY = 20;
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetRGBStrokeColor(context, 58/255.0, 68/255.0, 85/255.0, 1);
//    CGContextMoveToPoint(context, _bounceX, _bounceY);
//    CGContextAddLineToPoint(context, _bounceX, rect.size.height - _bounceY);
//    CGContextAddLineToPoint(context,20,rect.size.height - _bounceY);
//    CGContextStrokePath(context);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(ctx);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetStrokeColorWithColor(ctx, self.lineXYColor.CGColor);
    
    CGContextMoveToPoint(ctx, _bounceX, _bounceY);
    CGContextAddLineToPoint(ctx, _bounceX, rect.size.height - _bounceY);
    CGContextAddLineToPoint(ctx,20,rect.size.height - _bounceY);
    CGContextStrokePath(ctx);

    
    CGFloat width = (self.frame.size.width - 60) / _horizontalCount;
    for(int i = 0 ; i < _horizontalCount ; i++){
        
        if (i>0 && i< _horizontalCount){
            CAShapeLayer *dashLayer = [CAShapeLayer layer];
            dashLayer.strokeColor = self.lineXYColor.CGColor;
            dashLayer.fillColor = [UIColor clearColor].CGColor;
            dashLayer.lineWidth = 1.0;
            
            UIBezierPath *path = [[UIBezierPath alloc] init];
            path.lineWidth = 1.0;
            [[UIColor blackColor]setStroke];
            [[UIColor greenColor]setFill];
            [path moveToPoint:CGPointMake(i*width , self.frame.size.height - 20)];
            [path addLineToPoint:CGPointMake(i*width, self.frame.size.height - 25)];
            [path stroke];
            dashLayer.path = path.CGPath;
            [self.layers addObject:dashLayer];
            [self.layer addSublayer:dashLayer];
        }
    }
    CGFloat height = (self.frame.size.height - 40)/ _verticalCount;
    for (int i = 0; i < _verticalCount ; i++){
        
        if (i< _verticalCount){
            CAShapeLayer *dashLayer = [CAShapeLayer layer];
            dashLayer.strokeColor = self.lineXYColor.CGColor;
            dashLayer.fillColor = [UIColor clearColor].CGColor;
            dashLayer.lineWidth = 1.0;
            
            UIBezierPath *path = [[UIBezierPath alloc] init];
            path.lineWidth = 1.0;
            [[UIColor blackColor]setStroke];
            [[UIColor greenColor]setFill];
            
            [path moveToPoint:CGPointMake(self.frame.size.width - 55, 20+i*height)];
            [path addLineToPoint:CGPointMake(20, 20+i*height)];
            [path closePath];
            [path stroke];
            dashLayer.path = path.CGPath;
            [self.layers addObject:dashLayer];
            [self.layer addSublayer:dashLayer];
        }
    }
    if (self.dataArray.count > 0){
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor greenColor];
        [color set];
        [path moveToPoint:[self getLinePoint:[self.dataArray lastObject]]];
        for (NSInteger i = self.dataArray.count - 2 ; i > 0  ; i--){
            [path addLineToPoint:[self getLinePoint:[self.dataArray objectAtIndex:i]]];
        }
        
        CAShapeLayer *lineChartLayer = [CAShapeLayer layer];
        lineChartLayer.path = path.CGPath;
        lineChartLayer.strokeColor = self.lineColor.CGColor;
        lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        lineChartLayer.lineWidth = 2;
        lineChartLayer.lineCap = kCALineCapRound;
        lineChartLayer.lineJoin = kCALineJoinRound;
        [self.layers addObject:lineChartLayer];
        [self.layer addSublayer:lineChartLayer];
    }
}

- (void)layoutSubviews{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];

    if (self.dataArray.count > 0){
        [self creatVerticalLabel];
        [self creatHorizontalLabel];
    }
}

- (void)clearChartData
{
    for (CAShapeLayer *layer in self.layers) {
        [layer removeFromSuperlayer];
    }

    [self.layers removeAllObjects];
}




- (void)creatVerticalLabel{
    CGFloat height = (self.frame.size.height - 40)/ _verticalCount ;
    
    
    
    CGFloat verticalValue = fabs(_maxPointY - _minPointY) / (_verticalCount + 1) ;
    
    for (int i = 0; i < _verticalCount ; i++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 50,20 +i*height - height/2, 50, height)];
        [label setText:[NSString stringWithFormat:@"%.2lf",_maxPointY - i*verticalValue]];
        [label setTextColor:self.verticalTextColor];
        [label setFont:SYS_FONT(9)];
        [self addSubview:label];
    }
}

- (void)creatHorizontalLabel{
    
    CGFloat width = (self.frame.size.width - 60) / _horizontalCount;
    
    
    long lTimeValue = labs(_maxPointX - _minPointX) / _horizontalCount;
    
    for(int i = 0 ; i < _horizontalCount ; i++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*width + width/2, self.frame.size.height - 20, width, 20)];
        long time = _minPointX + lTimeValue * i;
        NSDate *dateValue = [NSDate dateWithTimeIntervalSince1970:time];
        if (self.timeType == BitLineTimeTypeMinutes){
            
          [label setText:[NSString stringWithFormat:@"%ld:%ld",[dateValue hour],[dateValue minute]]];
        } else if (self.timeType == BitLineTimeTypeHours){
           [label setText:[NSString stringWithFormat:@"%ld-%ld:%ld",[dateValue month],[dateValue day],[dateValue hour]]];
        }else if (self.timeType == BitLineTimeTypeDays){
           [label setText:[NSString stringWithFormat:@"%ld-%ld:%ld",[dateValue year],[dateValue month],[dateValue day]]];
        }else if (self.timeType == BitLineTimeTypeMonth){
           [label setText:[NSString stringWithFormat:@"%ld:%ld",[dateValue year],[dateValue month]]];
        }
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:self.horizontalTextColor];
        [label setFont:SYS_FONT(9)];
        [self addSubview:label];
    }
}




- (CGPoint)getLinePoint:(NSDictionary *)pointData {
    CGFloat timeX = [[pointData valueForKey:@"create_time"] floatValue];
    CGFloat pointX = 20 + (timeX - _minPointX)/(_maxPointX - _minPointX) *(self.frame.size.width - 80);
    CGFloat priceY = [[pointData valueForKey:@"btc_price"] floatValue];
    CGFloat pointY =(self.frame.size.height - 40) - ((priceY - _minPointY)/(_maxPointY - _minPointY) *(self.frame.size.height - 40)) + 20;
    
    return CGPointMake(pointX, pointY);
}

- (CGFloat)getLineX:(NSDictionary *)pointData{
    CGFloat timeX = [[pointData valueForKey:@"create_time"] floatValue];
    CGFloat pointX =  (_maxPointX - timeX)/(_maxPointX - _minPointX) *(self.frame.size.width - 60);
    
    return pointX;
    
}

- (CGFloat)getLineY:(NSDictionary *)pointData{
    CGFloat priceY = [[pointData valueForKey:@"btc_price"] floatValue];
    
    CGFloat pointY = (priceY -_minPointY)/fabs(_maxPointY - _minPointY) *(self.frame.size.height - 40);
    return pointY;
}

- (NSMutableArray *)layers {
    if (!_layers){
        _layers = [[NSMutableArray alloc] init];
    }
    return _layers;
}


@end
