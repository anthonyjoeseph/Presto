//
//  StatisticsViewController.m
//  Presto
//
//  Created by AnthonyGabriele on 1/13/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "StatisticsViewController.h"
#import "GamePersistence.h"
#import "ReportCardData.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController
@synthesize pieChart;
@synthesize reportCardLabel;
@synthesize virtuosityStaticLabel;
@synthesize virtuosityDynamicLabel;
@synthesize scoreStaticLabel;
@synthesize scoreDynamicLabel;
@synthesize pausesStaticLabel;
@synthesize pausesDynamicLabel;
@synthesize mainMenu;
@synthesize playAgain;

@synthesize numCorrectNotes;
@synthesize numIncorrectNotes;
@synthesize numPauses;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.reportCardLabel.font = [UIFont fontWithName:@"GothamLight" size:23];
    self.virtuosityStaticLabel.font = [UIFont fontWithName:@"GothamLight" size:25];
    self.virtuosityDynamicLabel.font = [UIFont fontWithName:@"GothamLight" size:45];
    self.scoreStaticLabel.font = [UIFont fontWithName:@"GothamLight" size:25];
    self.scoreDynamicLabel.font = [UIFont fontWithName:@"GothamLight" size:45];
    self.pausesStaticLabel.font = [UIFont fontWithName:@"GothamLight" size:25];
    self.pausesDynamicLabel.font = [UIFont fontWithName:@"GothamLight" size:45];
    self.mainMenu.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:23];
    self.playAgain.titleLabel.font = [UIFont fontWithName:@"GothamMedium" size:52];
    
    self.virtuosityDynamicLabel.text = [NSString stringWithFormat:@"%d/%d", self.numCorrectNotes, self.numCorrectNotes+self.numIncorrectNotes];
    self.scoreDynamicLabel.text = [NSString stringWithFormat:@"%d", [self calculateScore]];
    self.pausesDynamicLabel.text = [NSString stringWithFormat:@"%d", self.numPauses];
    
    [self.pieChart setDataSource:self];
    [self.pieChart setAnimationSpeed:3.0];
    [self.pieChart setShowLabel:YES];
    [self.pieChart setShowPercentage:NO];
    [self.pieChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.pieChart setUserInteractionEnabled:NO];
    self.pieChart.labelFont = [UIFont fontWithName:@"GothamLight" size:32];
    
    NSDate* currentDate = [NSDate date];
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    int time = (int)[prefs integerForKey:@"Timer Minutes"];
    int scoreNumerator = self.numCorrectNotes;
    int scoreDivisor = self.numIncorrectNotes+self.numCorrectNotes;
    float virtuosity = [self calculateSuccess] * 100.0f;
    int virtuosityFloor = virtuosity;
    [[GamePersistence sharedInstance].reportCardData
     addDate:currentDate time:time scoreNumerator:scoreNumerator scoreDivisor:scoreDivisor virtuosity:virtuosityFloor pauses:self.numPauses];
    [[GamePersistence sharedInstance] saveReportCardData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pieChart reloadData];
}
//required
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart{
    return 2;
}
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index{
    if(index == 0){
        float percentage = [self calculateSuccess];
        return percentage;
    }else{
        float percentage = 1 - [self calculateSuccess];
        return percentage;
    }
}
//optional
- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index{
    if(index == 0){
        int percentage = [self calculateSuccess]*100;
        return [NSString stringWithFormat:@"%d", percentage];
    }else{
        return @"";
    }
}
- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index{
    if(index == 0){
        return [UIColor colorWithRed:0.36470588 green:0.6 blue:0.72156863 alpha:1.0];
    }else{
        return [UIColor colorWithRed:0.52549020 green:0.52549020 blue:0.52549020 alpha:1.0];
    }
}

-(float)calculateSuccess{
    if(self.numCorrectNotes + self.numIncorrectNotes > 0){
        return (float)self.numCorrectNotes / (self.numCorrectNotes + self.numIncorrectNotes);
    }else{
        return 0;
    }
}
-(int)calculateScore{
    return (self.numCorrectNotes * 50) - (self.numIncorrectNotes * 20);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
