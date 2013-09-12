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
#import "LineChartPoint_Private.h"

@implementation LineChart

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

- (void)reloadData
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //Drawing Y Axis
    CGContextRef context = UIGraphicsGetCurrentContext();
    draw1PxStroke(context, CGPointMake(CGRectGetMinX([self getActualRectToDrawChart]), CGRectGetMinY([self getActualRectToDrawChart])), CGPointMake(CGRectGetMinX([self getActualRectToDrawChart]), CGRectGetMaxY([self getActualRectToDrawChart])), [UIColor blackColor].CGColor);
    
    
    //Drawing X Axis
    draw1PxStroke(context, CGPointMake(CGRectGetMinX([self getActualRectToDrawChart]), CGRectGetMaxY([self getActualRectToDrawChart])), CGPointMake(CGRectGetMaxX([self getActualRectToDrawChart]), CGRectGetMaxY([self getActualRectToDrawChart])), [UIColor blackColor].CGColor);
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:10];

    for (float i = [self getMinY]; i < [self getMaxY]; i = i + ([self getMaxY] - [self getMinY]) / 5) {


        draw1PxStroke(context, CGPointMake(CGRectGetMinX([self getActualRectToDrawChart]), [self getRelativeY:i]), CGPointMake(CGRectGetMaxX([self getActualRectToDrawChart]), [self getRelativeY:i]), [UIColor grayColor].CGColor);
        
        NSString *yAxisText = [NSString stringWithFormat:@"%.f", i];
        [yAxisText drawInRect:CGRectMake(self.bounds.origin.x, [self getRelativeY:i], PADDING_TO_DRAW_Y_AXIS_TEXT, 10) withFont:font lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentCenter];

    }
    
    for (int i = 0; i < [self.lineChartPoints count]; i++) {
        LineChartPoint *pt = [self.lineChartPoints objectAtIndex:i];
        draw1PxStroke(context, CGPointMake([self getRelativeX:pt.position.x], CGRectGetMinY([self getActualRectToDrawChart])), CGPointMake([self getRelativeX:pt.position.x], CGRectGetMaxY([self getActualRectToDrawChart])), [UIColor grayColor].CGColor);
    }
    
    //Plotting the points
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 1.0);
    for (int i = 0; i < [self.lineChartPoints count]; i++) {
        LineChartPoint *pt = [self.lineChartPoints objectAtIndex:i];
        CGPoint pointToDraw = CGPointMake([self getRelativeX:pt.position.x], [self getRelativeY:pt.position.y]);
        [pt.xAxisText drawAtPoint:CGPointMake(pointToDraw.x, CGRectGetMaxY([self getActualRectToDrawChart])) withFont:font];

        if (i == 0) {
            CGContextMoveToPoint(context, pointToDraw.x, pointToDraw.y);
        }
        else {
            CGContextAddLineToPoint(context, pointToDraw.x, pointToDraw.y);
        }
    }
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);

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
    return CGRectGetMinX([self getActualRectToDrawChart]) + ((actualX / [self getMaxX]) * CGRectGetWidth([self getActualRectToDrawChart]));
}

- (CGFloat)getRelativeY:(CGFloat)actualY
{
    CGFloat relativeY = ((actualY / [self getMaxY]) * CGRectGetHeight([self getActualRectToDrawChart]));
    CGFloat invertedRelativeY = CGRectGetMaxY([self getActualRectToDrawChart]) - relativeY;
    return invertedRelativeY;
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
    CGRect rect = CGRectMake(PADDING_TO_DRAW_Y_AXIS_TEXT, PADDING_TO_DRAW_X_AXIS_TEXT, (self.bounds.size.width -  2 * PADDING_TO_DRAW_Y_AXIS_TEXT), (self.bounds.size.height - 2 * PADDING_TO_DRAW_X_AXIS_TEXT));
    return rect;
}

- (int)getNumberOfPointsToPlotInXAxis
{
    return 10;
}

@end
