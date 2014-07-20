//
//  Course.h
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/19/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <Parse/Parse.h>

typedef NS_ENUM(NSInteger, CourseType) {
    CourseTypeRegular,
    CourseTypeHonors,
    CourseTypeAP
};

@interface Course : PFObject<PFSubclassing>

+ (NSString *)parseClassName;
+ (NSString*)nameForCourseType:(CourseType)courseType;

@property (retain) NSString *name;
@property (retain) NSNumber *overallGpa;
@property (assign) CourseType courseType;
@property (retain) NSNumber *assignmentGradePercent;
@property (retain) NSNumber *quizGradePercent;
@property (retain) NSNumber *finalGradePercent;

- (NSNumber*) totalGradePercentage;
- (BOOL) isGradePercentageValid;

@end
