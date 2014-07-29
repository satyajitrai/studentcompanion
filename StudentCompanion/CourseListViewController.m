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
#import "courseCell.h"

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Add_button"] style:UIBarButtonItemStylePlain target:self action:@selector(onAddCourseButton:)];
    
    [self.courseListTableView registerNib:[UINib nibWithNibName:@"CourseCell" bundle:nil] forCellReuseIdentifier:@"CourseCell"] ;
    self.courseListTableView.rowHeight = 50;

    [self loadCourses];
    [self addPullToRefresh];
//    self.tabBarItem.title = @"Courses";
    self.navigationItem.title = @"Courses";
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
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    Course *course = self.courses[indexPath.row];
    //NSString *courseName = course.name;
    //NSNumber *gpa = course.overallGpa;
    //cell.textLabel.text = [NSString stringWithFormat:@"%@: GPA:%@", courseName, gpa];
    
    
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell"];
    
    cell.name.text = course.name;
    cell.overallGPA.text = [NSString stringWithFormat:@"%@",course.overallGpa];
    cell.assignPercent.text = [NSString stringWithFormat:@"%@",course.assignmentGradePercent];
    cell.quizPercent.text = [NSString stringWithFormat:@"%@",course.quizGradePercent];
    cell.finalPercent.text = [NSString stringWithFormat:@"%@",course.finalGradePercent];
    NSString *courseTypeName = [Course nameForCourseType:course.courseType];
    
    cell.courseType.text = [NSString stringWithFormat:@"(%@)", courseTypeName];
    return cell;
}

- (IBAction)onAddCourseButton:(id)sender {
    CourseAddViewController *addCourseVC = [[CourseAddViewController alloc] init];
    [self.navigationController pushViewController:addCourseVC animated:YES];
}

@end
