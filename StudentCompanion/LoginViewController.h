//
//  LoginViewController.h
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/18/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol LoginProtocolDelegate<NSObject>
- (void) onLoginSuccess:(User*)user;
@end

@interface LoginViewController : UIViewController <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) IBOutlet UITextField *userEmailAddress;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *signupBtn;


@property (assign, nonatomic) id<LoginProtocolDelegate> delegate;

- (IBAction)onLoginTap:(id)sender;
- (IBAction)onSignupBtnTap:(id)sender;
@end
