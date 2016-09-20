//
//  SHViewPagerController.m
//  SHViewPager

//
//  Created by shabib hossain on 5/15/14.
//  Copyright © 2014-2016 Code with Shabib. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "SHViewPagerController.h"
#import "SHViewPager.h"

static NSString * const currentTranslucentStatusNavBarKey = @"currentTranslucentStatusNavBarKey";
static NSString * const currentTranslucentStatusTabBarKey = @"currentTranslucentStatusTabBarKey";

@interface SHViewPagerController ()

@end

@implementation SHViewPagerController

@dynamic view;

- (void)loadView {
    [super loadView];

    self.view = [SHViewPager new];
    self.view.dataSource = self;
    self.view.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /**
     *
     *  Hack property to use on Navigation bar.
     *  Please refer to issue: #18
     */
    BOOL navBarTranslucent = self.navigationController.navigationBar.translucent;
    [SHViewPagerController setCurrentTranslucentStatusNavBar:navBarTranslucent];
    if (navBarTranslucent) {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    /**
     *
     *  Hack property to use on tab bar.
     *  Please refer to issue: #18
     */
    BOOL tabBarTranslucent = self.tabBarController.tabBar.translucent;
    [SHViewPagerController setCurrentTranslucentStatusTabBar:tabBarTranslucent];
    if (tabBarTranslucent) {
        self.tabBarController.tabBar.translucent = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    /**
     *  Setting back the status to the original ones
     */
    self.navigationController.navigationBar.translucent = [SHViewPagerController currentTranslucentStatusNavBar];
    self.tabBarController.tabBar.translucent = [SHViewPagerController currentTranslucentStatusTabBar];
}

#pragma mark - SHViewPagerDataSource stack

- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager {
    @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #numberOfPagesInViewPager:" userInfo:nil]);
}

- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager {
    @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #containerControllerForViewPager:" userInfo:nil]);
}

- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index {
    @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #viewPager:controllerForPageAtIndex:" userInfo:nil]);
}

/**
 *
 *  Hack property to use on Navigation bar.
 *  Please refer to issue: #18
 */
+ (void)setCurrentTranslucentStatusNavBar:(BOOL)translucent {
    [[NSUserDefaults standardUserDefaults] setBool:translucent forKey:currentTranslucentStatusNavBarKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *
 *  Hack property to use on Navigation bar.
 *  Please refer to issue: #18
 */
+ (BOOL)currentTranslucentStatusNavBar {
    return [[NSUserDefaults standardUserDefaults] boolForKey:currentTranslucentStatusNavBarKey];
}

/**
 *
 *  Hack property to use on tab bar.
 *  Please refer to issue: #18
 */
+ (void)setCurrentTranslucentStatusTabBar:(BOOL)translucent {
    [[NSUserDefaults standardUserDefaults] setBool:translucent forKey:currentTranslucentStatusTabBarKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *
 *  Hack property to use on tab bar.
 *  Please refer to issue: #18
 */
+ (BOOL)currentTranslucentStatusTabBar {
    return [[NSUserDefaults standardUserDefaults] boolForKey:currentTranslucentStatusTabBarKey];
}

@end
