//
//  Task.h
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/19/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <Parse/Parse.h>
#import "Course.h"

typedef NS_ENUM(NSInteger, TaskType) {
    TaskTypeQuiz,
    TaskTypeAssignment,
    TaskTypeFinal
};

@interface Task : PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@property (assign) TaskType taskType;
@property (retain) Course *course;
@property (retain) NSString *name;
@property (retain) NSString *courseId;
@property (retain) NSString *description;
@property (retain) NSString *dueDate;
@property (retain) NSString *grade;
@end
