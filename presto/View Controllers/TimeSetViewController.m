//
//  TimeSetViewController.m
//  Presto
//
//  Created by AnthonyGabriele on 1/13/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "TimeSetViewController.h"
#import "GameViewController.h"

@interface TimeSetViewController ()

@end

@implementation TimeSetViewController
@synthesize header;
@synthesize timeControl;
@synthesize timerLabel;
@synthesize timerDescriptiveLabel;
@synthesize trainingWheelsLabel;
@synthesize trainingWheelsOn;
@synthesize trainingWheelsOff;
@synthesize trainingWheelsDescriptiveLabel;
@synthesize mainMenu;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    minutes = 0;
    
    CGRect frame= self.timeControl.frame;
    [self.timeControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 40)];
    NSDictionary *fontAttributes = @{[UIFont fontWithName:@"GothamLight" size:2]: @[UITextAttributeFont]};
    [self.timeControl setTitleTextAttributes:fontAttributes forState:UIControlStateNormal];
    for(int i = 0; i < self.timeControl.numberOfSegments; i++){
        [self.timeControl setContentOffset:CGSizeMake(0, 2) forSegmentAtIndex:i];
    }
    
    self.header.font = [UIFont fontWithName:@"GothamLight" size:23];
    [self.timeControl addTarget:self action:@selector(timeSelected:) forControlEvents:UIControlEventValueChanged];
    self.timerLabel.font = [UIFont fontWithName:@"GothamLight" size:30];
    self.timerDescriptiveLabel.font = [UIFont fontWithName:@"GothamLight" size:17];
    self.trainingWheelsLabel.font = [UIFont fontWithName:@"GothamLight" size:30];
    self.trainingWheelsOn.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:40];
    self.trainingWheelsOff.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:40];
    self.trainingWheelsDescriptiveLabel.font = [UIFont fontWithName:@"GothamLight" size:17];
    self.mainMenu.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:23];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs registerDefaults:@{@1 : @"Timer Minutes",
                              @YES: @"Training Wheels"}];
    [prefs synchronize];
    minutes = (int)[prefs integerForKey:@"Timer Minutes"];
    if([prefs boolForKey:@"Training Wheels"]){
        self.trainingWheelsOn.selected = YES;
        self.trainingWheelsOff.selected = NO;
    }else{
        self.trainingWheelsOn.selected = NO;
        self.trainingWheelsOff.selected = YES;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    switch (minutes) {
        case 1:
            self.timeControl.selectedSegmentIndex = 0;
            break;
        case 5:
            self.timeControl.selectedSegmentIndex = 1;
            break;
        case 10:
            self.timeControl.selectedSegmentIndex = 2;
            break;
        case 15:
            self.timeControl.selectedSegmentIndex = 3;
            break;
        case 20:
            self.timeControl.selectedSegmentIndex = 4;
            break;
        case 25:
            self.timeControl.selectedSegmentIndex = 5;
            break;
        case 30:
            self.timeControl.selectedSegmentIndex = 6;
            break;
        default:
            self.timeControl.selectedSegmentIndex = 0;
            break;
    }
}

-(IBAction)timeSelected:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSString *timeInMinutes = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:[timeInMinutes intValue] forKey:@"Timer Minutes"];
    [prefs synchronize];
}

-(IBAction)assistanceButton:(id)sender{
    if(sender == self.trainingWheelsOn){
        if(self.trainingWheelsOff.selected){
            self.trainingWheelsOn.selected = YES;
            self.trainingWheelsOff.selected = NO;
        }
    }
    if(sender == self.trainingWheelsOff){
        if(self.trainingWheelsOn.selected){
            self.trainingWheelsOn.selected = NO;
            self.trainingWheelsOff.selected = YES;
        }
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:self.trainingWheelsOn.selected forKey:@"Training Wheels"];
    [prefs synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
