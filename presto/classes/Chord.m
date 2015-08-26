//
//  Chord.m
//  Presto
//
//  Created by AnthonyGabriele on 7/14/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "Chord.h"

@interface Chord ()

@property (nonatomic, strong) NSMutableDictionary *notesPressed;

@end

@implementation Chord
//public
@synthesize chordSymbol;
@synthesize notes;
//private
@synthesize notesPressed;

-(id)initWithChordSymbol:(NSString*)_chordSymbol notes:(NSArray*)_notes{
    if((self = [super init])){
        self.chordSymbol = _chordSymbol;
        self.notes = _notes;
        
        self.notesPressed = [NSMutableDictionary dictionary];
        for(NSNumber* noteIndexObj in self.notes){
            self.notesPressed[noteIndexObj] = @(NO);
        }
    }
    return self;
}

-(int)avgIndex{
    int avgIndex = 0;
    for(NSNumber *note in self.notes){
        avgIndex += [note integerValue];
    }
    avgIndex /= [self.notesPressed count];
    return avgIndex;
}
-(int)lowerBound{
    return [self.notes[0] integerValue];
}
-(int)upperBound{
    return [[self.notes lastObject] integerValue];
}

-(BOOL)isNotePressed:(int)noteIndex{
    return [self.notesPressed[@(noteIndex)] boolValue];
}
-(BOOL)hasNote:(int)noteIndex{
    return self.notesPressed[@(noteIndex)] != nil;
}
-(void)pressNote:(int)noteIndex{
    self.notesPressed[@(noteIndex)] = @(YES);
}

-(void)reset{
    [self.notesPressed removeAllObjects];
    for(NSNumber *note in self.notes){
        self.notesPressed[note] = @(NO);
    }
}

-(BOOL)isComplete{
    for(NSNumber *notePressedIndexObj in self.notesPressed){
        BOOL notePressed = [self.notesPressed[notePressedIndexObj] boolValue];
        if(!notePressed){
            return NO;
        }
    }
    return YES;
}

@end
