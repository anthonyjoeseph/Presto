//
//  ReportCardViewController.m
//  Presto
//
//  Created by AnthonyGabriele on 7/3/14.
//  Copyright (c) 2014 PianoForte. All rights reserved.
//

#import "ReportCardViewController.h"
#import "GamePersistence.h"
#import "ReportCardData.h"

@interface ReportCardViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView* collectionView;
@property (nonatomic, weak) ReportCardData* reportCardData;
@property (nonatomic, weak) NSArray* gameSessions;

@end

@implementation ReportCardViewController
@synthesize prestoReportCard;
@synthesize mainMenu;

@synthesize collectionView;
@synthesize reportCardData;
@synthesize gameSessions;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.prestoReportCard.font = [UIFont fontWithName:@"GothamLight" size:23];
    self.mainMenu.titleLabel.font = [UIFont fontWithName:@"GothamLight" size:23];
    
    self.reportCardData = [GamePersistence sharedInstance].reportCardData;
    self.gameSessions = [self.reportCardData firstTenDates];
}

#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 10;
}

-(NSInteger)collectionView:(UICollectionView*)collView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell*)collectionView:(UICollectionView*)collView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    int reportTypeIndex = indexPath.row % 5;
    UICollectionViewCell *cell;
    if(reportTypeIndex == 4){
        cell = [collView dequeueReusableCellWithReuseIdentifier:@"SmallerCell" forIndexPath:indexPath];
    }else{
        cell = [collView dequeueReusableCellWithReuseIdentifier:@"NormalCell" forIndexPath:indexPath];
    }
    UILabel* cellLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    cellLabel.textAlignment = NSTextAlignmentCenter;
    cellLabel.font = [UIFont fontWithName:@"GothamLight" size:15];
    [cell addSubview:cellLabel];
    if(indexPath.section < self.gameSessions.count){
        NSDate* gameDate = (NSDate*)self.gameSessions[indexPath.section];
        
        switch (reportTypeIndex) {
            case 0:{
                NSDateFormatter* dateFormat = [NSDateFormatter new];
                dateFormat.dateFormat = @"MM/dd/yy";
                cellLabel.text = [dateFormat stringFromDate:gameDate];
                break;
            }
            case 1:{
                int gameTime = [self.reportCardData timeForDate:gameDate];
                cellLabel.text = [NSString stringWithFormat:@"%d", gameTime];
                break;
            }
            case 2:{
                int scoreNumerator = [self.reportCardData scoreNumeratorForDate:gameDate];
                int scoreDenominator = [self.reportCardData scoreDenominatorForDate:gameDate];
                cellLabel.text = [NSString stringWithFormat:@"%d/%d", scoreNumerator, scoreDenominator];
                break;
            }
            case 3:{
                float scoreNumerator = [self.reportCardData scoreNumeratorForDate:gameDate];
                float scoreDenominator =[self.reportCardData scoreDenominatorForDate:gameDate];
                float virtuosity;
                if(scoreDenominator != 0){
                    virtuosity = (scoreNumerator/scoreDenominator) * 100;
                }else{
                    virtuosity = 0;
                }
                int roundedVirtuosity = roundf(virtuosity);
                cellLabel.text = [NSString stringWithFormat:@"%d%%", roundedVirtuosity];
                break;
            }
            case 4:{
                int time = [self.reportCardData pausesForDate:gameDate];
                cellLabel.text = [NSString stringWithFormat:@"%d", time];
                break;
            }
        }
    }
    
    if(indexPath.section % 2 == 0){
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        //specific light blue color
        float red = 199/255.0f;
        float green = 235/255.0f;
        float blue = 251/255.0f;
        cell.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    }
    return cell;
}

@end
