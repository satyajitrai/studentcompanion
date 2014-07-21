//
//  CourseAddViewController.m
//  StudentCompanion
//
//  Created by Bharti Agrawal on 7/20/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "CourseAddViewController.h"
#import <Parse/Parse.h>
#import "Course.h"

@interface CourseAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *courseNameText;
@property (weak, nonatomic) IBOutlet UITextField *assignmentPercentText;
@property (weak, nonatomic) IBOutlet UITextField *quizPercentText;

@property (weak, nonatomic) IBOutlet UITextField *finalPercentText;
@property (weak, nonatomic) IBOutlet UIPickerView *courseTypePickerView;
@property (strong, nonatomic) NSMutableArray* courseTypes;

- (IBAction)onAddCourse:(id)sender;
- (IBAction)onTap:(id)sender;
@end

@implementation CourseAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Class List";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.courseTypePickerView.dataSource = self;
    self.courseTypePickerView.delegate = self;
    // Do any additional setup after loading the view from its nib.
    self.courseTypes = [[NSMutableArray alloc]init];
    [self.courseTypes addObject:@"   Regular   "];
    [self.courseTypes addObject:@"   Honors    "];
    [self.courseTypes addObject:@"     AP      "];
    
    [self.courseTypePickerView selectRow:1 inComponent:0 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAddCourse:(id)sender {
    NSLog(@"in add course");    
    int selectedRow = [self.courseTypePickerView selectedRowInComponent:0];
    
    Course *c = [Course object];
    c.name = self.courseNameText.text;
    c.assignmentGradePercent = [[NSNumber alloc]initWithInt:[self.assignmentPercentText.text integerValue]];
    c.overallGpa = @0;
    
    switch (selectedRow) {
        case 0:
            c.courseType = CourseTypeRegular;
            break;
        case 1:
            c.courseType = CourseTypeHonors;
            break;
        case 2:
            c.courseType = CourseTypeAP;
            break;
            
        default:
            break;
    }
    
    //c.courseType = [[NSNumber alloc]initWithInteger:[self.courseTypePickerView selectedRowInComponent:0]];
    c.quizGradePercent = [[NSNumber alloc]initWithInt:[self.quizPercentText.text integerValue]];
    c.finalGradePercent = [[NSNumber alloc]initWithInt:[self.finalPercentText.text integerValue]];
    
    [c saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Save successful");
        } else {
            NSLog(@"Failed. Error: %@", error);
        }
    }];
    
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark- methods for picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

/*- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
 {
 //mlabel.text =  [_courseTypes objectAtIndex:row];
 //_courseType = row;
 }*/

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [_courseTypes count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [_courseTypes objectAtIndex:row];
}

@end