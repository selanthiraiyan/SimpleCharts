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
    for (int i = 0; i <= 100; i = i + 10) {
        LineChartPoint *pt = [[LineChartPoint alloc]initWithPoint:CGPointMake(i, i)];
        [points addObject:pt];
    }
    lc.lineChartPoints = points;
    [self.view addSubview:lc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
