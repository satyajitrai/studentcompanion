//
//  TaskListViewController.m
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/18/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//
#import <Parse/Parse.h>
#import "TaskListViewController.h"
#import "AddTaskViewController.h"
#import "TaskCellTableViewCell.h"
#import "LoginViewController.h"
#import "Task.h"


@interface TaskListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (nonatomic, strong) NSArray *tasks;

@end

@implementation TaskListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tasks = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarItem.title = @"Tasks";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Task" style:UIBarButtonItemStylePlain target:self action:@selector(addTaskTap:)];

    [self.taskTableView registerNib:[UINib nibWithNibName:@"TaskCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"TaskCellTableViewCell"] ;
    self.taskTableView.rowHeight = 100;
    self.taskTableView.delegate = self;
    self.taskTableView.dataSource = self;
    
    [self loadTasks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - load data

- (void) loadTasks {
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [query whereKey:@"user" equalTo:(User*)[User currentUser]];
        if (!error) {
            NSLog(@"Got tasks: %d", objects.count);
            self.tasks = objects;
            [self.taskTableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error getting Tasks: %@ %@", error, [error userInfo]);
        }
    }];
}

- (IBAction)addTaskTap:(id)sender {
    AddTaskViewController *addTaskVC = [[AddTaskViewController alloc]init];
    [self.navigationController pushViewController:addTaskVC animated:YES];
}

#pragma mark- table view methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskCellTableViewCell *taskCell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellTableViewCell"];
    Task *t = self.tasks[indexPath.row];
    taskCell.dueOnLabel.text = t.dueDate;
    taskCell.taskLabel.text = t.name;
    taskCell.taskTypeLabel.text = t.taskTypeString;
    return taskCell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}
@end
