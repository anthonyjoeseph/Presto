//
//  ChordCreator.m
//  Presto
//
//  Created by AnthonyGabriele on 7/14/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "ChordCreator.h"
#import "NSMutableArray_Shuffling.h"

#define ARRAYLENGTH(x) (sizeof(x) / sizeof(x[0]))
#define NUMHALFSTEPS 12

@interface ChordCreator (){
    int chordTypeIndex;
    int rootIndex;
}

@property (nonatomic, strong) NSMutableArray *rootKeys;
@property (nonatomic, strong) NSDictionary *chordNotes;
@property (nonatomic, strong) NSMutableArray *usableChordTypeKeys;
@property (nonatomic, strong) NSArray *inversionTypes;
@property (nonatomic, strong) NSArray *inversionTypesMinusThird;

@end

@implementation ChordCreator

@synthesize rootKeys;
@synthesize chordNotes;
@synthesize usableChordTypeKeys;
@synthesize inversionTypes;
@synthesize inversionTypesMinusThird;

-(id)initWithDifficulty:(InversionDifficulty)difficulty{
    if((self = [super init])){
        chordTypeIndex = 0;
        rootIndex = 0;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"chords" ofType:@"plist"];
        self.chordNotes = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        self.usableChordTypeKeys = [NSMutableArray array];
        NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
        for(NSString *chordTypeKey in [self.chordNotes keyEnumerator]){
            if([prefs boolForKey:chordTypeKey]){
                [self.usableChordTypeKeys addObject:chordTypeKey];
            }
        }
        
        self.rootKeys = [NSMutableArray array];
        for(NSString *rootKey in [[self.chordNotes objectForKey:@"maj"] keyEnumerator]){
            [self.rootKeys addObject:rootKey];
        }
        
        switch(difficulty){
            case kRoot:
                self.inversionTypes = @[@""];
                self.inversionTypesMinusThird = @[@""];
                break;
            case kFirst:
                self.inversionTypes = @[@"_2"];
                self.inversionTypesMinusThird = @[@"_2"];
                break;
            case kSecond:
                self.inversionTypes = @[@"_3"];
                self.inversionTypesMinusThird = @[@"_3"];
                break;
            case kThird:
                self.inversionTypes = @[@"_4"];
                self.inversionTypesMinusThird = @[@""];
                break;
            case kAll:
                self.inversionTypes = @[@"", @"_2", @"_3", @"_4"];
                self.inversionTypesMinusThird = @[@"", @"_2", @"_3"];
                break;
            default:
                self.inversionTypes = @[@""];
                self.inversionTypesMinusThird = @[@""];
                break;
        }
    }
    return self;
}

-(Chord*)newChord{
    NSString *chordType = [self randomChordType];
    NSString *root = [self randomRoot];
    NSString *chordName;
    NSArray* notes;
    if([chordType isEqualToString:@"root"]){
        NSString *octave = [self randomOctaveForRoot:root];
        chordName = [NSString stringWithFormat:@"%@%@%@", root, octave, chordType];
        NSDictionary* roots = self.chordNotes[chordType];
        notes = roots[chordName];
    }else{
        NSString *inversion = [self randomInversionForType:chordType];
        chordName = [NSString stringWithFormat:@"%@%@%@", root, chordType, inversion];
        NSDictionary* chordTypes = self.chordNotes[chordType];
        NSDictionary* chordNames = chordTypes[root];
        notes = chordNames[chordName];
    }
    Chord* chord = [[Chord alloc] initWithChordSymbol:chordName notes:notes];
    return chord;
}

