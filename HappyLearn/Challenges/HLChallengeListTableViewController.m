//
//  HLChallengeListTableViewController.m
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import "HLChallengeListTableViewController.h"
#import "HLChallengeTableViewCell.h"
#import "HLChallengeDetailTableViewController.h"

@interface HLChallengeListTableViewController ()

@property (strong, nonatomic) NSMutableArray *liveChallenges;
@property (strong, nonatomic) NSMutableArray *pastChallenges;

@end

@implementation HLChallengeListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 300.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
 
    [self setupNavigaionBarWithTitle:self.channel.channelName];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setBackgroundBlur];
    
    [SVProgressHUD show];
    
    [[ParsingHandle sharedParsing] getChallengesWithChannelID:self.channel.objectId ToCompletion:^(NSArray *array) {
        self.liveChallenges = [NSMutableArray new];
        self.pastChallenges = [NSMutableArray new];
        
        for (PFObject *obj in array) {
            
            Challenge *challenge = [[ParsingHandle sharedParsing] parseChallengeToChallengeObject:obj];
            
            if ([challenge.expires compare:[NSDate date]] == NSOrderedAscending) {
                //the challenges are expired.
                
                [self.pastChallenges addObject:challenge];
            }
            else{
                //the challenges are live.
                [self.liveChallenges addObject:challenge];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            
        });
        
    }];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return HLChallengeTypeCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    NSInteger rowNumber = 0;
    switch (section) {
        case HLChallengeTypeLive:
            rowNumber = self.liveChallenges.count;
            break;
        case HLChallengeTypePast:
            rowNumber = self.pastChallenges.count;
            break;
        
        default:
            break;
    }
    
    return rowNumber;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLChallengeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChallengeObjectCellIdentifier forIndexPath:indexPath];
    Challenge *challenge = nil;
    switch (indexPath.section) {
        case HLChallengeTypeLive:
        {
            challenge = self.liveChallenges[indexPath.row];
            NSInteger number = [self hoursBetween:[NSDate date] and:challenge.expires];
            cell.timeCounterLabel.text = [NSString stringWithFormat:@"%ld Hours Left", (long)number];
        }
            break;
        case HLChallengeTypePast:
        {
            challenge = self.pastChallenges[indexPath.row];
            cell.timeCounterLabel.text = @"expired";
        }
            break;
        default:
            break;
    }
    
    cell.challengeTitleLabel.text = challenge.challengeTitle;
    cell.challengeDescriptionLabel.text = challenge.promptText;

    return cell;
}

- (NSInteger)hoursBetween:(NSDate *)firstDate and:(NSDate *)secondDate {
    NSUInteger unitFlags = NSCalendarUnitHour;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:unitFlags fromDate:firstDate toDate:secondDate options:0];
    return [components hour]+1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *sectionName;
    
    switch (section) {
        case HLChallengeTypeLive:
            sectionName = @"Live Challenges";
            break;
        case HLChallengeTypePast:
            sectionName = @"Past Challenges";
        default:
            break;
    }
    return sectionName;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kMainStoryBoardName bundle:nil];
    HLChallengeDetailTableViewController *challengeDetailVC = [storyboard instantiateViewControllerWithIdentifier:kChallengeDetailViewControllerIdentifier];
    
    if (indexPath.section == HLChallengeTypeLive) {
        challengeDetailVC.challenge = self.liveChallenges[indexPath.row];
    }
    else
    {
        challengeDetailVC.challenge = self.pastChallenges[indexPath.row];
    }
    
    [self.navigationController pushViewController:challengeDetailVC animated:YES];
    
}


@end
