//
//  LineChartPoint.m
//  SimpleCharts
//
//  Created by Sharma Elanthiraiyan on 9/6/13.
//  Copyright (c) 2013 Sharma Elanthiraiyan. All rights reserved.
//

#import "LineChartPoint.h"

@interface LineChartPoint ()



@end

@implementation LineChartPoint
@synthesize position;
- (id)initWithPoint:(CGPoint)position1
{
    self = [super init];
    if (self) {
        position = position1;
    }
    return self;
}

@end
