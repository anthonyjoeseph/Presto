//
//  DifficultyViewController.h
//  Presto
//
//  Created by AnthonyGabriele on 3/23/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameModel.h"

@interface DifficultyViewController : UIViewController{
    IBOutlet UILabel *header;
    IBOutlet UIButton *playTheGame;
    IBOutlet UIButton *footer;
    
    NSArray *allDifficulties;
    IBOutlet UIButton *rootPosition;
    IBOutlet UIButton *firstInversion;
    IBOutlet UIButton *secondInversion;
    IBOutlet UIButton *thirdInversion;
    IBOutlet UIButton *allInversions;
}
-(IBAction)difficultyChosen:(id)sender;

@property (nonatomic, strong) UILabel *header;
@property (nonatomic, strong) UIButton *playTheGame;
@property (nonatomic, strong) UIButton *footer;
@property (nonatomic, strong) NSArray *allDifficulties;
@property (nonatomic, strong) UIButton *rootPosition;
@property (nonatomic, strong) UIButton *firstInversion;
@property (nonatomic, strong) UIButton *secondInversion;
@property (nonatomic, strong) UIButton *thirdInversion;
@property (nonatomic, strong) UIButton *allInversions;
@end
