//
//  CreditsViewController.m
//  Presto
//
//  Created by AnthonyGabriele on 1/14/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "CreditsViewController.h"

@interface CreditsViewController ()

@end

@implementation CreditsViewController
@synthesize mainMenu;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.mainMenu.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:23];
    
    credits.font = [UIFont fontWithName:@"GothamLight" size:20];
    
    presto.font = [UIFont fontWithName:@"GothamLight" size:30];
    deadlyOctopusllc.font = [UIFont fontWithName:@"GothamLight" size:30];
    
    conceptualDesign.font = [UIFont fontWithName:@"GothamLight" size:17];
    developers.font = [UIFont fontWithName:@"GothamLight" size:17];
    graphicDesign.font = [UIFont fontWithName:@"GothamLight" size:17];
    ceo.font = [UIFont fontWithName:@"GothamLight" size:17];
    cfoAccounting.font = [UIFont fontWithName:@"GothamLight" size:17];
    legalrepresentation.font = [UIFont fontWithName:@"GothamLight" size:17];
    
    santinoOne.font = [UIFont fontWithName:@"GothamBold" size:17];
    anthonySaurabh.font = [UIFont fontWithName:@"GothamBold" size:17];
    jessica.font = [UIFont fontWithName:@"GothamBold" size:17];
    santinoTwo.font = [UIFont fontWithName:@"GothamBold" size:17];
    christine.font = [UIFont fontWithName:@"GothamBold" size:17];
    ericaHinman.font = [UIFont fontWithName:@"GothamBold" size:17];
    kattel.font = [UIFont fontWithName:@"GothamBold" size:17];
}

@end
