//
//  HLChallengeDetailTableViewController.m
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import "HLChallengeDetailTableViewController.h"
#import "HLChallengDetailTableViewCell.h"
#import "HLGalleryTableViewController.h"
@interface HLChallengeDetailTableViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation HLChallengeDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.estimatedRowHeight = 420.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLChallengDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChallengeObjectDetailCellIdentifier forIndexPath:indexPath];
    
    cell.challengeTitleLabel.text = self.challenge.challengeTitle;
    cell.challengePromptTextLabel.text = self.challenge.promptText;
    
    cell.challengeImageView.image = nil;
    cell.challengeImageView.file = self.challenge.promptImage;
    
    [cell.challengeImageView loadInBackground];
    
    cell.uploadPhotoButton.tag = 1;
    
    [cell.uploadPhotoButton addTarget:self action:@selector(uploadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 420;
}

- (void)uploadButtonClicked:(UIButton *)sender{
    
    UIImagePickerController *imagePicker = [UIImagePickerController new];
//    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
//                              UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    imagePicker.allowsEditing = NO;
    
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:^{
        
        
    }];
}


#pragma mark -  ImagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    NSData *imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.5f);
    
    [[ParsingHandle sharedParsing] uploadSubmission:imageData InChallengeWithID:self.challenge.objectId WithCompletion:^{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kMainStoryBoardName bundle:nil];
        HLGalleryTableViewController *galleryListVC = [storyboard instantiateViewControllerWithIdentifier:kGalleryViewControllerIdentifier];
        galleryListVC.channelId = self.challenge.objectId;
        [self.navigationController pushViewController:galleryListVC animated:YES];
        
    }];
    
}

- (void)imagePickerControllerDidCancel:
(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
