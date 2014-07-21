//
//  CourseListViewController.m
//  StudentCompanion
//
//  Created by Bharti Agrawal on 7/20/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "CourseListViewController.h"
#import <Parse/Parse.h>

@interface CourseListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *courseListTableView;
@property (strong, nonatomic) NSArray *courses;
@property (weak, nonatomic) IBOutlet UITableView *courseListTableView;


@end

@implementation CourseListViewController

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
    self.courseListTableView.delegate = self;
    self.courseListTableView.dataSource = self;
    
    self.courseListTableView.rowHeight = 100;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadMessages) userInfo:nil repeats:YES];

    
    [self loadCourses];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadCourses{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"name"];
    [query includeKey:@"overallGpa"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.courses = objects;
        [self.courseListTableView reloadData];
    }];
}

#pragma mark - Table View methods
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection: %d", self.courses.count);
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"cellForRowAtIndexPath: %d", indexPath.row);
    
    //PFObject *user = self.messages[indexPath.row][@"user"];
    
    NSString *courseName = self.courses[indexPath.row][@"name"];
    NSString *gpa = self.courses[indexPath.row][@"gpa"];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"Name:%@  GPA:%@", courseName, gpa];
    //cell.text = self.messages[indexPath.row][@"text"];
    return cell;
    return cell;
}

@end
