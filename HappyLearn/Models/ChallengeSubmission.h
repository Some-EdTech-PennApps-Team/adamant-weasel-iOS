//
//  ChallengeSubmission.h
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChallengeSubmission : NSObject<NSCoding>

@property (nonatomic, strong) NSString *objectId;

@property (nonatomic, strong) PFFile *submissionImage;

@property (nonatomic, strong) PFUser *user;

@property (nonatomic, strong) Challenge *challenge;

@end
