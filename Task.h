//
//  Task.h
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/19/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <Parse/Parse.h>

@interface Task : PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) NSString *taskTypeId;
@property (retain) NSString *name;
@property (retain) NSString *courseId;
@property (retain) NSString *description;
@property (retain) NSDate *dueDate;
@property (retain) NSNumber *grade;
@end
