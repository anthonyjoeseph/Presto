//
//  KeyboardView.m
//  MusicNotes
//
//  Created by Christopher Wilson on 1/16/11.
//  Copyright 2011 Yepher.com All rights reserved.
//

#import "KeyboardView.h"
#import "KeyBase.h"
#import "IvoryKeyView.h"
#import "EbonyKeyView.h"


@implementation KeyboardView

@synthesize doubleEbonySize;
@synthesize visibleKeyRange;
@synthesize keyNames;
@synthesize keys;
@synthesize ivoryKeyBackground;
@synthesize ivoryCorrectKeyBackground;
@synthesize ivoryPressedKeyBackground;
@synthesize ebonyKeyBackground;
@synthesize ebonyCorrectKeyBackground;
@synthesize ebonyPressedKeyBackground;


/**
 visibleKeyRange.location represents the number of ivory keys but the keyNames array contains 
 ebony keys as well, so this maps visibleKeyRange.location to keynames array index
 **/
- (int) convertToKeynameOffset: (int) location {
    int indexes[] = {0, 2, 3, 5, 7, 8, 10, 12, 14, 15, 17, 19, 20, 22, 24, 26, 27, 29, 31, 32, 34, 36, 38, 39, 41, 43, 44, 46, 48, 50, 51, 53, 55, 56, 58, 60, 62, 63, 65, 67, 68, 70, 72, 74, 75, 77, 79, 80, 82, 84, 86, 87 };
    return indexes[location];
}

- (void) addIvoryKey:(int)keyIndex ivoryIndex:(int)ivoryIndex ivoryWidth:(float)ivoryWidth keyBackground:(UIImage*)keyBackground pressedKeyBackground:(UIImage*)pressedKeyBackground correctKeyBackground:(UIImage*)correctKeyBackground title:(NSString*)title {
    
    IvoryKeyView* key = [[IvoryKeyView alloc] init];
    key.keyImage = keyBackground;
    key.pressedKeyImage = pressedKeyBackground;
    key.correctKeyImage = correctKeyBackground;
    
    [key setIntId:keyIndex];
    
    [keys addObject:key];
    [[key label] setText:title];
    
    CGRect keyFrame = CGRectZero;
    keyFrame.size.width = ivoryWidth;
    keyFrame.size.height = self.frame.size.height;
    keyFrame.origin.x = ivoryWidth*ivoryIndex;
    [key setFrame:keyFrame];
    
    bool isCorrect = NO;
    for(NSNumber* correctKeyIndex in correctKeyIndexes){
        if(keyIndex == [correctKeyIndex integerValue]){
            [key setPressState:kCorrect];
            isCorrect = YES;
        }
    }
    if(!isCorrect){
        [key setPressState:kUnpressed];
    }
    [key setUserInteractionEnabled:NO];
    
    [self addSubview:key];
    [self sendSubviewToBack:key];
}

- (void) addEbonyKey:(int)keyIndex ebonyIndex:(int)ebonyIndex ivoryWidth:(float)ivoryWidth ebonyWidth:(float)ebonyWidth keyBackground:(UIImage*)keyBackground pressedKeyBackground:(UIImage*)pressedKeyBackground correctKeyBackground:(UIImage*)correctKeyBackground {
    
    EbonyKeyView* key = [[EbonyKeyView alloc] init];
    key.keyImage = keyBackground;
    key.pressedKeyImage = pressedKeyBackground;
    key.correctKeyImage = correctKeyBackground;
    
    [key setIntId:keyIndex];
    
    [keys addObject:key];
    
    CGRect keyFrame = CGRectZero;
    if (doubleEbonySize) {
        keyFrame.size.width = ebonyWidth*2;
    } else {
        keyFrame.size.width = ebonyWidth;
    }
    keyFrame.size.height = self.frame.size.height * EBONY_KEY_HEIGHT;
    keyFrame.origin.x = ivoryWidth*ebonyIndex - (ebonyWidth /2);
    [key setFrame:keyFrame];
    
    bool isCorrect = NO;
    for(NSNumber* correctKeyIndex in correctKeyIndexes){
        if(keyIndex == [correctKeyIndex integerValue]){
            [key setPressState:kCorrect];
            isCorrect = YES;
        }
    }
    if(!isCorrect){
        [key setPressState:kUnpressed];
    }
    [key setUserInteractionEnabled:NO];
    
    [self addSubview:key];
}

