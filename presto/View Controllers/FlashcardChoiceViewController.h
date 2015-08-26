//
//  FlashcardChoiceViewController.h
//  Presto
//
//  Created by AnthonyGabriele on 1/10/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlashcardChoiceViewController : UIViewController{
    IBOutlet UILabel *header;
    
    NSMutableDictionary *chordSets;
    
    IBOutlet UIButton *majorChords;
    IBOutlet UIButton *minorChords;
    IBOutlet UIButton *diminishedChords;
    IBOutlet UIButton *augmentedChords;
    IBOutlet UIButton *sixChords;
    IBOutlet UIButton *sevenChords;
    IBOutlet UIButton *minorSixChords;
    IBOutlet UIButton *minorSevenChords;
    IBOutlet UIButton *majorSevenChords;
    IBOutlet UIButton *learnTheStaff;
    IBOutlet UIButton *allChords;
    IBOutlet UIButton *mainMenu;
    
    NSArray *allChordButtons;
    
    IBOutlet UIButton *next;
}

-(IBAction)chordTypeSelected:(id)sender;
-(IBAction)allChordTypesSelected:(id)sender;

@property (nonatomic, strong) UILabel *header;
@property (nonatomic, strong) NSMutableDictionary *chordSets;
@property (nonatomic, strong) UIButton *majorChords;
@property (nonatomic, strong) UIButton *minorChords;
@property (nonatomic, strong) UIButton *diminishedChords;
@property (nonatomic, strong) UIButton *augmentedChords;
@property (nonatomic, strong) UIButton *sixChords;
@property (nonatomic, strong) UIButton *sevenChords;
@property (nonatomic, strong) UIButton *minorSixChords;
@property (nonatomic, strong) UIButton *minorSevenChords;
@property (nonatomic, strong) UIButton *majorSevenChords;
@property (nonatomic, strong) UIButton *learnTheStaff;
@property (nonatomic, strong) UIButton *allChords;
@property (nonatomic, strong) NSArray *allChordButtons;
@property (nonatomic, strong) UIButton *next;
@property (nonatomic, strong) UIButton *mainMenu;
@end
