//
//  LineChart.m
//  SimpleCharts
//
//  Created by Sharma Elanthiraiyan on 9/6/13.
//  Copyright (c) 2013 Sharma Elanthiraiyan. All rights reserved.
//



#import "LineChart.h"

@implementation LineChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)reloadData
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGFloat minY = [self getMinY];
    CGFloat maxY = [self getMaxY];
    
    
    NSLog(@"min and max are %f %f", minY, maxY);
    
#define PADDING_TO_DRAW_X_AXIS_TEXT self.bounds.size.height * .1
#define PADDING_TO_DRAW_Y_AXIS_TEXT self.bounds.size.width * .1
    //Drawing Y Axis
    CGContextRef context = UIGraphicsGetCurrentContext();
    draw1PxStroke(context, CGPointMake(PADDING_TO_DRAW_Y_AXIS_TEXT, 0), CGPointMake(PADDING_TO_DRAW_Y_AXIS_TEXT, self.bounds.size.height - PADDING_TO_DRAW_X_AXIS_TEXT), [UIColor blackColor].CGColor);
    
    
    //Drawing X Axis
    draw1PxStroke(context, CGPointMake(PADDING_TO_DRAW_Y_AXIS_TEXT, self.bounds.size.height - PADDING_TO_DRAW_X_AXIS_TEXT), CGPointMake(self.bounds.size.width, self.bounds.size.height - PADDING_TO_DRAW_X_AXIS_TEXT), [UIColor blackColor].CGColor);
    
    
    //Plotting the points
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    for (int i = 0; i < [self.lineChartPoints count]; i++) {
        LineChartPoint *pt = [self.lineChartPoints objectAtIndex:i];
        if (i == 0) {
            CGContextMoveToPoint(context, pt.position.x, pt.position.y);
        }
        else {
            CGContextAddLineToPoint(context, pt.position.x, pt.position.y);
        }
    }
    
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
}

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color)
{
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

#pragma mark Helper methods

- (CGFloat)getMinY
{
    CGFloat min = 0;
    for (LineChartPoint *pt in self.lineChartPoints) {
        if (pt.position.y < min) {
            min = pt.position.y;
        }
    }
    return min;
}

- (CGFloat)getMaxY
{
    CGFloat max = 0;
    for (LineChartPoint *pt in self.lineChartPoints) {
        if (pt.position.y > max) {
            max = pt.position.y;
        }
    }
    return max;
}

- (int)getNumberOfPointsToPlotInXAxis
{
    return 10;
}

@end
