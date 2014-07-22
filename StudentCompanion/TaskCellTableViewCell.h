//
//  TaskCellTableViewCell.h
//  StudentCompanion
//
//  Created by Pragya  Pherwani on 7/20/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueOnLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;

@end
