//
//  GameViewController.m
//  Presto
//
//  Created by AnthonyGabriele on 7/15/13.
//  Copyright (c) 2013 PianoForte. All rights reserved.
//


#import "GameViewController.h"
#import "SoundEffect.h"
#import "ALSource.h"
#import "QuartzCore/CALayer.h"
#import "StatisticsViewController.h"
#import "NSTimer+Pause.h"

@interface GameViewController ()

@property (nonatomic, strong) GameModel *gameModel;

@property (nonatomic, strong) IBOutlet UILabel* countdownLabel;
@property (nonatomic, strong) IBOutlet UIImageView *countdownBackdrop;
@property (nonatomic, strong) IBOutlet UIImageView *letGamesBegin;

@property (nonatomic, strong) IBOutlet KeyboardView *keyboard;

@property (nonatomic, strong) IBOutlet KeyboardView* chordPreview;

@property (nonatomic, strong) IBOutlet UIButton* gamePause;
@property (nonatomic, strong) IBOutlet UIButton* gameMainMenu;

@property (nonatomic, strong) IBOutlet UILabel* timeLabel;
@property (nonatomic, strong) IBOutlet UILabel* scoreLabel;
@property (nonatomic, strong) IBOutlet UIView* coverView;
@property (nonatomic, strong) IBOutlet UIImageView *flashcard;

@end

@implementation GameViewController
@synthesize gameModel;

@synthesize countdownLabel;
@synthesize countdownBackdrop;
@synthesize letGamesBegin;

@synthesize keyboard;

@synthesize chordPreview;

@synthesize gamePause;
@synthesize gameMainMenu;

@synthesize timeLabel;
@synthesize scoreLabel;
@synthesize coverView;
@synthesize flashcard;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gameModel = [[GameModel alloc] init];
    self.gameModel.delegate = self;
    
    [self setupCountdown];
    [self setupKeyboard];
    [self setupChordPreview];
    [self setupButtons];
    [self setupFlashcard];
    
    firstRun = YES;
}

#pragma mark Setup

-(void)setupCountdown{
    countdownNumber = 4;
    self.countdownLabel.font = [UIFont fontWithName:@"GothamLight" size:350];
    self.countdownLabel.text = @"";
    self.countdownLabel.hidden = YES;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdownTimerTick:) userInfo:nil repeats:YES];
}

-(void)setupKeyboard{
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"keyboardLayout" ofType:@"plist"];
    NSArray* names = [NSArray arrayWithContentsOfFile:plistPath];
    audio = [NSMutableArray arrayWithCapacity:KEY_TOTAL];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    float newVolume = [prefs floatForKey:@"Volume"];
    
    // Load Audio
    for (int i = 0; i < KEY_TOTAL; i++) {
        NSURL* filePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:names[i] ofType:@"aif"]];
        SoundEffect* pianoSound = [[SoundEffect alloc] initWithURL:filePath];
        [pianoSound newVolume: newVolume];
        [audio addObject:pianoSound];
    }
    
    self.keyboard.delegate = self;
    self.keyboard.doubleEbonySize = NO;
    self.keyboard.ivoryKeyBackground = [UIImage imageNamed:@"ivory_key_up.png"];
    self.keyboard.ivoryPressedKeyBackground = [UIImage imageNamed:@"ivory_key_pressed.png"];
    self.keyboard.ivoryCorrectKeyBackground = [UIImage imageNamed:@"ivory_key_blue.png"];
    self.keyboard.ebonyKeyBackground = [UIImage imageNamed:@"ebony_key_up.png"];
    self.keyboard.ebonyPressedKeyBackground = [UIImage imageNamed:@"ebony_key_pressed.png"];
    self.keyboard.ebonyCorrectKeyBackground = [UIImage imageNamed:@"ebony_key_blue.jpg"];
}

-(void)setupChordPreview{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if([prefs boolForKey:@"Training Wheels"]){
        self.chordPreview.translatesAutoresizingMaskIntoConstraints = YES;
        
        self.chordPreview.delegate = nil;
        self.chordPreview.doubleEbonySize = NO;
        self.chordPreview.ivoryKeyBackground = [UIImage imageNamed:@"ivory_key_up.png"];
        self.chordPreview.ivoryPressedKeyBackground = [UIImage imageNamed:@"ivory_key_up.png"];
        self.chordPreview.ivoryCorrectKeyBackground = [UIImage imageNamed:@"ivory_key_blue.png"];
        self.chordPreview.ebonyKeyBackground = [UIImage imageNamed:@"ebony_key_up.png"];
        self.chordPreview.ebonyPressedKeyBackground = [UIImage imageNamed:@"ebony_key_up.png"];
        self.chordPreview.ebonyCorrectKeyBackground = [UIImage imageNamed:@"ebony_key_blue.jpg"];
    }else{
        self.chordPreview.hidden = YES;
    }
}

-(void)setupButtons{
    self.gamePause.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:30];
    self.gameMainMenu.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:30];
    
    mainMenuAlert = [[UIAlertView alloc] initWithTitle:@"Main Menu" message:@"Quit to the main menu?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    pauseAlert = [[UIAlertView alloc] initWithTitle:@"Paused" message:@"" delegate:self cancelButtonTitle:@"RESUME" otherButtonTitles: nil];
}

