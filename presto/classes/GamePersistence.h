//
//  GamePersistence.h
//  Presto
//
//  Created by AnthonyGabriele on 7/3/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportCardData.h"

@interface GamePersistence : NSObject

+(GamePersistence*)sharedInstance;
-(void)saveReportCardData;

@property (nonatomic, strong) ReportCardData* reportCardData;

@end