- (void) internalInit {
    self.multipleTouchEnabled = YES;
    [self setDoubleEbonySize:NO];
    [self setDelegate:nil];
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"keyboardLayout" ofType:@"plist"];
    [self setKeyNames:[NSArray arrayWithContentsOfFile:plistPath]];
    correctKeyIndexes = [[NSMutableArray alloc] init];
    
    [self setKeys:[NSMutableArray arrayWithCapacity:KEY_TOTAL]];
    [self setVisibleKeyRange:INITIAL_KEY_RANGE];
}

- (void) removeAllKeysFromView {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [[self keys] removeAllObjects];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self removeAllKeysFromView];
    
    int keyNameOffset = [self convertToKeynameOffset: visibleKeyRange.location];
    // Load Keys
    float ivoryWidth = self.frame.size.width/visibleKeyRange.length;
    
    UIImage* ivoryKeyBackground = self.ivoryKeyBackground;
    UIImage* ivoryPressedKeyBackground = self.ivoryPressedKeyBackground;
    UIImage* ivoryCorrectKeyBackground = self.ivoryCorrectKeyBackground;
    
    UIImage* ebonyKeyBackground = self.ebonyKeyBackground;
    UIImage* ebonyPressedKeyBackground = self.ebonyPressedKeyBackground;
    UIImage* ebonyCorrectKeyBackground = self.ebonyCorrectKeyBackground;
    
    // Special case first ebony key
    NSString* keyName = nil;
    if (keyNameOffset > 0) {
        keyName = keyNames[(keyNameOffset-1)];
        if ([keyName hasSuffix:@"s"]) {
            [self addEbonyKey:keyNameOffset-1 ebonyIndex:0 ivoryWidth:ivoryWidth ebonyWidth:ivoryWidth * EBONY_KEY_WIDTH keyBackground:ebonyKeyBackground pressedKeyBackground:ebonyPressedKeyBackground correctKeyBackground:ebonyCorrectKeyBackground];
        }
    }
    
    // Layout rest of keys in range
    int currentIvoryCount = 0;
    int currentKeyCount = 0;
    for (; currentIvoryCount < visibleKeyRange.length && (keyNameOffset + currentKeyCount) < [keyNames count]; currentKeyCount++) {
        int index = (keyNameOffset + currentKeyCount);
        keyName = keyNames[(keyNameOffset + currentKeyCount)];
        
        if ([keyName hasSuffix:@"s"]) {
            [self addEbonyKey:index ebonyIndex:currentIvoryCount ivoryWidth:ivoryWidth ebonyWidth:ivoryWidth * EBONY_KEY_WIDTH keyBackground:ebonyKeyBackground pressedKeyBackground:ebonyPressedKeyBackground correctKeyBackground:ebonyCorrectKeyBackground];
            
        } else {
            [self addIvoryKey:index ivoryIndex:currentIvoryCount ivoryWidth:ivoryWidth keyBackground:ivoryKeyBackground pressedKeyBackground:ivoryPressedKeyBackground correctKeyBackground:ivoryCorrectKeyBackground title:keyName];
            currentIvoryCount++;
        }
    }
    
    // Special case possible last ebony key
    int nextKeyIndex = (keyNameOffset+currentKeyCount);
    if (nextKeyIndex < [keyNames count]) {
        keyName = keyNames[nextKeyIndex];
        if ([keyName hasSuffix:@"s"]) {
            [self addEbonyKey:nextKeyIndex ebonyIndex:currentIvoryCount ivoryWidth:ivoryWidth ebonyWidth:ivoryWidth * EBONY_KEY_WIDTH keyBackground:ebonyKeyBackground pressedKeyBackground:ebonyPressedKeyBackground correctKeyBackground:ebonyCorrectKeyBackground];
        }
    }
}

- (id) initWithCoder:(NSCoder *)aCoder {
    if( self = [super initWithCoder:aCoder]){
        [self internalInit];
    }
    return self;
}
               
- (id) initWithFrame:(CGRect)rect{
    if(self = [super initWithFrame:rect]){
        [self internalInit];
    }
    return self;
}

