//
//  HLGalleryTableViewCell.h
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLGalleryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *submissionImageView;

@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@end
