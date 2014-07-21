//
//  AppDelegate.h
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/17/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mvc;
@property (strong, nonatomic) UINavigationController *nc;

@end
