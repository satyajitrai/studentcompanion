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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onLoginTap:(id)sender {
    [PFUser logInWithUsernameInBackground:self.userEmailAddress.text
                                 password:self.userPassword.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (!error) {
                                            NSLog(@"User Login successful");
                                            [self.delegate onLoginSuccess:(User*)user];
                                        } else {
                                            NSLog(@"User Login failed, %@", error.description);
                                        }
                                    }];
}

- (IBAction)onSignupBtnTap:(id)sender {
    SignupViewController *signupVC = [[SignupViewController alloc]init];
    [self.navigationController pushViewController:signupVC animated:YES];
}

//-(void) showTaskList {
//    TaskListViewController *taskListVC = [[TaskListViewController alloc]init];
//    [self.navigationController pushViewController:taskListVC animated:YES];
//}

@end
