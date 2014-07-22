//
//  SignupViewController.m
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/18/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface SignupViewController ()

@end

@implementation SignupViewController

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

- (IBAction)onSignupTap:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.userEmailaddress.text;
    user.password = self.userPassword.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"User Signup successfully!");
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"User Signup failed!, %@", errorString.description);
        }
    }];
}
@end
