//
//  BitLineChartView.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/2.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitLineChartView.h"
#import "NSDate+YYAdd.h"
#import "BitUpDateView.h"

#define BitUpDateViewTag  230
#define VerticalLabelTag 1000
#define HorizontalLabelTag 2000


@interface BitLineChartView()

@property (nonatomic ,assign)CGFloat bounceX;
@property (nonatomic ,assign)CGFloat bounceY;
@property (nonatomic ,assign)long maxPointX;
@property (nonatomic ,assign)long minPointX;
@property (nonatomic ,assign)CGFloat maxPointY;
@property (nonatomic ,assign)CGFloat minPointY;
@property (nonatomic ,strong)NSMutableArray *layers;
@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,strong)BitUpDateView *upView;
@property (nonatomic ,assign)BitLineTimeType currentTimeType;
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

- (void)setDataArray:(NSArray *)dataArray withLaster:(BitDetailsPriceEntity *)entity{
    if (dataArray.count == 0 || dataArray == nil){
        return;
    }
    _lasterPrice = entity;
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
    if (_upView){
        CGPoint upPoint = [self getLinePoint:entity];
         [_upView.label setText:[NSString stringWithFormat:@"%.2lf",[entity.btc_price floatValue]]];
         [_upView setCenter:CGPointMake(self.frame.size.width - 35, upPoint.y)];
    }
    [self clearChartData];
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
    CGContextAddLineToPoint(ctx,0,rect.size.height - _bounceY);
    CGContextStrokePath(ctx);

    
    CGFloat width = (self.frame.size.width - 80) / _horizontalCount;
    for(int i = 1 ; i < _horizontalCount + 1 ; i++){
        
        UIBezierPath *path = [[UIBezierPath alloc] init];
        path.lineWidth = 1.0;
        [self.lineXYColor setStroke];
        [self.lineXYColor setFill];
        [path moveToPoint:CGPointMake(i*width  , self.frame.size.height - 20)];
        [path addLineToPoint:CGPointMake(i*width, self.frame.size.height - 25)];
        [path stroke];
        
    }
    CGFloat height = (self.frame.size.height - 40)/ _verticalCount;
    for (int i = 0; i < _verticalCount ; i++){
        
        if (i< _verticalCount){
            UIBezierPath *path = [[UIBezierPath alloc] init];
            path.lineWidth = 1.0;
            [self.lineXYColor setStroke];
            [[UIColor greenColor]setFill];
            
            [path moveToPoint:CGPointMake(self.frame.size.width - 55, 20+i*height)];
            [path addLineToPoint:CGPointMake(0, 20+i*height)];
            [path closePath];
            [path stroke];
        }
    }
    if (self.dataArray.count > 0){
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor greenColor];
        [color set];
        [path moveToPoint:[self getLinePoint:[self.dataArray lastObject]]];
        for (NSInteger i = self.dataArray.count - 2 ; i >= 0  ; i--){
            [path addLineToPoint:[self getLinePoint:[self.dataArray objectAtIndex:i]]];
        }
        
        if (!self.lasterPrice){
            CGPoint onePoint = [self getLinePoint:[self.dataArray objectAtIndex:0]];
            CGPoint point = CGPointMake(self.frame.size.width - 60, onePoint.y);
            [path addLineToPoint:point];
        }else {
            CGPoint lasterPoint = [self getLinePoint:self.lasterPrice];
            CGPoint point = CGPointMake(self.frame.size.width - 60, lasterPoint.y);
            [path addLineToPoint:point];
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
    long lTimeValue = labs(_maxPointX - _minPointX) / _horizontalCount ;
    if (self.lasterPrice){
        long currentTimer = [self.lasterPrice.create_time longLongValue];
        if (currentTimer - _maxPointX >= lTimeValue){
            [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj isKindOfClass:[BitUpDateView class]]){
                    [obj removeFromSuperview];
                }
            }];
            if (self.dataArray.count > 0 ){
                [self creatVerticalLabel];
                [self creatHorizontalLabel];
            }

        }
    }
    if (self.dataArray.count > 0 && _currentTimeType != self.timeType){
        [self creatVerticalLabel];
        [self creatHorizontalLabel];
        _currentTimeType = self.timeType;
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
        UILabel *label = [self viewWithTag:VerticalLabelTag + i];
        if (!label){
        
            label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 50,20 +i*height - height/2, 50, height)];
            [label setTag:VerticalLabelTag + i];
            [label setTextColor:self.verticalTextColor];
            [label setFont:SYS_FONT(9)];
            [self addSubview:label];

        }
        [label setText:[NSString stringWithFormat:@"%.2lf",_maxPointY - i*verticalValue]];
    }
    if (!_upView){
        _upView = [[BitUpDateView alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 0, 50, 15)];
        [self addSubview:_upView];
        [_upView setTag:BitUpDateViewTag];
        BitDetailsPriceEntity *data = [self.dataArray objectAtIndex:0];
        [_upView.label setText:[NSString stringWithFormat:@"%.2lf",[data.btc_price floatValue]]];
        CGPoint upPoint = [self getLinePoint:data];
        [_upView setCenter:CGPointMake(self.frame.size.width - 35, upPoint.y)];
    }
}

