//
//  AppDelegate.m
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/17/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "User.h"
#import "Course.h"
#import "Task.h"
#import "University.h"
#import "LoginViewController.h"
#import "TaskListViewController.h"
#import "CourseListViewController.h"
#import "SettingsViewController.h"
#import "UniversityListViewController.h"

@interface AppDelegate()<LoginProtocolDelegate, LogoutProtocolDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setUpParse];
    [self setupMainView];
    
    // Override point for customization after application launch.
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

#pragma mark - Parse Setup
- (void) setUpParse {
    // First Register the classes
    [User registerSubclass];
    [Course registerSubclass];
    [Task registerSubclass];
    [University registerSubclass];

    // Read the parse.plist file and set up the application
    NSString *path = [[NSBundle mainBundle] pathForResource:@"parse" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *applicationId = [dict objectForKey:@"application_id"];
    NSString *clientKey = [dict objectForKey:@"client_key"];
    [Parse setApplicationId:applicationId clientKey:clientKey];
}

- (void) setupMainView {
    if([[User currentUser] isAuthenticated]) {
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        CourseListViewController *cl = [[CourseListViewController alloc] init];
        UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:cl];
        nc1.tabBarItem.title = @"Courses";
        nc1.tabBarItem.image = [self tabImageNamed:@"course"];
        
        UniversityListViewController *ul = [[UniversityListViewController alloc] init];
        UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:ul];
        nc2.tabBarItem.title = @"Universities";
        nc2.tabBarItem.image = [self tabImageNamed:@"university"];
        
        TaskListViewController *tl = [[TaskListViewController alloc] init];
        UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:tl];
        nc3.tabBarItem.title = @"Tasks";
        nc3.tabBarItem.image = [self tabImageNamed:@"tasks"];
        
        SettingsViewController *sv = [[SettingsViewController alloc] init];
        sv.delegate = self;
        UINavigationController *nc4 = [[UINavigationController alloc] initWithRootViewController:sv];
        nc4.tabBarItem.title = @"Settings";
        nc4.tabBarItem.image = [self tabImageNamed:@"settings"];
        
        tabBarController.viewControllers = @[nc1, nc2, nc3, nc4];
        self.window.rootViewController = tabBarController;
    } else {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.delegate = self;
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = nc;
    }
}

- (UIImage *)tabImageNamed:(NSString*)imageName {
    UIImage * image = [UIImage imageNamed:imageName];
    CGSize newSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [newImage imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
}

- (void)onLoginSuccess:(User *)user {
    [self setupMainView];
}

- (void) onLogout {
    [self setupMainView];
}

@end
