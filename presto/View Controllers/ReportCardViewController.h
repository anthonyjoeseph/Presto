//
//  ReportCardViewController.h
//  Presto
//
//  Created by AnthonyGabriele on 7/3/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportCardViewController : UIViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UILabel* prestoReportCard;
@property (nonatomic, weak) IBOutlet UIButton* mainMenu;

@end
