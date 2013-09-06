//
//  ViewController.m
//  SimpleCharts
//
//  Created by Sharma Elanthiraiyan on 9/6/13.
//  Copyright (c) 2013 Sharma Elanthiraiyan. All rights reserved.
//

#import "ViewController.h"
#import "LineChart.h"
#import "LineChartPoint.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LineChart *lc = [[LineChart alloc]initWithFrame:CGRectInset(self.view.bounds, 40, 150)];
    NSMutableArray *points = [NSMutableArray array];
    
    LineChartPoint *pt0 = [[LineChartPoint alloc]initWithPoint:CGPointMake(0, 5)];
    [points addObject:pt0];
    
    LineChartPoint *pt = [[LineChartPoint alloc]initWithPoint:CGPointMake(10, 60)];
    [points addObject:pt];
    
    LineChartPoint *pt1 = [[LineChartPoint alloc]initWithPoint:CGPointMake(20, 20)];
    [points addObject:pt1];
    
    LineChartPoint *pt2 = [[LineChartPoint alloc]initWithPoint:CGPointMake(30, 120)];
    [points addObject:pt2];
    
    LineChartPoint *pt3 = [[LineChartPoint alloc]initWithPoint:CGPointMake(40, 50)];
    [points addObject:pt3];
    
    lc.lineChartPoints = points;
    [self.view addSubview:lc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
