//
//  ColdOpenViewController.m
//  Presto
//
//  Created by AnthonyGabriele on 1/14/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "ColdOpenViewController.h"

@interface ColdOpenViewController ()

@end

@implementation ColdOpenViewController
@synthesize playGame;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.playGame.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:50];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs registerDefaults:@{@YES : @"First Open"}];
    [prefs synchronize];
}

-(IBAction)buttonPressed:(id)sender{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs boolForKey:@"First Open"]){
        [prefs setBool:NO forKey:@"First Open"];
        [prefs synchronize];
        [self performSegueWithIdentifier:@"coldOpenToHowTo" sender:self];
    }else{
        [self performSegueWithIdentifier:@"coldOpenToMainMenu" sender:self];
    }
}

@end
