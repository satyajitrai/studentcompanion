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


@interface TaskListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (nonatomic, strong) NSArray *tasks;

@end

@implementation TaskListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self action:@selector(OnLogoutTap)];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTasks];
    [self.taskTableView registerNib:[UINib nibWithNibName:@"TaskCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"TaskCellTableViewCell"] ;
    self.taskTableView.rowHeight = 150;
    self.taskTableView.delegate = self;
    self.taskTableView.dataSource = self;
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
        if (!error) {
            self.tasks = objects;
            [self.taskTableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
#pragma mark - User Actions
- (void) OnLogoutTap {
    [PFUser logOut];
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)addTaskTap:(id)sender {
    AddTaskViewController *addTaskVC = [[AddTaskViewController alloc]init];
    [self.navigationController pushViewController:addTaskVC animated:YES];
}

#pragma mark- table view methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskCellTableViewCell *taskCell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellTableViewCell"];
    
    taskCell.dueOnLabel.text = self.tasks[indexPath.row][@"due_on"];
    taskCell.taskLabel.text = self.tasks[indexPath.row][@"name"];
    return taskCell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}
@end
