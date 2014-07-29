//
//  CourseCell.h
//  StudentCompanion
//
//  Created by Bharti Agrawal on 7/28/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *assignPercent;
@property (weak, nonatomic) IBOutlet UILabel *courseType;
@property (weak, nonatomic) IBOutlet UILabel *overallGPA;
@property (weak, nonatomic) IBOutlet UILabel *quizPercent;
@property (weak, nonatomic) IBOutlet UILabel *finalPercent;
@end
