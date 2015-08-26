//
//  ColdOpenViewController.h
//  Presto
//
//  Created by AnthonyGabriele on 1/14/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColdOpenViewController : UIViewController{
    IBOutlet UIButton *playGame;
}

-(IBAction)buttonPressed:(id)sender;

@property (nonatomic, strong) UIButton *playGame;

@end
