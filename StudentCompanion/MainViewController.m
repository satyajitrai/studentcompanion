//
//  MainViewController.m
//  StudentCompanion
//
//  Created by Bharti Agrawal on 7/20/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "MainViewController.h"
#import "CourseListViewController.h"
#import "CourseAddViewController.h"
#import "TaskListViewController.h"
#import "UniversityListViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) CourseListViewController *classListVC;
@property (strong, nonatomic) CourseAddViewController *classAddVC;
@property (strong, nonatomic) TaskListViewController *taskListVC;
@property (strong, nonatomic) UniversityListViewController *universityListVC;

@property (strong, nonatomic) UIBarButtonItem *settingsButton;
@property (strong, nonatomic) UIBarButtonItem *addButton;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setupView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self setupView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupView
{
    self.settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettings:)];
    
    self.navigationItem.leftBarButtonItem = self.settingsButton;
    
    self.addButton = [[UIBarButtonItem alloc]
                          initWithTitle:@"+"
                          style:UIBarButtonItemStylePlain
                          target:self
                          action:@selector(addClassButtonTap:)];
    
    self.navigationItem.rightBarButtonItem = self.addButton;
    self.classListVC = [[CourseListViewController alloc] init];
    self.taskListVC = [[TaskListViewController alloc]init];
    self.universityListVC = [[UniversityListViewController alloc]init];
//    [self.view addSubview:self.classListVC.view];
//    [self addChildViewController:_classListVC];
    
    [_classListVC didMoveToParentViewController:self];
    
     UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBarItem.title = @"Tasks";
    tabBarController.tabBarItem.title = @"Courses";
    tabBarController.tabBarItem.title = @"University";
    tabBarController.viewControllers = @[_classListVC,_taskListVC, _universityListVC];
    [self.view addSubview:tabBarController.view];
    [self addChildViewController:tabBarController];
    
}

- (void)addClassButtonTap:(id)sender {
    CourseAddViewController *cvc = [[CourseAddViewController alloc] init];
    self.navigationItem.backBarButtonItem.title = @"Cancel";
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)showSettings:(id)sender {
    //ClassAddViewController *cvc = [[ClassAddViewController alloc] init];
    //self.navigationItem.backBarButtonItem.title = @"Cancel";
    //[self.navigationController pushViewController:cvc animated:YES];
}

@end
