//
//  CreditsViewController.h
//  Presto
//
//  Created by AnthonyGabriele on 1/14/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditsViewController : UIViewController{
    IBOutlet UIButton *mainMenu;
    
    IBOutlet UILabel *credits;
    
    IBOutlet UILabel *presto;
    IBOutlet UILabel *deadlyOctopusllc;
    
    IBOutlet UILabel *conceptualDesign;
    IBOutlet UILabel *developers;
    IBOutlet UILabel *graphicDesign;
    IBOutlet UILabel *ceo;
    IBOutlet UILabel *cfoAccounting;
    IBOutlet UILabel *legalrepresentation;
    
    IBOutlet UILabel *santinoOne;
    IBOutlet UILabel *anthonySaurabh;
    IBOutlet UILabel *jessica;
    IBOutlet UILabel *santinoTwo;
    IBOutlet UILabel *christine;
    IBOutlet UILabel *ericaHinman;
    IBOutlet UILabel *kattel;
}

@property (nonatomic, strong) UIButton *mainMenu;

@end