-(NSString *)randomChordType{
    if(chordTypeIndex >= [self.usableChordTypeKeys count]){
        chordTypeIndex = 0;
    }
    if(chordTypeIndex == 0){
        [self.usableChordTypeKeys shuffle];
    }
    return self.usableChordTypeKeys[chordTypeIndex++];
}
-(NSString *)randomRoot{
    if(rootIndex >= [self.rootKeys count]){
        rootIndex = 0;
    }
    if(rootIndex == 0){
        [self.rootKeys shuffle];
    }
    return self.rootKeys[rootIndex++];
}
-(NSString *)randomInversionForType:(NSString *)chordType{
    NSArray *usableInversionTypes;
    if([chordType isEqualToString:@"+"] || [chordType isEqualToString:@"maj"] ||
       [chordType isEqualToString:@"minor"]){
        usableInversionTypes = self.inversionTypesMinusThird;
    }else{
        usableInversionTypes = self.inversionTypes;
    }
    int randomInversionIndex = arc4random() % usableInversionTypes.count;
    return usableInversionTypes[randomInversionIndex];
}
-(NSString *)randomOctaveForRoot:(NSString *)root{
    int numberOfOctaves = 2;
    if([root isEqualToString:@"C"]){
        numberOfOctaves = 3;
    }
    int randomIndex = arc4random() % numberOfOctaves;
    return [@[@"", @"2", @"3"] objectAtIndex:randomIndex];
}

