//
//  SoundEffect.m
//  Presto
//
//  Created by AnthonyGabriele on 7/27/13.
//  Copyright (c) 2013 PianoForte. All rights reserved.
//

#import "SoundEffect.h"
#import "OALSimpleAudio.h"
#import "OpenALManager.h"

@implementation SoundEffect

- (id)initWithURL:(NSURL *)fileURL
{
    if ((self = [super init])){
        if (fileURL != nil){
            if([OALSimpleAudio sharedInstance].reservedSources != 1){
                [OALSimpleAudio sharedInstance].reservedSources = 1;
            }
            source = [ALSource source];
            buffer = [[OpenALManager sharedInstance] bufferFromUrl:fileURL];
            /*SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError)
                soundID = theSoundID;*/
        }
    }
    return self;
}
-(void)newVolume:(float)newGain{
    source.gain = newGain;
}

- (void)dealloc
{
    //AudioServicesDisposeSystemSoundID(soundID);
}

- (void)playSound
{
    [source play:buffer];
    //AudioServicesPlaySystemSound(soundID);
}

@end