//
//  UITableViewController+Additions.h
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewController (Additions)

/**
 *  Setup view controller title with a title with specific design
 *
 *  @param title The title to display
 */
- (void)setupNavigaionBarWithTitle:(NSString *)title;

@end
