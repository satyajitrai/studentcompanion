//
//  UniversityListViewController.m
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/21/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "UniversityListViewController.h"
#import "UniversityCell.h"

@interface UniversityListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UniversityListViewController
static NSString *UniversityCellName = @"UniversityCell";

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
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationItem.title = @"Target Universities";
    self.tableView.rowHeight = 70;
    [self.tableView registerNib:[UINib nibWithNibName:UniversityCellName bundle:nil] forCellReuseIdentifier:UniversityCellName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UniversityCell *cell = [self.tableView dequeueReusableCellWithIdentifier:UniversityCellName];
    University * u = [University object];
    u.name = @"University of California";
    u.city = @"Berkeley";
    u.state = @"CA";
    u.programType = ProgramTypeGraduate;
    cell.university = u;
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
