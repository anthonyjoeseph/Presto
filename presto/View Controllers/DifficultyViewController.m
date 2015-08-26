//
//  DifficultyViewController.m
//  Presto
//
//  Created by AnthonyGabriele on 3/23/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "DifficultyViewController.h"

@interface DifficultyViewController ()

@end

@implementation DifficultyViewController
@synthesize header;
@synthesize playTheGame;
@synthesize footer;
@synthesize allDifficulties;
@synthesize rootPosition;
@synthesize firstInversion;
@synthesize secondInversion;
@synthesize thirdInversion;
@synthesize allInversions;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.header.font = [UIFont fontWithName:@"GothamLight" size:23];
    self.playTheGame.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:45];
    self.footer.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:23];
    self.allDifficulties = @[self.rootPosition, self.firstInversion, self.secondInversion, self.thirdInversion, self.allInversions];
    for(UIButton *currentDifficulty in self.allDifficulties){
        currentDifficulty.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:30];
        currentDifficulty.selected = NO;
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs registerDefaults:@{@(kRoot): @"difficulty"}];
    [prefs synchronize];
    int difficulty = [prefs integerForKey:@"difficulty"];
    switch(difficulty){
        case kRoot:
            self.rootPosition.selected = YES;
            break;
        case kFirst:
            self.firstInversion.selected = YES;
            break;
        case kSecond:
            self.secondInversion.selected = YES;
            break;
        case kThird:
            self.thirdInversion.selected = YES;
            break;
        case kAll:
            self.allInversions.selected = YES;
            break;
        default:
            self.rootPosition.selected = YES;
            break;
    }
}

-(IBAction)difficultyChosen:(id)sender{
    UIButton *difficultyChosen = (UIButton *)sender;
    if(difficultyChosen.selected == NO){
        for(UIButton *currentDifficulty in self.allDifficulties){
            if(currentDifficulty != difficultyChosen){
                currentDifficulty.selected = NO;
            }
        }
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        switch(difficultyChosen.tag){
            case 1:
                [prefs setInteger:kRoot forKey:@"difficulty"];
                break;
            case 2:
                [prefs setInteger:kFirst forKey:@"difficulty"];
                break;
            case 3:
                [prefs setInteger:kSecond forKey:@"difficulty"];
                break;
            case 4:
                [prefs setInteger:kThird forKey:@"difficulty"];
                break;
            case 5:
                [prefs setInteger:kAll forKey:@"difficulty"];
                break;
            default:
                //something's up, default to root difficulty
                [prefs setInteger:kRoot forKey:@"difficulty"];
                break;
        }
        [prefs synchronize];
        difficultyChosen.selected = YES;
    }
}

@end
