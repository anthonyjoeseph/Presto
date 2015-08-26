//
//  Chord.h
//  Presto
//
//  Created by AnthonyGabriele on 7/14/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chord : NSObject

-(id)initWithChordSymbol:(NSString*)_chordSymbol notes:(NSArray*)_notes;
-(int)avgIndex;
-(int)lowerBound;
-(int)upperBound;

-(BOOL)isNotePressed:(int)noteIndex;
-(BOOL)hasNote:(int)noteIndex;
-(void)pressNote:(int)noteIndex;
-(void)reset;
-(BOOL)isComplete;

@property (nonatomic, strong) NSString* chordSymbol;
@property (nonatomic, strong) NSArray* notes;

@end
