//
//  AddTaskViewController.m
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/20/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "AddTaskViewController.h"
#import <Parse/Parse.h>
#import "Task.h"

@interface AddTaskViewController ()
@property (nonatomic, assign) id currentResponder;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeControl;
@end

@implementation AddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onSaveTaskTap)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)hideKeyBoard {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)onSaveTaskTap {
    [self.view endEditing:YES];
    Task *taskObject = [Task object];
    taskObject.name = self.taskName.text;
    taskObject.dueDate = self.dueOn.text;
    taskObject.grade = self.grade.text;
    taskObject.taskType = self.typeControl.selectedSegmentIndex;
    taskObject.user = [User currentUser];
    [taskObject saveInBackground];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
