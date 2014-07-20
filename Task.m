//
//  Task.m
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/19/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "Task.h"
#import <Parse/PFObject+Subclass.h>

@implementation Task

+ (NSString *)parseClassName {
    return @"Task";
}


@dynamic taskType;
@dynamic user;
@dynamic course;
@dynamic name;
@dynamic courseId;
@dynamic description;
@dynamic dueDate;
@dynamic grade;
@end