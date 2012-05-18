//
//  ios_demoAppDelegate.m
//  ios-demo
//
//  Created by Bal on 5/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
//==============================
#import "CESplashController.h"
#import "CETwitterController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    TTNavigator* navigator = [TTNavigator navigator];
    navigator.supportsShakeToReload = YES;
    navigator.persistenceMode = TTNavigatorPersistenceModeNone;
    
    TTURLMap* map = navigator.URLMap;
    [map from:@"*" toViewController:[TTWebController class]];
    [map from: @"cemaleker://splash"
          toSharedViewController: [CESplashController class]];
    
    [map from: @"cemaleker://twitter" toViewController: [CETwitterController class]];
    
    [navigator openURLAction: [TTURLAction actionWithURLPath: @"cemaleker://twitter"]];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_window);
    [super dealloc];
}

@end
