//
//  SoundEffect.h
//  Presto
//
//  Created by AnthonyGabriele on 7/27/13.
//  Copyright (c) 2013 PianoForte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALSource.h"
#import "ALBuffer.h"

@interface SoundEffect : NSObject
{
    //SystemSoundID soundID;
    ALSource* source;
    ALBuffer* buffer;
}


- (id)initWithURL:(NSURL*)filename;
-(void)newVolume:(float)newGain;
- (void)playSound;

@end