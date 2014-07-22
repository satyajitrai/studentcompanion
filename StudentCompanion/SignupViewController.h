//
//  SignupViewController.h
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/18/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController
- (IBAction)onSignupTap:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userEmailaddress;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;

@end
