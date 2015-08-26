//
//  TimeSetViewController.h
//  Presto
//
//  Created by AnthonyGabriele on 1/13/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSetViewController : UIViewController{
    IBOutlet UILabel *header;
    IBOutlet UISegmentedControl *timeControl;
    IBOutlet UILabel *timerLabel;
    IBOutlet UILabel *timerDescriptiveLabel;
    IBOutlet UILabel *trainingWheelsLabel;
    IBOutlet UIButton *trainingWheelsOn;
    IBOutlet UIButton *trainingWheelsOff;
    IBOutlet UILabel *trainingWheelsDescriptiveLabel;
    IBOutlet UIButton *mainMenu;
    int minutes;
}


@property (nonatomic, strong) UILabel *header;
@property (nonatomic, strong) UISegmentedControl *timeControl;
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UILabel *timerDescriptiveLabel;
@property (nonatomic, strong) UILabel *trainingWheelsLabel;
@property (nonatomic, strong) UIButton *trainingWheelsOn;
@property (nonatomic, strong) UIButton *trainingWheelsOff;
@property (nonatomic, strong) UILabel *trainingWheelsDescriptiveLabel;
@property (nonatomic, strong) UIButton *mainMenu;

@end
