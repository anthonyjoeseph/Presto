//
//  FlashcardChoiceViewController.m
//  Presto
//
//  Created by AnthonyGabriele on 1/10/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "FlashcardChoiceViewController.h"

@interface FlashcardChoiceViewController ()

@end

@implementation FlashcardChoiceViewController
@synthesize header;
@synthesize chordSets;
@synthesize majorChords;
@synthesize minorChords;
@synthesize diminishedChords;
@synthesize augmentedChords;
@synthesize sixChords;
@synthesize sevenChords;
@synthesize minorSixChords;
@synthesize minorSevenChords;
@synthesize majorSevenChords;
@synthesize learnTheStaff;
@synthesize allChords;
@synthesize allChordButtons;
@synthesize next;
@synthesize mainMenu;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.allChordButtons = @[self.majorChords, self.minorChords, self.diminishedChords, self.augmentedChords,
                             self.sixChords, self.sevenChords, self.minorSixChords, self.minorSevenChords,
                             self.majorSevenChords, self.learnTheStaff];
    self.chordSets = [NSMutableDictionary dictionary];
    [self.chordSets setObject:@"maj" forKey:@"MAJOR CHORDS"];
    [self.chordSets setObject:@"minor" forKey:@"MINOR CHORDS"];
    [self.chordSets setObject:@"°" forKey:@"DIMINISHED CHORDS"];
    [self.chordSets setObject:@"+" forKey:@"AUGMENTED CHORDS"];
    [self.chordSets setObject:@"6" forKey:@"6 CHORDS"];
    [self.chordSets setObject:@"7" forKey:@"7 CHORDS"];
    [self.chordSets setObject:@"m6" forKey:@"MINOR 6 CHORDS"];
    [self.chordSets setObject:@"m7" forKey:@"MINOR 7 CHORDS"];
    [self.chordSets setObject:@"major7" forKey:@"MAJOR 7 CHORDS"];
    [self.chordSets setObject:@"root" forKey:@"LEARN THE STAFF"];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs registerDefaults:@{@YES: @"maj",
                              @NO: @"minor",
                              @NO: @"°",
                              @NO: @"+",
                              @NO: @"6",
                              @NO: @"7",
                              @NO: @"m6",
                              @NO: @"m7",
                              @NO: @"major7",
                              @NO: @"root"}];
    [prefs synchronize];
    
    for(UIButton *chordSet in self.allChordButtons){
        chordSet.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:30];
        chordSet.titleLabel.numberOfLines = 0;
        chordSet.titleLabel.textAlignment = NSTextAlignmentCenter;
        NSString *buttonName = chordSet.titleLabel.text;
        NSString *chordSetName = [self.chordSets objectForKey:buttonName];
        chordSet.selected = [prefs boolForKey:chordSetName];
    }
    self.allChords.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:30];
    self.next.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:30];
    
    self.header.font = [UIFont fontWithName:@"GothamLight" size:23];
    self.mainMenu.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:23];
}

-(IBAction)chordTypeSelected:(id)sender{
    UIButton *chordSetButton = (UIButton*)sender;
    NSString *buttonName = chordSetButton.titleLabel.text;
    NSString *chordSetName = [self.chordSets objectForKey:buttonName];
    bool isAnythingSelected = NO;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    bool newState = ![prefs boolForKey:chordSetName];
    chordSetButton.selected = newState;
    for(UIButton *chordButton in self.allChordButtons){
        if(chordButton.selected){
            isAnythingSelected = YES;
        }
    }
    if(!isAnythingSelected){
        self.next.enabled = NO;
    }else{
        self.next.enabled = YES;
    }
    [prefs setBool:newState forKey:chordSetName];
    [prefs synchronize];
}

-(IBAction)allChordTypesSelected:(id)sender{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    for(UIButton *chordButton in self.allChordButtons){
        chordButton.selected = YES;
        NSString *buttonName = chordButton.titleLabel.text;
        NSString *chordSetName = [self.chordSets objectForKey:buttonName];
        [prefs setBool:YES forKey:chordSetName];
    }
    [prefs synchronize];
}

@end
