//
//  HLChallengeListTableViewController.h
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//
#import "Channel.h"
#import "YXGenericTableViewController.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HLChallengeType)
{
    HLChallengeTypeLive = 0,
    HLChallengeTypePast,
    HLChallengeTypeCount
};

@interface HLChallengeListTableViewController : YXGenericTableViewController

@property (strong, nonatomic) Channel *channel;

@end
