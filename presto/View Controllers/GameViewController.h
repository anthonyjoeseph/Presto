//
//  GameViewController.h
//  Presto
//
//  Created by AnthonyGabriele on 7/15/13.
//  Copyright (c) 2013 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import "KeyboardView.h"
#import "GameModel.h"

@interface GameViewController : UIViewController <KeyboardViewDelegate, GameModelDelegate>{
    
    NSMutableArray* audio;
    GameModel *gameModel;
    
    bool firstRun;
    
    UIAlertView* pauseAlert;
    UIAlertView* mainMenuAlert;
    int countdownNumber;
}

//Countdown
-(void)countdownDone;

//KeyboardView
-(void)keysPressed:(NSSet *)keys;
-(void)keysLifted;

//GameModel
-(void)correctKeyPressed:(int)key;
-(void)resetKeys;
-(void)shiftToKeyIndex:(int)keyIndex lowerBound:(int)lowestKey upperBound:(int)highestKey;
-(void)newFlashcardImage:(UIImage *)newImage;
-(void)newChordNotes:(NSArray *)note;
-(void)gameOver;
-(void)updateMinutesLeft:(int)minutesLeft secondsLeft:(int)secondsLeft;
-(void)updateScore:(int)scoreVal;

-(IBAction)mainMenu:(id)sender;
-(IBAction)pause:(id)sender;

@end
