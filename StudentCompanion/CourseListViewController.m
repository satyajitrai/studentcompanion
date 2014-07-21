//
//  CourseListViewController.m
//  StudentCompanion
//
//  Created by Bharti Agrawal on 7/20/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "CourseListViewController.h"
#import <Parse/Parse.h>

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
    NSLog(@"courselistView: view did load");
    [super viewDidLoad];
    self.courseListTableView.delegate = self;
    self.courseListTableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
    
    [self loadCourses];
    [self addPullToRefresh];

    //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadCourses) userInfo:nil repeats:YES];

}

- (void) addPullToRefresh
{
    NSLog(@"addPullToRefresh");
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadCourses) forControlEvents:UIControlEventValueChanged];
    
    NSMutableAttributedString *refreshString = [[NSMutableAttributedString alloc] initWithString:@"Pull To Refresh"];
    [refreshString addAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} range:NSMakeRange(0, refreshString.length)];
    refreshControl.attributedTitle = refreshString;
    
    [self.courseListTableView addSubview:refreshControl];
    
}

- (void) loadCourses{
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
    //[query orderByDescending:@"createdAt"];
    //[query includeKey:@"name"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"Got data: %@");
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
    NSLog(@"cellforRowAtIndex");
    //PFObject *user = self.messages[indexPath.row][@"user"];
    
    NSString *courseName = self.courses[indexPath.row][@"name"];
    NSString *gpa = self.courses[indexPath.row][@"overallGpa"];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@: GPA:%@", courseName, gpa];
    //cell.text = self.messages[indexPath.row][@"text"];
    return cell;
}

@end
