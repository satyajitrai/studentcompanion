//
//  TaskListViewController.h
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/18/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
- (IBAction)addTaskTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addTaskBtn;
@property (weak, nonatomic) IBOutlet UILabel *addTaskLabel;

@end
