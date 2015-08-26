//
//  ReportCardData.h
//  Presto
//
//  Created by AnthonyGabriele on 7/3/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportCardData : NSObject <NSCoding>{
    NSMutableArray* dates;
    NSMutableDictionary* times;
    NSMutableDictionary* scoreNumerator;
    NSMutableDictionary* scoreDenominator;
    NSMutableDictionary* virtuosity;
    NSMutableDictionary* pauses;
}

-(void)addDate:(NSDate*)date time:(int)minutes scoreNumerator:(int)scoreNumerator scoreDivisor:(int)scoreDivisor virtuosity:(int)virtuosityPercent pauses:(int)numPauses;
-(NSArray*)firstTenDates;
-(int)timeForDate:(NSDate*)date;
-(int)scoreNumeratorForDate:(NSDate*)date;
-(int)scoreDenominatorForDate:(NSDate*)date;
-(int)virtuosityForDate:(NSDate*)date;
-(int)pausesForDate:(NSDate*)date;

@property (nonatomic, strong) NSArray* dates;

@end