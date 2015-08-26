//
//  GamePersistence.m
//  Presto
//
//  Created by AnthonyGabriele on 7/3/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "GamePersistence.h"

@implementation GamePersistence

#pragma mark Singleton Methods

+ (id)sharedInstance {
    static GamePersistence *sharedGamePersistence = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGamePersistence = [[self alloc] init];
    });
    return sharedGamePersistence;
}

- (id)init {
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = paths[0];
        NSString *documentPath = [documentDirectory stringByAppendingPathComponent:@"GameData.dat"];
        NSMutableDictionary *rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:documentPath];
        if(rootObject){
            self.reportCardData = [rootObject objectForKey:@"reportCardData"];
        }else{
            self.reportCardData = [[ReportCardData alloc] init];
        }
    }
    return self;
}

-(void)saveReportCardData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *gameStatePath = [documentsDirectory stringByAppendingPathComponent:@"GameData.dat"];
    NSMutableDictionary *rootObject = [NSMutableDictionary dictionary];
    [rootObject setObject:self.reportCardData forKey:@"reportCardData"];
    [NSKeyedArchiver archiveRootObject:rootObject toFile:gameStatePath];
}

@end
