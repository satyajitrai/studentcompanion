//
//  User.h
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/18/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "University.h"

@class Course;

@interface User : PFUser<PFSubclassing>

@property (retain) NSString *displayName;
@property (assign) ProgramType programType;
@property (assign) NSString *programName;
@property (assign) NSString *yearType;

- (void)getCoursesWithBlock:(void(^)(NSArray *objects, NSError *error))block;
- (void)addCourse:(Course *)course withBlock:(void(^)(BOOL succeeded, NSError *error))block;

@end
