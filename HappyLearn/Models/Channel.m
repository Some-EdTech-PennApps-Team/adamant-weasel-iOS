//
//  Channels.m
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import "Channel.h"

@implementation Channel

//Implement the encoding method
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.channelName forKey:@"channelName"];
    [encoder encodeObject:self.channelImage forKey:@"channelImage"];
    [encoder encodeObject:self.objectId forKey:@"objectId"];
    [encoder encodeObject:self.count forKey:@"count"];
}

//implement the decoding method
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    self.channelImage = [decoder decodeObjectForKey:@"channelImage"];
    self.channelName = [decoder decodeObjectForKey:@"channelName"];
    self.objectId = [decoder decodeObjectForKey:@"objectId"];
    self.count = [decoder decodeObjectForKey:@"count"];
    return self;
}


@end
