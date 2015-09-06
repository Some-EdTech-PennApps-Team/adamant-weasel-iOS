//
//  HLChallengeTableViewCell.h
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLChallengeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *challengeTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *challengeDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeCounterLabel;

@end
