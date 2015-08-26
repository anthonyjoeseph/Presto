 //
//  GameModel.m
//  Presto
//
//  Created by AnthonyGabriele on 7/17/13.
//  Copyright (c) 2013 PianoForte. All rights reserved.
//

#import "GameModel.h"
#import "NSTimer+Pause.h"

@implementation GameModel
@synthesize delegate;
@synthesize chordCreator;
@synthesize currentChord;
@synthesize numCorrectNotes;
@synthesize numIncorrectNotes;
@synthesize numPauses;

-(id)init{
    if((self = [super init])){
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        InversionDifficulty difficulty = (InversionDifficulty)[prefs integerForKey:@"difficulty"];
        self.chordCreator = [[ChordCreator alloc] initWithDifficulty:difficulty];
        
        minutesLeft = (int)[prefs integerForKey:@"Timer Minutes"];
        secondsLeft = (int)[prefs integerForKey:@"Timer Seconds"];
        
        numCorrectNotes = 0;
        numIncorrectNotes = 0;
        numPauses = 0;
    }
    return self;
}

-(void)start{
    [self.delegate updateMinutesLeft:minutesLeft secondsLeft:secondsLeft];
    [self.delegate updateScore:0];
    
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [self newFlashcard];
}

-(void)newFlashcard{
    self.currentChord = [self.chordCreator newChord];
    
    NSString *flashcardFileName;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs boolForKey:@"Training Wheels"]){
        flashcardFileName = [NSString stringWithFormat:@"%@", [self.currentChord chordSymbol]];
    }else{
        flashcardFileName = [NSString stringWithFormat:@"%@_sans", [self.currentChord chordSymbol]];
    }
    NSString *flashcardFilePath = [[NSBundle mainBundle] pathForResource:flashcardFileName ofType:@"jpg"];
    UIImage *flashcardImage = [UIImage imageWithContentsOfFile:flashcardFilePath];
    [self.delegate newFlashcardImage:flashcardImage];
    int avgIndex = [self.currentChord avgIndex];
    int lowerBound = [self.currentChord lowerBound];
    int upperBound = [self.currentChord upperBound];
    [self.delegate shiftToKeyIndex:avgIndex lowerBound:lowerBound upperBound:upperBound];
    [self.delegate newChordNotes:self.currentChord.notes];
}

-(void)keysPressed:(NSSet *)keys{
    for(NSNumber *keyPressedObj in keys){
        int keyPressed = [keyPressedObj integerValue];
        if([self.currentChord hasNote:keyPressed]){
            if(![self.currentChord isNotePressed:keyPressed]){
                [self.currentChord pressNote:keyPressed];
                [self.delegate correctKeyPressed:keyPressed];
                self.numCorrectNotes++;
            }
        }else{
            self.numIncorrectNotes++;
            [self.currentChord reset];
            [self.delegate resetKeys];
        }
    }
    [self.delegate updateScore: [self calculateScore]];
}
-(int)calculateScore{
    return (self.numCorrectNotes * 50) - (self.numIncorrectNotes * 20);
}
-(void)keysLifted{
    if([self.currentChord isComplete]){
        [self.delegate resetKeys];
        [self newFlashcard];
    }
}
-(void)pause{
    self.numPauses++;
    [gameTimer pause];
}
-(void)resume{
    [gameTimer resume];
}

-(void)timerTick:(NSTimer*)theTimer{
    bool isGameContinuing = YES;
    if(secondsLeft == 0){
        if(minutesLeft == 0){
            [theTimer invalidate];
            [self.delegate gameOver];
            isGameContinuing = NO;
        }
        secondsLeft = 60;
        minutesLeft--;
    }
    if(isGameContinuing){
        secondsLeft--;
        [self.delegate updateMinutesLeft:minutesLeft secondsLeft:secondsLeft];
    }
}

@end
