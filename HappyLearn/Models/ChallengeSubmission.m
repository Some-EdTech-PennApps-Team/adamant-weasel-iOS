//
//  ChallengeSubmission.m
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import "ChallengeSubmission.h"

@implementation ChallengeSubmission


//Implement the encoding method
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.submissionImage forKey:@"submissionImage"];
    [encoder encodeObject:self.user forKey:@"user"];
    [encoder encodeObject:self.challenge forKey:@"challenge"];
    [encoder encodeObject:self.objectId forKey:@"objectId"];
}

//implement the decoding method
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    self.submissionImage = [decoder decodeObjectForKey:@"submissionImage"];
    self.user = [decoder decodeObjectForKey:@"user"];
    self.objectId = [decoder decodeObjectForKey:@"objectId"];
    self.challenge = [decoder decodeObjectForKey:@"challenge"];
    return self;
}


@end
