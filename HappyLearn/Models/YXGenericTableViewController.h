//
//  YXGenericTableViewController.h
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewController+Additions.h"

@interface YXGenericTableViewController : UITableViewController

/**
 *  Make navigation bar tranparent
 */
- (void)setNavBarTransparent;

/**
 *  Make navigation bar opaque.
 */
- (void)setNavBarOpaque;

/**
 *  Make background blur
 */
- (void)setBackgroundBlur;


@end
