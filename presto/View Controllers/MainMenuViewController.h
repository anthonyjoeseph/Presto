//
//  MainMenuViewController.h
//  Presto
//
//  Created by AnthonyGabriele on 7/25/13.
//  Copyright (c) 2013 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController{
    IBOutlet UILabel *mainMenu;
    IBOutlet UIButton *play;
    IBOutlet UIButton *howTo;
    IBOutlet UIButton *reportCard;
    IBOutlet UIButton *credits;
}

@property (nonatomic, strong) UILabel *mainMenu;
@property (nonatomic, strong) UIButton *play;
@property (nonatomic, strong) UIButton *howTo;
@property (nonatomic, strong) UIButton *reportCard;
@property (nonatomic, strong) UIButton *credits;
@end
