//
//  LineChart.h
//  SimpleCharts
//
//  Created by Sharma Elanthiraiyan on 9/6/13.
//  Copyright (c) 2013 Sharma Elanthiraiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineChartPoint.h"

@interface LineChart : UIView

@property (strong) NSArray *lineChartPoints;

- (void)reloadData;

@end
