//
//  LoginViewController.m
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/18/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"
#import "TaskListViewController.h"
#import "MainViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginTap:(id)sender {
    [PFUser logInWithUsernameInBackground:self.userEmailAddress.text password:self.userPassword.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSLog(@"User Login successful");
//                                            [self showTaskList];
                                            [self showMainView];
                                        } else {
                                            NSLog(@"User Login failed, %@", error.description);
                                        }
                                    }];
}

- (IBAction)onSignupBtnTap:(id)sender {
    SignupViewController *signupVC = [[SignupViewController alloc]init];
    [self.navigationController pushViewController:signupVC animated:YES];
}

-(void) showTaskList {
    TaskListViewController *taskListVC = [[TaskListViewController alloc]init];
    [self.navigationController pushViewController:taskListVC animated:YES];
}
-(void) showMainView {
    MainViewController *mainVC = [[MainViewController alloc]init];
    [self.navigationController pushViewController:mainVC animated:YES];
}

@end
