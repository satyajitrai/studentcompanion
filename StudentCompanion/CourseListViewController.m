//
//  CourseListViewController.m
//  StudentCompanion
//
//  Created by Bharti Agrawal on 7/20/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "CourseListViewController.h"
#import "CourseAddViewController.h"
#import <Parse/Parse.h>
#import "User.h"
#import "Course.h"

@interface CourseListViewController (){
    UIRefreshControl *refreshControl;

}
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Course" style:UIBarButtonItemStylePlain target:self action:@selector(onAddCourseButton:)];

    [self loadCourses];
    [self addPullToRefresh];
//    self.tabBarItem.title = @"Courses";
}

- (void) addPullToRefresh
{
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadCourses) forControlEvents:UIControlEventValueChanged];
    
    NSMutableAttributedString *refreshString = [[NSMutableAttributedString alloc] initWithString:@"Refreshing..."];
    [refreshString addAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} range:NSMakeRange(0, refreshString.length)];
    refreshControl.attributedTitle = refreshString;
    [self.courseListTableView addSubview:refreshControl];
    
}

- (void) loadCourses{
    [[User currentUser] getCoursesWithBlock:^(NSArray *objects, NSError *error) {
        if (objects != nil){
            self.courses = objects;
            [self.courseListTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method for table view
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    Course *course = self.courses[indexPath.row];
    NSString *courseName = course.name;
    NSNumber *gpa = course.overallGpa;
    cell.textLabel.text = [NSString stringWithFormat:@"%@: GPA:%@", courseName, gpa];
    return cell;
}

- (IBAction)onAddCourseButton:(id)sender {
    CourseAddViewController *addCourseVC = [[CourseAddViewController alloc] init];
    [self.navigationController pushViewController:addCourseVC animated:YES];
}

@end
