//
//  KeyboardView.h
//  MusicNotes
//
//  Created by Christopher Wilson on 1/16/11.
//  Copyright 2011 Yepher.com All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyboardViewDelegate
- (void) keysPressed:(NSSet*) keys;
- (void) keysLifted;
@end

#define KEY_TOTAL 88
#define IVORY_KEY_TOTAL 52
#define EBONY_KEY_TOTAL  36

#define INITIAL_KEY_RANGE NSMakeRange(23, 9)

#define EBONY_KEY_WIDTH .8
#define EBONY_KEY_HEIGHT .5



@interface KeyboardView : UIView {
    BOOL doubleEbonySize;
    
    NSRange visibleKeyRange;
    
    NSArray* keyNames;
    NSMutableArray* keys;
    NSMutableArray* correctKeyIndexes;
    
    UIImage* ivoryKeyBackground;
    UIImage* ivoryPressedKeyBackground;
    UIImage* ivoryCorrectKeyBackground;
    UIImage* ebonyKeyBackground;
    UIImage* ebonyPressedKeyBackground;
    UIImage* ebonyCorrectKeyBackground;
}

-(void)shiftToKeyIndex:(int)keyIndex lowerBound:(int)lowestKey upperBound:(int)highestKey;
-(void)setCorrectKey:(int)keyIndex;
-(void)resetCorrectKeys;

@property (nonatomic) BOOL doubleEbonySize;
@property (nonatomic, weak) id <KeyboardViewDelegate> delegate;
@property (nonatomic) NSRange visibleKeyRange;

@property (nonatomic, strong) NSArray* keyNames;
@property (nonatomic, strong) NSMutableArray* keys;
@property (nonatomic, strong) UIImage* ivoryKeyBackground;
@property (nonatomic, strong) UIImage* ivoryPressedKeyBackground;
@property (nonatomic, strong) UIImage* ivoryCorrectKeyBackground;
@property (nonatomic, strong) UIImage* ebonyKeyBackground;
@property (nonatomic, strong) UIImage* ebonyPressedKeyBackground;
@property (nonatomic, strong) UIImage* ebonyCorrectKeyBackground;

@end
