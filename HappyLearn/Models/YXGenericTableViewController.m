//
//  YXGenericTableViewController.m
//  HappyLearn
//
//  Created by Yifan Xiao on 9/5/15.
//  Copyright (c) 2015 Yifan Xiao. All rights reserved.
//

#import "YXGenericTableViewController.h"

@interface YXGenericTableViewController ()

@end

@implementation YXGenericTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDesign];
}

- (void)setupDesign
{
    // Back button without title and back_arrow_icon to match designs
    // Can't use Appearance because it will break Apptentive screens
    // https://www.pivotaltracker.com/story/show/93858752
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_arrow_icon"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" "
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:nil
                                                                  action:nil];
    [backButton setBackButtonBackgroundImage:backButtonImage
                                    forState:UIControlStateNormal
                                  barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = backButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

#pragma mark - Design Methods

- (void)setNavBarTransparent
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)setNavBarOpaque
{
    UINavigationController *navController = [[UINavigationController alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:navController.navigationBar.backIndicatorImage forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = navController.navigationBar.shadowImage;
    self.navigationController.navigationBar.translucent = navController.navigationBar.translucent;
    self.navigationController.navigationBar.backgroundColor = navController.navigationBar.backgroundColor;
}

- (void)setBackgroundBlur
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.navigationController.view.bounds;
    [self.navigationController.view addSubview:blurEffectView];
    [self.navigationController.view sendSubviewToBack:blurEffectView];
}

@end
