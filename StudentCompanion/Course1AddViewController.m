//
//  CourseAddViewController.m
//  StudentCompanion
//
//  Created by Bharti Agrawal on 7/20/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "CourseAddViewController.h"
#import <Parse/Parse.h>

@interface CourseAddViewController ()
- (IBAction)onAdd:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *courseNameText;
@property (weak, nonatomic) IBOutlet UIPickerView *courseTypePicker;
@property (weak, nonatomic) IBOutlet UITextField *finalPercentText;
@property (weak, nonatomic) IBOutlet UITextField *quizPercentText;
- (IBAction)onCourseAd:(id)sender;
- (IBAction)onCourseAdd:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *assignmentPercentText;
@property (strong, nonatomic) NSMutableArray* courseTypes;
- (IBAction)onTap:(id)sender;

@end

@implementation CourseAddViewController

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
    self.courseTypePicker.delegate = self;
    self.courseTypePicker.dataSource = self;
    // Do any additional setup after loading the view from its nib.
    self.courseTypes = [[NSMutableArray alloc] init];
    [self.courseTypes addObject:@" Regular "];
    [self.courseTypes addObject:@" Honors "];
    [self.courseTypes addObject:@" AP "];
    
    [_courseTypePicker selectRow:1 inComponent:0 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onAdd:(id)sender {
    NSLog(@"in onAdd");
    PFObject *course = [PFObject objectWithClassName:@"Course"];
    course[@"name"] = self.courseNameText.text;
    
    //mlabel.text= [arrayNo objectAtIndex:[pickerView selectedRowInComponent:0]];
    course[@"courseType"] = [[NSNumber alloc] initWithInt:[_courseTypePicker selectedRowInComponent:0]];
    
    course[@"assignmentGradePercent"] = [[NSNumber alloc]initWithInt:[self.assignmentPercentText.text integerValue]];
    
    course[@"quizGradePercent"] = [[NSNumber alloc]initWithInt:[self.quizPercentText.text integerValue]];
    course[@"finalGradePercent"] = [[NSNumber alloc]initWithInt:[self.finalPercentText.text integerValue]];
    [course saveInBackground];

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
- (IBAction)onTap:(id)sender {
    NSLog(@"in onTap");
    [self.view endEditing:YES];
}

@end
