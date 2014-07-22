//
//  AddTaskViewController.h
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/20/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *dueOn;
@property (weak, nonatomic) IBOutlet UITextField *grade;
@property (weak, nonatomic) IBOutlet UITextField *eventType;

@end
