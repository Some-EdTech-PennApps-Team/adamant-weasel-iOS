//
//  HLChannelTableViewCell.h
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLChannelTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *challengeCountLabel;

@property (weak, nonatomic) IBOutlet PFImageView *channelIconImageView;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@end