//only needs to be called once to create the file
+(void)createChordNotesPlist{
     int lowestNote = 39;//middle C
     
     int chordTypes[9][4] = {
     {0, 4, 7, -1},//major
     {0, 3, 7, -1},//minor
     {0, 4, 8, -1},//+
     {0, 4, 7, 9},//6
     {0, 3, 7, 9},//minor 6
     {0, 4, 7, 10},//7
     {0, 3, 7, 10},//minor 7
     {0, 4, 7, 11},//major 7
     {0, 3, 6, 9}//o
     };
     int smallInversions[3][3] = {
     {0, 1, 2},
     {1, 2, 0},
     {2, 0, 1}
     };
     int bigInversions[4][4] = {
     {0, 1, 2, 3},
     {1, 2, 3, 0},
     {2, 3, 0, 1},
     {3, 0, 1, 2}
     };
     int smallInversionTranspositions[3][3] = {
     {0, 0, 0},
     {0, 0, 12},
     {0, 12, 12}
     };
     int bigInversionTranspositions[4][4] = {
     {0, 0, 0, 0},
     {0, 0, 0, 12},
     {0, 0, 12, 12},
     {0, 12, 12, 12}
     };
    
    NSArray *inversionNames = [NSArray arrayWithObjects:@"", @"_2", @"_3", @"_4", nil];
    NSArray *chordTypeNames = [NSArray arrayWithObjects:@"maj", @"minor", @"+", @"6", @"m6", @"7", @"m7", @"major7", @"°", nil];
    NSArray *rootNames = [NSArray arrayWithObjects:@"C", @"Db", @"D", @"Eb", @"E", @"F", @"Gb", @"G", @"Ab", @"A", @"Bb", @"B", nil];
    
    int sharps[5] = {1, 3, 6, 8, 10};
    NSArray *sharpNames = [NSArray arrayWithObjects:@"C#", @"D#", @"F#", @"G#", @"A#", nil];
    
    NSMutableDictionary *baseDict = [NSMutableDictionary dictionary];
    for(int typeIndex = 0; typeIndex < chordTypeNames.count; typeIndex++){
        NSMutableDictionary *chordTypeDict = [NSMutableDictionary dictionary];
        NSString *chordTypeName = chordTypeNames[typeIndex];
        for(int root = 0; root < NUMHALFSTEPS; root++){
            NSMutableDictionary *rootDict = [NSMutableDictionary dictionary];
            NSString *rootName = rootNames[root];
            NSMutableArray *absoluteChord;
            bool tooHigh = NO;
            if(chordTypes[typeIndex][3] == -1){
                for(int inversionNumber = 0; inversionNumber < ARRAYLENGTH(smallInversions); inversionNumber++){
                    absoluteChord = [NSMutableArray array];
                    for(int inversionNote = 0; inversionNote < ARRAYLENGTH(smallInversions[inversionNumber]); inversionNote++){
                        int noteIndex = smallInversions[inversionNumber][inversionNote];
                        int transposition = smallInversionTranspositions[inversionNumber][inversionNote];
                        int absoluteNote = chordTypes[typeIndex][noteIndex];
                        absoluteNote += lowestNote + root + transposition;
                        if(absoluteNote > 62){
                            tooHigh = YES;
                        }
                        [absoluteChord addObject:@(absoluteNote)];
                    }
                    if(tooHigh){
                        NSMutableArray *lowerChord = [NSMutableArray array];
                        for(NSNumber *note in absoluteChord){
                            [lowerChord addObject:@([note intValue] - 12)];
                        }
                        [absoluteChord removeAllObjects];
                        [absoluteChord addObjectsFromArray:lowerChord];
                        tooHigh = NO;
                    }
                    NSString *inversionName = inversionNames[inversionNumber];
                    NSString *chordName = [NSString stringWithFormat:@"%@%@%@", rootName, chordTypeName, inversionName, nil];
                    [rootDict setObject:absoluteChord forKey:chordName];
                }
            }else{
                for(int inversionNumber = 0; inversionNumber < ARRAYLENGTH(bigInversions); inversionNumber++){
                    absoluteChord = [NSMutableArray array];
                    for(int inversionNote = 0; inversionNote < ARRAYLENGTH(bigInversions[inversionNumber]); inversionNote++){
                        int noteIndex = bigInversions[inversionNumber][inversionNote];
                        int transposition = bigInversionTranspositions[inversionNumber][inversionNote];
                        int absoluteNote = chordTypes[typeIndex][noteIndex];
                        absoluteNote += lowestNote + root + transposition;
                        if(absoluteNote > 62){
                            tooHigh = YES;
                        }
                        [absoluteChord addObject:@(absoluteNote)];
                    }
                    if(tooHigh){
                        NSMutableArray *lowerChord = [NSMutableArray array];
                        for(NSNumber *note in absoluteChord){
                            [lowerChord addObject:@([note intValue] - 12)];
                        }
                        [absoluteChord removeAllObjects];
                        [absoluteChord addObjectsFromArray:lowerChord];
                        tooHigh = NO;
                    }
                    NSString *inversionName = inversionNames[inversionNumber];
                    NSString *chordName = [NSString stringWithFormat:@"%@%@%@", rootName, chordTypeName, inversionName, nil];
                    [rootDict setObject:absoluteChord forKey:chordName];
                }
            }
            [chordTypeDict setObject:rootDict forKey:rootName];
        }
        [baseDict setObject:chordTypeDict forKey:chordTypeName];
    }
    NSMutableDictionary *singleNotes = [NSMutableDictionary dictionary];
    for(int tonic = 0; tonic < NUMHALFSTEPS; tonic++){
        [singleNotes setObject:[NSArray arrayWithObject: @(lowestNote + tonic)] forKey:[NSString stringWithFormat:@"%@root", rootNames[tonic]]];
    }
    for(int sharpIndex = 0; sharpIndex < ARRAYLENGTH(sharps); sharpIndex++){
        [singleNotes setObject:[NSArray arrayWithObject: @(lowestNote + sharps[sharpIndex])] forKey:[NSString stringWithFormat:@"%@root", sharpNames[sharpIndex]]];
    }
    for(int tonicTwo = 0; tonicTwo < NUMHALFSTEPS; tonicTwo++){
        [singleNotes setObject:[NSArray arrayWithObject: @(lowestNote + tonicTwo + 12)] forKey:[NSString stringWithFormat:@"%@2root", rootNames[tonicTwo]]];
    }
    for(int sharpIndexTwo = 0; sharpIndexTwo < ARRAYLENGTH(sharps); sharpIndexTwo++){
        [singleNotes setObject:[NSArray arrayWithObject: @(lowestNote + sharps[sharpIndexTwo] + 12)] forKey:[NSString stringWithFormat:@"%@2root", sharpNames[sharpIndexTwo]]];
    }
    [singleNotes setObject:[NSArray arrayWithObject:@(lowestNote + 24)] forKey:@"C3root"];
    [baseDict setObject:singleNotes forKey:@"root"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"chords.plist"];
    NSLog([NSString stringWithFormat:@"%@", plistLocation]);
    [baseDict writeToFile:plistLocation atomically:YES];
}

@end
