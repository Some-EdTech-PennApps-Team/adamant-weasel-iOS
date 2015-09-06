//
//  UITableViewController+Additions.m
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import "UITableViewController+Additions.h"

@implementation UITableViewController (Additions)

- (void)setupNavigaionBarWithTitle:(NSString *)title
{
    NSDictionary *firstLineAttributes = @{
                                          NSFontAttributeName: [UIFont systemFontOfSize:16.0f],
                                          NSForegroundColorAttributeName: [UIColor customGrayColor]
                                          };
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", title]
                                                                  attributes:firstLineAttributes];
    UILabel *label = [UILabel new];
    label.attributedText = attrStr;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    
    self.navigationItem.titleView = label;
    
    // Need to play with the title view alpha because of a bug when setting title view after viewDidLoad:
    self.navigationItem.titleView.alpha = 0.0f;
    dispatch_after(dispatch_time( DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC) ), dispatch_get_main_queue(), ^{
        self.navigationItem.titleView.alpha = 1.0f;
    });
}


@end
