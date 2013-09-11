//
//  ViewController.m
//  SimpleCharts
//
//  Created by Sharma Elanthiraiyan on 9/6/13.
//  Copyright (c) 2013 Sharma Elanthiraiyan. All rights reserved.
//

#import "ViewController.h"
#import "LineChartPoint.h"

@interface ViewController ()


@end

@implementation ViewController
@synthesize lc;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *points = [NSMutableArray array];
    
    LineChartPoint *pt0 = [[LineChartPoint alloc]initWithPoint:CGPointMake(0, 0)];
    [points addObject:pt0];
    
    LineChartPoint *pt = [[LineChartPoint alloc]initWithPoint:CGPointMake(10, 35)];
    [points addObject:pt];
    
    LineChartPoint *pt1 = [[LineChartPoint alloc]initWithPoint:CGPointMake(20, 10)];
    [points addObject:pt1];
    
    LineChartPoint *pt2 = [[LineChartPoint alloc]initWithPoint:CGPointMake(30, 70)];
    [points addObject:pt2];
    
    LineChartPoint *pt3 = [[LineChartPoint alloc]initWithPoint:CGPointMake(40, 20)];
    [points addObject:pt3];
    
    LineChartPoint *pt4 = [[LineChartPoint alloc]initWithPoint:CGPointMake(50, 0)];
    [points addObject:pt4];
    
    lc.lineChartPoints = points;
    [self.lc reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
