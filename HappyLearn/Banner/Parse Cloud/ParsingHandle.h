//
//  ParsingHandle.h
//  socialCalendar
//
//  Created by Yifan Xiao on 5/29/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParsingHandle : NSObject

+(id)sharedParsing;

-(void)findAllChannelsToCompletion:(void(^)(NSArray *array))completion;

-(void)findChannelsOfCurrentUserToCompletion:(void(^)(NSArray *array))completion;

-(void)findChannelsOfUser:(PFUser *)user ToCompletion:(void(^)(NSArray *array))completion;

-(void)findObjectsofDate:(NSDate *)date ToCompletion:(void (^)(NSArray *array))completion;

-(void)getChallengesWithChannelID:(NSString *)channelID ToCompletion:(void (^)(NSArray *))completion;

-(void)getAllChallengesToCompletion:( void (^)(NSArray *array))completion;

-(void)getAllUsersToCompletion:(void (^)(NSArray *array))completion;

-(void)getMyFriendsToCompletion:(void (^)(NSArray *array))completion;

-(void)getMyPendingReceivedRequestToCompletion:(void (^)(NSArray *array))completion;

-(void)getMyPendingSentRequestToCompletion:(void (^)(NSArray *array))completion;

-(void)sendUserFriendRequest:(PFUser *)user;

-(void)approvedFriendRequestFrom:(PFUser *)user;

- (void)removeDeniedFriendRequestFrom:(PFUser *)user;

-(void)getApprovedUsersToCompletion:(void (^)(NSArray *array))completion;

-(void)deleteEventFromCloudByID:(NSString *)objectId ToCompletion:(void (^)())completion;

- (void)uploadSubmission:(NSData *)imageData InChallengeWithID:(NSString *)challengeID WithCompletion:(void (^)())completion;

- (void)uploadSubmission:(NSData *)imageData ofUser:(PFUser *)user InChallengeWithID: (NSString *)challengeID WithCompletion:(void (^)())completion;

-(void)getAllSubmissionsToCompletion:(void (^)(NSArray *array))completion;

- (void)getSubmissionsOfChallengeInID:(NSString *)challengeID ToCompletion:(void (^)(NSArray *array))completion;

-(Channel *)parseChannelToChannelObject:(PFObject *)object;
-(Challenge *)parseChallengeToChallengeObject: (PFObject *)object;
@end
