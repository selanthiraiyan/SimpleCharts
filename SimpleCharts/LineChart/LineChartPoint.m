//
//  LineChartPoint.m
//  SimpleCharts
//
//  Created by Sharma Elanthiraiyan on 9/6/13.
//  Copyright (c) 2013 Sharma Elanthiraiyan. All rights reserved.
//

#import "LineChartPoint.h"
#import "LineChartPoint_Private.h"
@interface LineChartPoint ()


@end

@implementation LineChartPoint
@synthesize position;
- (id)initWithPoint:(CGPoint)position1
{
    self = [super init];
    if (self) {
        position = position1;
        self.xAxisText = [NSString stringWithFormat:@"%.f", position1.x];
        self.yAxisText = [NSString stringWithFormat:@"%.f", position1.y];
       
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:10];
        self.xAxisFont = font;
        self.xAxisFontColor = [UIColor redColor];
        self.yAxisFont = font;
        self.yAxisFontColor = [UIColor greenColor];

    }
    return self;
}

@end
