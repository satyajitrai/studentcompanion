//
//  UniversityListViewController.m
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/21/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "UniversityListViewController.h"
#import "UniversityCell.h"
#import "UniversityAddViewController.h"
#import "User.h"

@interface UniversityListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *universities;
@end

@implementation UniversityListViewController
static NSString *UniversityCellName = @"UniversityCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Add_button"]  style:UIBarButtonItemStylePlain target:self action:@selector(addUniversity:)];
        _universities = [[NSArray alloc] init];
        [self loadUniversities];
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
    [self addPullToRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _universities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UniversityCell *cell = [self.tableView dequeueReusableCellWithIdentifier:UniversityCellName];
    cell.university = _universities[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void) addPullToRefresh
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    
    NSMutableAttributedString *refreshString = [[NSMutableAttributedString alloc] initWithString:@"Refreshing..."];
    [refreshString addAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(0, refreshString.length)];
    refreshControl.attributedTitle = refreshString;
    [self.tableView addSubview:refreshControl];
}

- (void)refreshTable:(UIRefreshControl*) refresh {
    [self loadUniversities];
    [refresh endRefreshing];
}

- (void)loadUniversities {
    [[User currentUser] getUniversitiesWithBlock:^(NSArray *universities, NSError *error) {
        if (universities) {
            NSLog(@"Got %d universities", universities.count);
            self.universities = universities;
            [self.tableView reloadData];
        } else {
            self.navigationItem.prompt = [error description];
        }
    }];
}

- (IBAction)addUniversity:(id)sender {
    UniversityAddViewController *vc = [[UniversityAddViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
