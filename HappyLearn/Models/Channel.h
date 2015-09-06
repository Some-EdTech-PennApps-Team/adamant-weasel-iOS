//
//  Channels.h
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <Parse/Parse.h>

@interface Channel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *channelName;

@property (nonatomic, strong) PFFile *channelImage;

@property (strong,nonatomic) NSString *objectId;

@property (strong ,nonatomic) NSNumber* count;

@end
