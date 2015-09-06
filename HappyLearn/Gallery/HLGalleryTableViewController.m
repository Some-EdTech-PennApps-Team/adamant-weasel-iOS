//
//  HLGalleryTableViewController.m
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import "HLGalleryTableViewController.h"
#import "HLGalleryTableViewCell.h"

@interface HLGalleryTableViewController ()

@property (nonatomic, strong) NSArray *challengeSubmissions;
@end

@implementation HLGalleryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigaionBarWithTitle:@"Submissions"];
    
    self.challengeSubmissions = [NSArray new];

    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    [[ParsingHandle sharedParsing] getSubmissionsOfChallengeInID:self.channelId ToCompletion:^(NSArray *array) {
        
        self.challengeSubmissions = array;
        [self.tableView reloadData];
    }];
    
//    //self.tableView.tableHeaderView = self.mapController.mapView;
    self.tableView.tableHeaderView.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), 60.0f);
    
}

- (IBAction)doneButtonPressed:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.challengeSubmissions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLGalleryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGalleryCellIdentifier forIndexPath:indexPath];
    
    ChallengeSubmission *submission = self.challengeSubmissions[indexPath.row];
    
    cell.submissionImageView.image = nil;
    cell.submissionImageView.file = submission.submissionImage;
    [cell.submissionImageView loadInBackground];
    
    PFUser *user = submission.user;
    cell.authorNameLabel.text = user.username;
    
    return cell;
}


@end
