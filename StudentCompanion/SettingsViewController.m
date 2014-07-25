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

@property (assign) BOOL editMode;
- (IBAction)onEdit:(UIButton *)sender;
- (IBAction)onTap:(UITapGestureRecognizer *)sender;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _editMode = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    User *u = [User currentUser];
    _nameTextView.text = u.displayName;
    _programNameTextView.text = u.programName;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(onEdit:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout:)];

    self.tabBarItem.title = @"Settings";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onEdit:(UIBarButtonItem *)sender {
    if (_editMode == NO) {
        _nameTextView.enabled = YES;
        _programNameTextView.enabled = YES;
        [sender setTitle:@"Save"];
        _editMode = YES;
    } else {
        _nameTextView.enabled = NO;
        _programNameTextView.enabled = NO;
        [sender setTitle:@"Edit"];
        _editMode = NO;
        
        User *u = [User currentUser];
        u.programName = _programNameTextView.text;
        u.displayName = _nameTextView.text;
        [u saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", [error userInfo][@"error"]);
            } else {
                NSLog(@"Saved successfully");
            }
        }];
    }
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)onLogout:(id)sender {
    [User logOut];
    [self.delegate onLogout];
}

@end
