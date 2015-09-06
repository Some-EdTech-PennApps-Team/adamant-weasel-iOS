//
//  HLChannelTableViewController.m
//  HappyLearn
//
//  Created by Yifan Xiao on 9/4/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import "SCLoginViewController.h"
#import "SCSignUpViewController.h"
#import "HLChannelTableViewController.h"
#import "HLChannelTableViewCell.h"
#import "HLChallengeListTableViewController.h"

@interface HLChannelTableViewController ()

@property (nonatomic, strong) NSMutableArray *channels;

@property (retain, nonatomic) ViewController *vc;

@end

@implementation HLChannelTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vc = [[ViewController alloc] init];
    [self presentViewController:self.vc animated:NO completion:nil];
    [self.view addSubview:self.vc.view];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadChannelData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self handleLogginAndSignUp];
    
}

- (IBAction)exitButtonTapped:(id)sender {
 
    [PFUser logOut];
    
    [self handleLogginAndSignUp];
}

/**
 *  query the data from Parse to load the table
 */
- (void)loadChannelData
{
    
    if (![PFUser currentUser]) {
        return;
    }
    
        [[ParsingHandle sharedParsing] findAllChannelsToCompletion:^(NSArray *array) {
            
            self.channels = [NSMutableArray new];
            for (PFObject *obj in array) {
                Channel *channelObj = [[ParsingHandle sharedParsing] parseChannelToChannelObject:obj];
                
                [self.channels addObject:channelObj];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tableViewdidLoad" object:self];
                [self.tableView reloadData];
                
            });
        }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;// Return the number of sections.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.channels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLChannelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChannelObjectCellIdentifier forIndexPath:indexPath];
    
    Channel *channel = [self.channels objectAtIndex:indexPath.row];
    cell.titleLabel.text = channel.channelName;
    
    cell.channelIconImageView.image = nil;
    cell.channelIconImageView.file =  channel.channelImage;
    [cell.channelIconImageView loadInBackground];
    
    cell.colorView.backgroundColor = [UIColor randomColor];
    
    cell.challengeCountLabel.text = [NSString stringWithFormat:@"%@ Challenges", channel.count];
    
    return cell;
}

#pragma mark - Table View delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self showChallengesInfoViewInChannel:self.channels[indexPath.row]];
}

- (void)showChallengesInfoViewInChannel:(Channel *)channel
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kMainStoryBoardName bundle:nil];
    HLChallengeListTableViewController *challengeListVC = [storyboard instantiateViewControllerWithIdentifier:kChallengeListViewControllerIdentifier];
    challengeListVC.channel = channel;
    [self.navigationController pushViewController:challengeListVC animated:YES];
}

/**
 *  handle the login and signup basic configuration with parse.
 */
- (void)handleLogginAndSignUp
{
    if ( (![PFUser currentUser])) {
        // No user logged in
        // Create the log in view controller
        SCLoginViewController *logInViewController = [[SCLoginViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        logInViewController.fields = (PFLogInFieldsUsernameAndPassword
                                      | PFLogInFieldsLogInButton
                                      | PFLogInFieldsSignUpButton
                                      | PFLogInFieldsPasswordForgotten
                                      | PFLogInFieldsDismissButton);
        // Create the sign up view controller
        SCSignUpViewController *signUpViewController = [[SCSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

#pragma mark - implementation of PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self loadChannelData];
    [self.tableView reloadData];
    
    
        PFInstallation *installation = [PFInstallation currentInstallation];
        installation[@"user"] = [PFUser currentUser];
        [installation saveInBackground];
        
        [self dismissViewControllerAnimated:YES completion:NULL];
   
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"Failed to log in...");
    
    [[[UIAlertView alloc] initWithTitle:@"Login failed"
                                message:@"Please make sure you network connection is working."
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - implementation of PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info
{
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) {
            // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
    [self loadChannelData];
    
    [self.tableView reloadData];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    NSLog(@"User dismissed the signUpViewController");
}

@end
