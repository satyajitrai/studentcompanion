//
//  SettingsViewController.m
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/21/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "SettingsViewController.h"
#import "User.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextView;
@property (weak, nonatomic) IBOutlet UITextField *programNameTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *programSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *yearSegment;

- (IBAction)onSave:(UIBarButtonItem *)sender;
- (IBAction)onTap:(UITapGestureRecognizer *)sender;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    User *u = [User currentUser];
    _nameTextView.text = u.displayName;
    _programNameTextView.text = u.programName;
    _programSegment.selectedSegmentIndex = u.programType;
    _yearSegment.selectedSegmentIndex = u.yearType;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onSave:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout:)];

    self.tabBarItem.title = @"Settings";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSave:(UIBarButtonItem *)sender {
    User *u = [User currentUser];
    u.programName = _programNameTextView.text;
    u.displayName = _nameTextView.text;
    u.programType = _programSegment.selectedSegmentIndex;
    u.yearType = _yearSegment.selectedSegmentIndex;
    
    [u saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error userInfo][@"error"]);
        } else {
            NSLog(@"Saved successfully");
        }
    }];
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)onLogout:(id)sender {
    [User logOut];
    [self.delegate onLogout];
}

@end