- (void)creatHorizontalLabel{
    
    CGFloat width = (self.frame.size.width - 80) / _horizontalCount;
    
    
    long lTimeValue = labs(_maxPointX - _minPointX) / _horizontalCount ;
    
    for(int i = 1 ; i < _horizontalCount+1   ; i++){
        UILabel *label =  [self viewWithTag:HorizontalLabelTag + i];
        if (!label){
          label =  [[UILabel alloc] initWithFrame:CGRectMake(width *i - width/2, self.frame.size.height - 20, width, 20)];
            [label setTag:HorizontalLabelTag + i];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:self.horizontalTextColor];
            [label setFont:SYS_FONT(9)];
            [self addSubview:label];
        }
        long time = _minPointX + lTimeValue * i;
        NSDate *dateValue = [NSDate dateWithTimeIntervalSince1970:time];
        if (self.timeType == BitLineTimeTypeMinutes){
            
          [label setText:[NSString stringWithFormat:@"%ld:%@",[dateValue hour],[self getDoubleIntSring:[dateValue minute]]]];
        } else if (self.timeType == BitLineTimeTypeHours){
           [label setText:[NSString stringWithFormat:@"%ld月%ld日%ld时",[dateValue month],[dateValue day],[dateValue hour]]];
        }else if (self.timeType == BitLineTimeTypeDays){
           [label setText:[NSString stringWithFormat:@"%ld月%ld日",[dateValue month],[dateValue day]]];
        }else if (self.timeType == BitLineTimeTypeMonth){
           [label setText:[NSString stringWithFormat:@"%ld年%ld月",[dateValue year],[dateValue month]]];
        }
         if (i == _horizontalCount){
            NSLog(@"最后一个lable的中心店%@",NSStringFromCGPoint(label.center));
        }
    }
}




- (CGPoint)getLinePoint:(BitDetailsPriceEntity *)pointData {
    CGFloat timeX = [pointData.create_time longLongValue];
    CGFloat pointX = ((timeX - _minPointX)/(float)(_maxPointX - _minPointX))*(self.frame.size.width - 80);
    CGFloat priceY = [pointData.btc_price floatValue];
    if (priceY >= _maxPointY){
        priceY =  _maxPointY;
    }
    CGFloat pointY =(self.frame.size.height - 40) - ((priceY - _minPointY)/(_maxPointY - _minPointY) *(self.frame.size.height - 40)) + 20;
    NSLog(@"数据---%@ --- x轴%lf---y轴%lf ---- %lf",[pointData mj_keyValues],pointX,pointY,self.frame.size.width);
    return CGPointMake(pointX, pointY);
}

- (CGFloat)getLineX:(BitDetailsPriceEntity *)pointData{
    CGFloat timeX = [pointData.create_time floatValue];
    CGFloat pointX =  (_maxPointX - timeX)/(_maxPointX - _minPointX) *(self.frame.size.width - 80);
    
    return pointX;
    
}

- (CGFloat)getLineY:(BitDetailsPriceEntity *)pointData{
    CGFloat priceY = [pointData.btc_price floatValue];
    
    CGFloat pointY = (priceY -_minPointY)/fabs(_maxPointY - _minPointY) *(self.frame.size.height - 40);
    return pointY;
}

- (NSMutableArray *)layers {
    if (!_layers){
        _layers = [[NSMutableArray alloc] init];
    }
    return _layers;
}

- (NSString *)getDoubleIntSring:(NSInteger )terger{
    if (terger >= 10){
        return [NSString stringWithFormat:@"%ld",terger];
    }else {
        return [NSString stringWithFormat:@"0%ld",terger];
    }
}



@end
