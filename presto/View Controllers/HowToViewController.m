//
//  HowToViewController.m
//  Presto
//
//  Created by AnthonyGabriele on 11/17/13.
//  Copyright (c) 2013 PianoForte. All rights reserved.
//

#import "HowToViewController.h"

@interface HowToViewController ()

@end

@implementation HowToViewController
@synthesize header;
@synthesize mainMenu;
@synthesize firstLabel;
@synthesize secondLabel;
@synthesize thirdLabel;
@synthesize fourthLabel;
@synthesize backButton;
@synthesize nextButton;
@synthesize animation;
@synthesize animationFrames;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.header.font = [UIFont fontWithName:@"GothamLight" size:23];
    self.mainMenu.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:23];
    self.firstLabel.font = [UIFont fontWithName:@"GothamBook" size:20];
    self.secondLabel.font = [UIFont fontWithName:@"GothamBook" size:20];
    self.thirdLabel.font = [UIFont fontWithName:@"GothamBook" size:20];
    self.fourthLabel.font = [UIFont fontWithName:@"GothamBook" size:20];
    firstTexts = @[@"Your brain is a highway of nerves.",
                   @"When you think, that thought travels through your brain.",
                   @"Over time, pathways begin to strengthen and grow.",
                   @"In the brain of a piano virtuoso, the musical pathways are so strong"];
    secondTexts = @[@"",
                    @"",
                    @"",
                    @"that the travel time is almost instant!"];
    thirdTexts = @[@"",
                   @"As you think a thought repeatedly, that thought",
                   @"The chemistry in your brain actually changes",
                   @"They no longer think, they just do!"];
    fourthTexts = @[@"",
                    @"takes the same journey across your brain again and again...",
                    @"the more times you think a thought.",
                    @""];
    pageIndex = 0;
    self.firstLabel.text = firstTexts[pageIndex];
    self.secondLabel.text = secondTexts[pageIndex];
    self.thirdLabel.text = thirdTexts[pageIndex];
    self.fourthLabel.text = fourthTexts[pageIndex];
    NSArray *animation1 = @[[UIImage imageNamed:@"1Frame1.png"],
                           [UIImage imageNamed:@"1Frame2.png"],
                           [UIImage imageNamed:@"1Frame3.png"],
                           [UIImage imageNamed:@"1Frame4.png"],
                           [UIImage imageNamed:@"1Frame5.png"],
                           [UIImage imageNamed:@"1Frame6.png"],
                           [UIImage imageNamed:@"1Frame7.png"]];
    NSArray *animation2 = @[[UIImage imageNamed:@"2Frame1.png"],
                           [UIImage imageNamed:@"2Frame2.png"],
                           [UIImage imageNamed:@"2Frame3.png"],
                           [UIImage imageNamed:@"2Frame4.png"],
                           [UIImage imageNamed:@"2Frame5.png"],
                           [UIImage imageNamed:@"2Frame6.png"],
                           [UIImage imageNamed:@"2Frame7.png"],
                           [UIImage imageNamed:@"2Frame8.png"]];
    NSArray *animation3 = @[[UIImage imageNamed:@"3Frame1.png"],
                            [UIImage imageNamed:@"3Frame2.png"],
                            [UIImage imageNamed:@"3Frame3.png"],
                            [UIImage imageNamed:@"3Frame4.png"]];
    NSArray *animation4 = @[[UIImage imageNamed:@"4Frame1.png"],
                           [UIImage imageNamed:@"4Frame2.png"],
                           [UIImage imageNamed:@"4Frame3.png"],
                           [UIImage imageNamed:@"4Frame4.png"]];
    self.animationFrames = @[animation1, animation2, animation3, animation4];
    self.animation.animationImages = self.animationFrames[pageIndex];
    self.animation.animationDuration = 2.0;
    [self.animation startAnimating];
}

-(IBAction)advance:(id)sender{
    bool segued = NO;
    if(sender == self.backButton){
        if(pageIndex == 0){
            [self performSegueWithIdentifier:@"howToToMainMenu" sender:self];
            segued = YES;
        }
        pageIndex--;
    }
    if(sender == self.nextButton){
        if(pageIndex == 3){
            [self performSegueWithIdentifier:@"howToToHowToFinale" sender:self];
            segued = YES;
        }
        pageIndex++;
    }
    if(!segued){
        self.firstLabel.text = firstTexts[pageIndex];
        self.secondLabel.text = secondTexts[pageIndex];
        self.thirdLabel.text = thirdTexts[pageIndex];
        self.fourthLabel.text = fourthTexts[pageIndex];
        if(pageIndex == 2){
            self.thirdLabel.font = [UIFont fontWithName:@"GothamBold" size:20];
        }else{
            self.thirdLabel.font = [UIFont fontWithName:@"GothamBook" size:20];
        }
        [self.animation stopAnimating];
        self.animation.animationImages = self.animationFrames[pageIndex];
        self.animation.animationDuration = 2.0;
        [self.animation startAnimating];
    }
}

@end
