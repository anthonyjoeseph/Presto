//
//  KeyBase.m
//  MusicNotes
//
//  Created by Christopher Wilson on 1/19/11.
//  Copyright 2011 Yepher.com All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KeyBase.h"


@implementation KeyBase

static UIColor* aColor = nil;
static UIColor* bColor = nil;
static UIColor* cColor = nil;
static UIColor* dColor = nil;
static UIColor* eColor = nil;
static UIColor* fColor = nil;
static UIColor* gColor = nil;

@synthesize label;
@synthesize helpColorHidden;
@synthesize helpTextHidden;
@synthesize keyId;
@synthesize pressState;
@synthesize keyImage;
@synthesize pressedKeyImage;
@synthesize correctKeyImage;


+ (void)initialize {
    [super initialize];
    if (!aColor) {
        aColor = [UIColor purpleColor];
    }
    
    if (!bColor) {
        bColor = [UIColor purpleColor];
    }
    
    if (!cColor) {
        cColor = [UIColor purpleColor];
    }
        
    if (!dColor) {    
        dColor = [UIColor purpleColor];
    }
        
    if (!eColor) {    
        eColor = [UIColor purpleColor];
    }
        
    if (!fColor) {    
        fColor = [UIColor purpleColor];
    }
        
    if (!gColor) {    
        gColor = [UIColor purpleColor];
    }
}

- (void) internalBaseInit {
    [self setLabel:[[UILabel alloc] init]];
    //helpTextHidden = YES;
    helpTextHidden = NO;
    
    //helpColorHidden = YES;
    helpColorHidden = NO;
}

+ (UIColor*) colorForNote: (unichar) note {
    
    switch(note) {
        case 'A':
            return aColor;
        case 'B':
            return bColor;
        case 'C':
            return cColor;
        case 'D':
            return dColor;
        case 'E':
            return eColor;
        case 'F':
            return fColor;
        case 'G':
            return gColor;
        default:
            NSLog(@"Unknow Note Color: %c", note);
            return [UIColor blackColor];
    }
    
    NSLog(@"Unknow Note Color: %c", note);
    return nil;
}

- (void)layoutSubviews {
    CGRect labelFrame = CGRectZero;
    labelFrame.size.width = (self.frame.size.width*.65);
    labelFrame.size.height = (self.frame.size.width/2);
    labelFrame.origin.y = self.frame.size.height - (labelFrame.size.height*1.5);
    labelFrame.origin.x = (self.frame.size.width - labelFrame.size.width)/2;

    [label setFrame:labelFrame];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label];
    [self bringSubviewToFront:label];

    //NSLog(@"label width = %f", labelFrame.size.width);
    // round corners if label is not too small.
    if (labelFrame.size.width > 30) {
        label.layer.cornerRadius = 10.0;
    }
    
    if (helpColorHidden) {
        [label setHidden:YES];
    } else {
        [label setHidden:NO];
        if ([label text] != nil) {
            unichar note = [[label text] characterAtIndex:1];
            [label setBackgroundColor:[KeyBase colorForNote:note]];
        }
    }
    
    if (helpTextHidden) {
        [label setTextColor:[UIColor clearColor]];
    } else {
        [label setTextColor:[UIColor blackColor]];
    }
    
    [label setAdjustsFontSizeToFitWidth:YES];
}

-(void)setPressState:(PressState)newPressState{
    switch (newPressState) {
        case kUnpressed:
            [self setImage:self.keyImage];
            break;
            
        case kPressed:
            [self setImage:self.pressedKeyImage];
            break;
            
        case kCorrect:
            [self setImage:self.correctKeyImage];
            break;
            
        default:
            [self setImage:self.keyImage];
            break;
    }
    pressState = newPressState;
}

- (id) initWithCoder:(NSCoder *)aCoder {
    if( self = [super initWithCoder:aCoder]){
        //[self initialize];
    }
    return self;
}

- (id) initWithFrame:(CGRect)rect{
    if(self = [super initWithFrame:rect]){
        //[self initialize];
    }
    return self;
}

- (id) initWithImage:(UIImage *)image {
    if(self = [super initWithImage:image]){
        [self internalBaseInit];
    }
    return self;
}

- (void) setIntId: (int) intKeyId {
    [self setKeyId:@(intKeyId)];
}

@end
