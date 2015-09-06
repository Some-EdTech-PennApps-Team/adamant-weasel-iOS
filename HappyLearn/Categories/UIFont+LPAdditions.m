//
//  UIFont+LPAdditions.m
//  LillyPulitzer
//
//  Created by Thibault Klein on 2/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "UIFont+LPAdditions.h"

static NSString *const kGothamBookFontName = @"Gotham-Book";

@implementation UIFont (LPAdditions)

+ (UIFont *)gothamBookWithSize:(CGFloat)size
{
    return [UIFont fontWithName:kGothamBookFontName size:size];
}

+ (UIFont *)gothamBookForHeaderFooterViewWithSize:(CGFloat)size
{
    return [UIFont fontWithDescriptor:[UIFontDescriptor fontDescriptorWithFontAttributes:@{ @"NSCTFontUIUsageAttribute" : UIFontTextStyleBody,
                                                                                            @"NSFontNameAttribute" : kGothamBookFontName }] size:size];
}

+ (UIFont *)gothamMediumWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Gotham-Medium" size:size];
}

@end
