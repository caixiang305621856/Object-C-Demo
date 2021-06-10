//
//  CXAppDelegate.m
//  Object-C-Demo
//
//  Created by caixiang305621856 on 06/08/2021.
//  Copyright (c) 2021 caixiang305621856. All rights reserved.
//

#import "CXAppDelegate.h"
#import "MainModuleAPI.h"
#import "CXComponentManager.h"
#import "CXModuleAProtocol.h"
#import "CXViewController.h"

@implementation CXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UITabBarController *rootVC = [MainModuleAPI rootTabBarCcontroller];
    [MainModuleAPI addChildVC:[CXViewController new] normalImageName:@"tabbar_sound_n" selectedImageName:@"tabbar_sound_h" isRequiredNavController:YES];
    [MainModuleAPI addChildVC:[CXComponentManager viewControllerForURL:[NSURL URLWithString:@"cxScheme://ModuleA"]] normalImageName:@"tabbar_find_n" selectedImageName:@"tabbar_find_h" isRequiredNavController:YES];
    [MainModuleAPI setNavBarGlobalBackGroundImage:[UIImage imageNamed:@"navigationbar_bg_64"]];
    [MainModuleAPI setNavBarGlobalTextColor:[UIColor redColor] andFontSize:18];
    self.window.rootViewController = rootVC;
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
