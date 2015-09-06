//
//  HLChallengDetailTableViewCell.h
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLChallengDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *challengeTitleLabel;

@property (weak, nonatomic) IBOutlet PFImageView *challengeImageView;

@property (weak, nonatomic) IBOutlet UILabel *challengePromptTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *uploadPhotoButton;


@end
