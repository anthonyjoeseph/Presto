//
//  KeyBase.h
//  MusicNotes
//
//  Created by Christopher Wilson on 1/19/11.
//  Copyright 2011 Yepher.com All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kUnpressed,
    kPressed,
    kCorrect
} PressState;

@interface KeyBase : UIImageView {
    UILabel* label;
    
    BOOL helpColorHidden;
    
    BOOL helpTextHidden;
    
    NSNumber* keyId;
    
    PressState pressState;
    UIImage *keyImage;
    UIImage *pressedKeyImage;
    UIImage *correctKeyImage;
}

-(void)setPressState:(PressState)newPressState;

@property (nonatomic, strong) UILabel* label;

@property (nonatomic) BOOL helpColorHidden;

@property (nonatomic) BOOL helpTextHidden;

@property (nonatomic, strong) NSNumber* keyId;

@property (nonatomic) PressState pressState;

@property (nonatomic, strong) UIImage *keyImage;

@property (nonatomic, strong) UIImage *pressedKeyImage;

@property (nonatomic, strong) UIImage *correctKeyImage;


- (void) setIntId: (int) intKeyId;
+ (UIColor*) colorForNote: (unichar) note;

@end
