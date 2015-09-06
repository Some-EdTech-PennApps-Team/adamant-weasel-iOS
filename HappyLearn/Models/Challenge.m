//
//  Challenge.m
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import "Challenge.h"

@implementation Challenge

//Implement the encoding method
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.challengeTitle forKey:@"challengeTitle"];
    [encoder encodeObject:self.expires forKey:@"expires"];
    [encoder encodeObject:self.promptImage forKey:@"promptImage"];
    [encoder encodeObject:self.promptText forKey:@"promptText"];
    [encoder encodeObject:self.objectId forKey:@"objectId"];
}

//implement the decoding method
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    self.challengeTitle = [decoder decodeObjectForKey:@"challengeTitle"];
    self.expires = [decoder decodeObjectForKey:@"expires"];
    self.promptText = [decoder decodeObjectForKey:@"promptText"];
    self.promptImage = [decoder decodeObjectForKey:@"promptImage"];
    self.objectId = [decoder decodeObjectForKey:@"objectId"];
    
    return self;
}

@end
