//
//  Challenge.h
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Challenge : NSObject<NSCoding>

@property (strong,nonatomic) NSString *challengeTitle;
@property (strong,nonatomic) NSDate *expires;
@property (strong,nonatomic) PFFile *promptImage;
@property (strong,nonatomic) NSString *promptText;
@property (strong, nonatomic) NSString *objectId;

@end
