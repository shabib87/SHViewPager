//
//  SHAppDelegate.m
//  SHViewPager
//  version 1.0, compatible with iOS 6.0 and greater
//
//  Created by shabib hossain on 5/15/14.
//  Copyright (c) 2014 shabib hossain. All rights reserved.
//
//  This software is licenced under MIT licence.
//  Please check LICENCE.md for more details.
//

#import "SHAppDelegate.h"
#import "SHImplementaion1VC.h"
#import "SHImplementaion2VC.h"
#import "SHImplementaion3VC.h"

@implementation SHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *tabBarTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont boldSystemFontOfSize:15.0f], NSFontAttributeName,
                                          nil];
    [[UITabBarItem appearance] setTitleTextAttributes:tabBarTextAttributes
                                             forState:UIControlStateNormal];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SHImplementaion1VC *imp1VC = [[SHImplementaion1VC alloc] initWithNibName:@"SHImplementaion1VC" bundle:nil];
    
    SHImplementaion2VC *imp2VC = [[SHImplementaion2VC alloc] initWithNibName:@"SHImplementaion2VC" bundle:nil];
    
    SHImplementaion3VC *imp3VC = [[SHImplementaion3VC alloc] initWithNibName:@"SHImplementaion3VC" bundle:nil];
    
    UINavigationController *navC1 = [[UINavigationController alloc] initWithRootViewController:imp1VC];
    navC1.navigationBar.translucent = NO;
    navC1.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0f, -15.0f);
    navC1.tabBarItem.title = @"Example 1";
    
    UINavigationController *navC2 = [[UINavigationController alloc] initWithRootViewController:imp2VC];
    navC2.navigationBar.translucent = NO;
    navC2.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0f, -15.0f);
    navC2.tabBarItem.title = @"Example 2";
    
    UINavigationController *navC3 = [[UINavigationController alloc] initWithRootViewController:imp3VC];
    navC3.navigationBar.translucent = NO;
    navC3.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0f, -15.0f);
    navC3.tabBarItem.title = @"Example 3";
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[navC1, navC2, navC3];
    
    self.window.rootViewController = self.tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
