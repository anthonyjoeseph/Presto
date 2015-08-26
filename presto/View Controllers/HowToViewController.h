//
//  HowToViewController.h
//  Presto
//
//  Created by AnthonyGabriele on 11/17/13.
//  Copyright (c) 2013 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowToViewController : UIViewController{
    IBOutlet UILabel *header;
    IBOutlet UIButton *mainMenu;
    IBOutlet UILabel *firstLabel;
    IBOutlet UILabel *secondLabel;
    IBOutlet UILabel *thirdLabel;
    IBOutlet UILabel *fourthLabel;
    IBOutlet UIButton *backButton;
    IBOutlet UIButton *nextButton;
    IBOutlet UIImageView *animation;
    NSArray *firstTexts;
    NSArray *secondTexts;
    NSArray *thirdTexts;
    NSArray *fourthTexts;
    NSArray *animationFrames;
    int pageIndex;
}

-(IBAction)advance:(id)sender;

@property (nonatomic, strong) UILabel *header;
@property (nonatomic, strong) UIButton *mainMenu;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *thirdLabel;
@property (nonatomic, strong) UILabel *fourthLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIImageView *animation;
@property (nonatomic, strong) NSArray *animationFrames;

@end
