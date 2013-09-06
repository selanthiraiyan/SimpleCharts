//
//  LineChart.m
//  SimpleCharts
//
//  Created by Sharma Elanthiraiyan on 9/6/13.
//  Copyright (c) 2013 Sharma Elanthiraiyan. All rights reserved.
//

#define PADDING_TO_DRAW_X_AXIS_TEXT self.bounds.size.height * .1
#define PADDING_TO_DRAW_Y_AXIS_TEXT self.bounds.size.width * .1

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
    CGContextClipToRect(context, [self getActualRectToDrawChart]);
    for (int i = 0; i < [self.lineChartPoints count]; i++) {
        LineChartPoint *pt = [self.lineChartPoints objectAtIndex:i];

        CGPoint pointToDraw = CGPointMake([self getRelativeX:pt.position.x], [self getRelativeY:pt.position.y]);
        NSString *xAxisText = [NSString stringWithFormat:@"%f", pointToDraw.x];
        NSString *yAxisText = [NSString stringWithFormat:@"%f", pointToDraw.y];
        
//        [xAxisText drawAtPoint:CGPointMake(pointToDraw.x, self.bounds.size.height - PADDING_TO_DRAW_X_AXIS_TEXT) withFont:[UIFont fontWithName:@"Helvetica" size:10]];
//        [yAxisText drawAtPoint:CGPointMake(self.bounds.size.width - PADDING_TO_DRAW_Y_AXIS_TEXT, pointToDraw.y) withFont:[UIFont fontWithName:@"Helvetica" size:10]];
        if (i == 0) {
            CGContextMoveToPoint(context, pointToDraw.x, pointToDraw.y);
        }
        else {
            CGContextAddLineToPoint(context, pointToDraw.x, pointToDraw.y);
        }
        
        NSLog(@"plotted %@ for point %@", NSStringFromCGPoint(pointToDraw), NSStringFromCGPoint(pt.position));
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

- (CGFloat)getRelativeX:(CGFloat)actualX
{
    return (actualX / [self getMaxX]) * [self getActualRectToDrawChart].size.width;
}

- (CGFloat)getRelativeY:(CGFloat)actualY
{
    return (actualY / [self getMaxY]) * [self getActualRectToDrawChart].size.height;
}
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

- (CGFloat)getMinX
{
    CGFloat min = 0;
    for (LineChartPoint *pt in self.lineChartPoints) {
        if (pt.position.x < min) {
            min = pt.position.x;
        }
    }
    return min;
}

- (CGFloat)getMaxX
{
    CGFloat max = 0;
    for (LineChartPoint *pt in self.lineChartPoints) {
        if (pt.position.x > max) {
            max = pt.position.x;
        }
    }
    return max;
}

- (CGRect)getActualRectToDrawChart
{
    return CGRectMake(PADDING_TO_DRAW_X_AXIS_TEXT, PADDING_TO_DRAW_Y_AXIS_TEXT, (self.bounds.size.height - PADDING_TO_DRAW_X_AXIS_TEXT), (self.bounds.size.width - PADDING_TO_DRAW_X_AXIS_TEXT));
}

- (int)getNumberOfPointsToPlotInXAxis
{
    return 10;
}

@end
