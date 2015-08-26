//
//  GameModel.h
//  Presto
//
//  Created by AnthonyGabriele on 7/17/13.
//  Copyright (c) 2013 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chord.h"
#import "ChordCreator.h"

@protocol GameModelDelegate
-(void)newFlashcardImage:(UIImage *)newImage;
-(void)correctKeyPressed:(int)key;
-(void)resetKeys;
-(void)newChordNotes:(NSArray*)note;
-(void)shiftToKeyIndex:(int)keyIndex lowerBound:(int)lowestKey upperBound:(int)highestKey;
-(void)gameOver;
-(void)updateMinutesLeft:(int)minutesLeft secondsLeft:(int)secondsLeft;
-(void)updateScore:(int)score;
@end

@interface GameModel : NSObject{
    
    int numCorrectNotes;
    int numIncorrectNotes;
    int numPauses;
    int minutesLeft;
    int secondsLeft;
    
    NSTimer *gameTimer;
}
-(void)start;
-(void)keysPressed:(NSSet *)keys;
-(int)calculateScore;
-(void)keysLifted;
-(void)pause;
-(void)resume;
-(void)timerTick:(NSTimer*)theTimer;

@property (nonatomic, weak) id<GameModelDelegate> delegate;
@property (nonatomic, strong) ChordCreator* chordCreator;
@property (nonatomic, strong) Chord* currentChord;
@property (nonatomic, assign) int numCorrectNotes;
@property (nonatomic, assign) int numIncorrectNotes;
@property (nonatomic, assign) int numPauses;

@end
