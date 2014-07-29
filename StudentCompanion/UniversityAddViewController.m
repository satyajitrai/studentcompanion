//
//  UniversityAddViewController.m
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/25/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "UniversityAddViewController.h"
#import "User.h"

@interface UniversityAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityLabel;
@property (weak, nonatomic) IBOutlet UITextField *stateLabel;
@property (weak, nonatomic) IBOutlet UITextField *gpaLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *programSegment;
- (IBAction)onTap:(id)sender;
@end

@implementation UniversityAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(addUniversity:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Add University";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)addUniversity:(id)sender {
    University *u = [University object];
    u.name = _nameLabel.text;
    u.city = _cityLabel.text;
    u.state = _stateLabel.text;
    u.minimumGPA = _gpaLabel.text.integerValue;
    u.programType = _programSegment.selectedSegmentIndex;
    
    [[User currentUser] addUniversity:u withBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded == YES) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            self.navigationItem.prompt = [error description];
        }
    }];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}
@end
