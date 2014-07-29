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
@property (nonatomic,assign) BOOL isPresenting;
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
    self.signupBtn.layer.cornerRadius = 10;
    self.signupBtn.clipsToBounds = YES;

    self.loginBtn.layer.cornerRadius = 10;
    self.loginBtn.clipsToBounds = YES;
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
    signupVC.transitioningDelegate = self;
    [self presentViewController:signupVC animated:YES completion:nil];
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresenting = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresenting = NO;
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 3;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSLog(@"%@", toViewController);
    NSLog(@"%@", fromViewController);
    if (self.isPresenting) {
        [containerView addSubview:toViewController.view];
    [UIView transitionFromView:containerView toView:toViewController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
    }];
    } else {
        
        [UIView transitionFromView:containerView toView:toViewController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [fromViewController removeFromParentViewController];
        }];
    }
    
}

@end
