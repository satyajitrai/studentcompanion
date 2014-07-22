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
#import "TaskType.h"
#import "University.h"
#import "MainViewController.h"
#import "SignupViewController.h"
#import "LoginViewController.h"
#import "TaskListViewController.h"


@interface AppDelegate()

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
    [TaskType registerSubclass];
    [University registerSubclass];

    // Read the parse.plist file and set up the application
    NSString *path = [[NSBundle mainBundle] pathForResource:@"parse" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *applicationId = [dict objectForKey:@"application_id"];
    NSString *clientKey = [dict objectForKey:@"client_key"];
    [Parse setApplicationId:applicationId clientKey:clientKey];
}

- (void)testCourse {
    Course *c = [Course object];
    c.name = @"Maths";
    c.assignmentGradePercent = @50;
    c.overallGpa = @9.5;
    c.courseType = CourseTypeRegular;
    c.quizGradePercent = @30;
    c.finalGradePercent = @20;
    
    [c saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Save successful");
        } else {
            NSLog(@"Failed. Error: %@", error);
        }
    }];
}

- (void) setupMainView {
    self.loginVC = [[LoginViewController alloc]init];
    self.signupVC = [[SignupViewController alloc]init];
    if([[PFUser currentUser] isAuthenticated]) {
//        self.nc = [[UINavigationController alloc] initWithRootViewController:self.taskListVC];
        self.mvc = [[MainViewController alloc] init];
        self.nc = [[UINavigationController alloc] initWithRootViewController:self.mvc];
    } else {
        self.nc = [[UINavigationController alloc] initWithRootViewController:self.loginVC];
    }
    self.window.rootViewController = self.nc;
}

@end