-(void)shiftToKeyIndex:(int)keyIndex lowerBound:(int)lowestKey upperBound:(int)highestKey{
    float centerPercentage = keyIndex/(float)KEY_TOTAL;
    float offsetPercentage = self.visibleKeyRange.length/(float)IVORY_KEY_TOTAL;
    float keyboardPercentage = centerPercentage - (offsetPercentage/2);
    NSRange newRange = self.visibleKeyRange;
    newRange.location = (keyboardPercentage * IVORY_KEY_TOTAL) + 1;//round up
    int newLowestKey = [self convertToKeynameOffset: newRange.location];
    int newHighestKey = [self convertToKeynameOffset: newRange.location + newRange.length];
    if(newLowestKey > lowestKey){
        newRange.location--;
        //this pretty much only needs to be called by Gbmajor7
        newHighestKey = [self convertToKeynameOffset: newRange.location + newRange.length - 1];
    }
    if(newHighestKey < highestKey){
        newRange.location++;
    }
    [self setVisibleKeyRange:newRange];
    [self setNeedsLayout];
}
-(KeyBase*)keyBaseFromKeyIndex:(int)keyIndex{
     int firstVisibleWhiteKey = [self convertToKeynameOffset:self.visibleKeyRange.location];
     BOOL isFirstVisibleWhiteKeyCorF = firstVisibleWhiteKey % 12 == 3 || firstVisibleWhiteKey % 12 == 8;
    /*
     if the lowest note shown is a black key, firstVisibleWhiteKey doesn't take that into account
     therefore, if the firstVisibleKey is a C or an F, then it doesn't need increment an additional time
     otherwise increment
     */
    int visibleKeyIndex = keyIndex - firstVisibleWhiteKey;
    if(!isFirstVisibleWhiteKeyCorF){
        visibleKeyIndex++;
    }
    if(visibleKeyIndex < 0 || visibleKeyIndex >= self.keys.count){
        //should never happen
        return self.keys[0];
    }
    return self.keys[visibleKeyIndex];
    
}

-(void)setCorrectKey:(int)keyIndex{
    [correctKeyIndexes addObject:@(keyIndex)];
    KeyBase* correctKey = [self keyBaseFromKeyIndex:keyIndex];
    [correctKey setPressState:kCorrect];
}

-(void)resetCorrectKeys{
    for(NSNumber* correctKeyIndex in correctKeyIndexes){
        int correctKeyInteger = [correctKeyIndex integerValue];
        KeyBase* correctKey = [self keyBaseFromKeyIndex:correctKeyInteger];
        [correctKey setPressState:kUnpressed];
    }
    [correctKeyIndexes removeAllObjects];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet* allTouches = [touches setByAddingObjectsFromSet:[event touchesForView:self]];
    
    NSMutableSet* pressedKeys = [NSMutableSet setWithCapacity:0];

    for (int keyIndex = 0; keyIndex < [keys count]; keyIndex++) {
        KeyBase* key = keys[keyIndex];
        BOOL keyIsPressed = NO;
        for (UITouch* touch in allTouches) {
            CGPoint location = [touch locationInView:self];
            if(CGRectContainsPoint(key.frame, location)) 
            {
                BOOL ignore = NO;
                
                if ([key isKindOfClass:[IvoryKeyView class]]) {
                    if (keyIndex > 0) {
                        UIImageView* previousKey = keys[keyIndex-1];
                        
                        if([previousKey isKindOfClass:[EbonyKeyView class]] && CGRectContainsPoint([previousKey frame], location)) {
                            ignore = YES;
                        }
                    }
                    
                    if (keyIndex < [keys count]-1) {
                        
                        UIImageView* nextKey = keys[keyIndex+1];
                        if ([nextKey isKindOfClass:[EbonyKeyView class]]) {
                            if(CGRectContainsPoint([nextKey frame], location)) {
                                ignore = YES;
                            }
                        }
                    }
                }
                
                if (ignore == NO) {
                    keyIsPressed = YES;
                    if(key.pressState != kPressed){
                        if (key.pressState == kUnpressed){
                            [key setPressState:kPressed];
                        }
                        if (self.delegate != nil) {
                            [pressedKeys addObject:[key keyId]];
                        }
                    }
                }
            }
        }
        
        if (keyIsPressed == NO && key.isHighlighted == YES) {
            [key setPressState:kUnpressed];
        }
    }
    
    if (self.delegate != nil && [pressedKeys count] > 0) {
        [self.delegate keysPressed:pressedKeys];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [touches setByAddingObjectsFromSet:[event touchesForView:self]];
    
    int i = 0;
    for (KeyBase* key in keys) {
        for (UITouch* touch in allTouches) {
            CGPoint location = [touch locationInView:self];
            if(CGRectContainsPoint(key.frame, location)) 
            {
                if ([touch phase] == UITouchPhaseEnded || [touch phase] == UITouchPhaseCancelled) {
                    if(key.pressState != kCorrect){
                        [key setPressState:kUnpressed];
                    }
                } else {
                    NSLog(@"Unhandled touch phase: %d", [touch phase] );
                }
            }
        }
        
        i++;
    }
    [self.delegate keysLifted];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"############ TODO: handles keyboard::touchesCancelled");
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}

@end
