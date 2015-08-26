//
//  ChordCreator.h
//  Presto
//
//  Created by AnthonyGabriele on 7/14/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chord.h"

typedef enum {
    kRoot,
    kFirst,
    kSecond,
    kThird,
    kAll
} InversionDifficulty;

@interface ChordCreator : NSObject

-(id)initWithDifficulty:(InversionDifficulty)difficulty;
-(Chord*)newChord;

+(void)createChordNotesPlist;

@end
