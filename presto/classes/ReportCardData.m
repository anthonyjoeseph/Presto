//
//  ReportCardData.m
//  Presto
//
//  Created by AnthonyGabriele on 7/3/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "ReportCardData.h"

@implementation ReportCardData

@synthesize dates = dates;

-(id)init{
    if((self = [super init])){
        dates = [NSMutableArray array];
        times = [NSMutableDictionary dictionary];
        scoreNumerator = [NSMutableDictionary dictionary];
        scoreDenominator = [NSMutableDictionary dictionary];
        virtuosity = [NSMutableDictionary dictionary];
        pauses = [NSMutableDictionary dictionary];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)coder{
    if((self = [super init])){
        dates = [coder decodeObjectForKey:@"dates"];
        times = [coder decodeObjectForKey:@"times"];
        scoreNumerator = [coder decodeObjectForKey:@"scoreNumerator"];
        scoreDenominator = [coder decodeObjectForKey:@"scoreDenominator"];
        virtuosity = [coder decodeObjectForKey:@"virtuosity"];
        pauses = [coder decodeObjectForKey:@"pauses"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:dates forKey:@"dates"];
    [coder encodeObject:times forKey:@"times"];
    [coder encodeObject:scoreNumerator forKey:@"scoreNumerator"];
    [coder encodeObject:scoreDenominator forKey:@"scoreDenominator"];
    [coder encodeObject:virtuosity forKey:@"virtuosity"];
    [coder encodeObject:pauses forKey:@"pauses"];
}
-(void)addDate: (NSDate*)date time:(int)minutes scoreNumerator:(int)scoreNumeratorInt scoreDivisor:(int)scoreDivisorInt virtuosity:(int)virtuosityPercent pauses:(int)numPauses{
    [dates insertObject:date atIndex:0];
    [times setObject:@(minutes) forKey:date];
    [scoreNumerator setObject:@(scoreNumeratorInt) forKey: date];
    [scoreDenominator setObject:@(scoreDivisorInt) forKey: date];
    [virtuosity setObject:@(virtuosityPercent) forKey: date];
    [pauses setObject:@(numPauses) forKey: date];
}
-(NSArray*)firstTenDates{
    if(dates.count < 10){
        return dates;
    }
    NSArray* firstTen = [dates subarrayWithRange: NSMakeRange(0, 10)];
    return firstTen;
}
-(int)timeForDate:(NSDate*)date{
    return [[times objectForKey:date] intValue];
}
-(int)scoreNumeratorForDate:(NSDate*)date{
    return [[scoreNumerator objectForKey: date] intValue];
}
-(int)scoreDenominatorForDate:(NSDate*)date{
    return [[scoreDenominator objectForKey: date] intValue];
}
-(int)virtuosityForDate:(NSDate*)date{
    return [[virtuosity objectForKey: date] intValue];
}
-(int)pausesForDate:(NSDate*)date{
    return [[pauses objectForKey: date] intValue];
}

@end