-(void)setupFlashcard{
    [self.timeLabel setFont:[UIFont fontWithName:@"GothamLight" size:25]];
    [self.scoreLabel setFont:[UIFont fontWithName:@"GothamLight" size:25]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(![prefs boolForKey:@"Training Wheels"]){
        self.coverView.hidden = YES;
    }
    
    //add a shadow
    self.flashcard.layer.shadowColor = [UIColor blackColor].CGColor;
    self.flashcard.layer.shadowOffset = CGSizeMake(0, 5);
    self.flashcard.layer.shadowOpacity = 1;
    self.flashcard.layer.shadowRadius = 5.0;
    self.flashcard.clipsToBounds = NO;
    
    //hide it at first
    self.flashcard.alpha = 0.0;
}

#pragma mark Countdown

-(void)countdownTimerTick:(id)sender{
    switch (countdownNumber) {
        case 4:
            [self.letGamesBegin removeFromSuperview];
            self.countdownLabel.text = @"3";
            self.countdownLabel.hidden = NO;
            countdownNumber = 3;
            break;
        case 3:
            self.countdownLabel.text = @"2";
            countdownNumber = 2;
            break;
        case 2:
            self.countdownLabel.text = @"1";
            countdownNumber = 1;
            break;
        case 1:
            [sender invalidate];
            [self countdownDone];
            break;
    }
}

-(void)countdownDone{
    [self.countdownLabel removeFromSuperview];
    //assumes keyboard starts off frame
    CGFloat keyboardHeight = self.keyboard.frame.size.height;
    //main screen width and height are switched because it's in portrait view
    CGFloat mainScreenHeight = [[UIScreen mainScreen] bounds].size.width;
    
    CGPoint hiddenCountdownCenter = CGPointMake(self.countdownBackdrop.center.x, -mainScreenHeight);
    CGPoint visibleKeyboardCenter = CGPointMake(self.keyboard.center.x,
                                                mainScreenHeight - (keyboardHeight/2));
    CGPoint hiddenKeyboardCenter = CGPointMake(visibleKeyboardCenter.x,
                                               visibleKeyboardCenter.y + keyboardHeight);
    self.keyboard.center = hiddenKeyboardCenter;
    
    [self.gameModel start];
    
    //flashcard fade in
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.5];
    self.flashcard.alpha = 1.0;
    [UIView commitAnimations];
    
    //animate the keyboard in
    [UIView animateWithDuration:0.5
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.countdownBackdrop.center = hiddenCountdownCenter;
                         self.keyboard.center = visibleKeyboardCenter;
                     }
                     completion:^(BOOL finished){
                         [self.countdownBackdrop removeFromSuperview];
                     }];
}

#pragma mark Keyboard delegate

-(void) keysPressed:(NSSet *)keys{
    for (NSNumber* keyIndex in keys) {
        int keyIndexInt = [keyIndex intValue];
        if (KEY_TOTAL > keyIndexInt) {
            [audio[keyIndexInt] playSound];
        }
    }
    [self.gameModel keysPressed:keys];
}
-(void)keysLifted{
    [self.gameModel keysLifted];
}

#pragma mark Game Model delegate

-(void)correctKeyPressed:(int)key{
    [self.keyboard setCorrectKey:key];
}

-(void)resetKeys{
    [self.keyboard resetCorrectKeys];
}

-(void)shiftToKeyIndex:(int)keyIndex lowerBound:(int)lowestKey upperBound:(int)highestKey{
    [self.keyboard shiftToKeyIndex:keyIndex lowerBound:lowestKey upperBound:highestKey];
}
-(void)newChordNotes:(NSArray *)notes{
    [self.chordPreview resetCorrectKeys];
    self.chordPreview.visibleKeyRange = self.keyboard.visibleKeyRange;
    for(NSNumber* noteID in notes){
        [self.chordPreview setCorrectKey: [noteID intValue]];
    }
    [self.chordPreview setNeedsLayout];
}

-(void)newFlashcardImage:(UIImage *)newImage{
    if(!firstRun){
        [UIImageView beginAnimations:nil context:nil];
        //change to set the time
        [UIImageView setAnimationDuration:.5];
        [UIImageView setAnimationBeginsFromCurrentState:YES];
        [UIImageView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.flashcard cache:YES];
        
        [self.flashcard setImage:newImage];
        [UIImageView commitAnimations];
    }else{
        firstRun = NO;
        [self.flashcard setImage:newImage];
    }
}
-(void)gameOver{
    [UIView beginAnimations:@"fade out" context:nil];
    [UIView setAnimationDuration:0.5];
    self.flashcard.alpha = 0.0;
    [UIView commitAnimations];
    
    [self performSegueWithIdentifier:@"gameToStatistics" sender:self];
    
}
-(void)updateMinutesLeft:(int)minutesLeft secondsLeft:(int)secondsLeft{
    if(secondsLeft < 10){
        [self.timeLabel setText:[NSString stringWithFormat:@"%d:0%d", minutesLeft, secondsLeft]];
    }else{
        [self.timeLabel setText:[NSString stringWithFormat:@"%d:%d", minutesLeft, secondsLeft]];
    }
}
-(void)updateScore:(int)scoreVal{
    [self.scoreLabel setText:[NSString stringWithFormat:@"%d", scoreVal]];
}

#pragma mark Transitions

-(IBAction)mainMenu:(id)sender{
    [mainMenuAlert show];
}
-(IBAction)pause:(id)sender{
    [self.gameModel pause];
    [pauseAlert show];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"gameToStatistics"]){
        StatisticsViewController *controller = (StatisticsViewController *)segue.destinationViewController;
        controller.numCorrectNotes = self.gameModel.numCorrectNotes;
        controller.numIncorrectNotes = self.gameModel.numIncorrectNotes;
        controller.numPauses = self.gameModel.numPauses;
    }
}

#pragma mark Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == mainMenuAlert){
        if(buttonIndex == 0){
            [self performSegueWithIdentifier:@"gameToMainMenu" sender:self];
        }
    }else if(alertView == pauseAlert){
        [pauseAlert dismissWithClickedButtonIndex:0 animated:YES];
        [self.gameModel resume];
    }
}

@end
