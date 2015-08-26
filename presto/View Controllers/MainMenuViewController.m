//
//  MainMenuViewController.m
//  Presto
//
//  Created by AnthonyGabriele on 7/25/13.
//  Copyright (c) 2013 PianoForte. All rights reserved.
//

#import "MainMenuViewController.h"

@implementation MainMenuViewController
@synthesize mainMenu;
@synthesize play;
@synthesize howTo;
@synthesize reportCard;
@synthesize credits;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mainMenu setFont:[UIFont fontWithName:@"GothamLight" size:23]];
    [self.play.titleLabel setFont:[UIFont fontWithName:@"GothamLight" size:50]];
    [self.howTo.titleLabel setFont:[UIFont fontWithName:@"GothamLight" size:50]];
    [self.reportCard.titleLabel setFont:[UIFont fontWithName:@"GothamLight" size:50]];
    [self.credits.titleLabel setFont:[UIFont fontWithName:@"GothamLight" size:23]];
	// Do any additional setup after loading the view.
}


@end
