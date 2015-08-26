//
//  StatisticsViewController.h
//  Presto
//
//  Created by AnthonyGabriele on 1/13/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface StatisticsViewController : UIViewController <XYPieChartDataSource>{
    int numCorrectNotes;
    int numIncorrectNotes;
    int numPauses;
}
//Data Source
//required
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart;
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index;
//optional
- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index;


@property (nonatomic, strong) IBOutlet XYPieChart *pieChart;
@property (nonatomic, strong) IBOutlet UILabel *reportCardLabel;
@property (nonatomic, strong) IBOutlet UILabel *virtuosityStaticLabel;
@property (nonatomic, strong) IBOutlet UILabel *virtuosityDynamicLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreStaticLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreDynamicLabel;
@property (nonatomic, strong) IBOutlet UILabel *pausesStaticLabel;
@property (nonatomic, strong) IBOutlet UILabel *pausesDynamicLabel;
@property (nonatomic, strong) IBOutlet UIButton *mainMenu;
@property (nonatomic, strong) IBOutlet UIButton *playAgain;

//set by the GameViewController
@property (nonatomic, assign) int numCorrectNotes;
@property (nonatomic, assign) int numIncorrectNotes;
@property (nonatomic, assign) int numPauses;

@end
