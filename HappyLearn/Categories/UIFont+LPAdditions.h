//
//  UIFont+LPAdditions.h
//  LillyPulitzer
//
//  Created by Thibault Klein on 2/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (LPAdditions)

/**
 *  Creates and returns a Gotham Book font with specified size.
 *
 *  @param size The size.
 *
 *  @return Gotham Book font with specified size.
 */
+ (UIFont *)gothamBookWithSize:(CGFloat)size;

/**
 *  Creates and returns a Gotham Book font with specified size for header or footer view.
 *
 *  Can't use gothamBookWithSize method directly because of the iOS 8.0 system bug.
 *  http://stackoverflow.com/questions/25773661/scaledvalueforvalue-called-on-a-font-that-doesnt-have-a-text-style-set
 *
 *  @param size The size.
 *
 *  @return Gotham Book font with specified size.
 */
+ (UIFont *)gothamBookForHeaderFooterViewWithSize:(CGFloat)size;

/**
 *  Creates and returns a Gotham Medium font with specified size.
 *
 *  @param size The size.
 *
 *  @return Gotham Medium font with specified size.
 */
+ (UIFont *)gothamMediumWithSize:(CGFloat)size;

@end
