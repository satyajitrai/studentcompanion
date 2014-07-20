//
//  Course.m
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/19/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "Course.h"
#import <Parse/PFObject+Subclass.h>

@implementation Course

+ (NSString *)parseClassName {
    return @"Course";
}

@dynamic name;
@dynamic user;
@dynamic overallGpa;
@dynamic courseType;
@dynamic assignmentGradePercent;
@dynamic quizGradePercent;
@dynamic finalGradePercent;

- (NSNumber*)totalGradePercentage {
    double total =  [self.assignmentGradePercent doubleValue] + [self.quizGradePercent doubleValue] + [self.finalGradePercent doubleValue];
    return [[NSNumber alloc] initWithDouble:total];
}

- (BOOL) isGradePercentageValid {
    if ([self.totalGradePercentage doubleValue] == 100.0)   {
        return YES;
    }
    else {
        return NO;
    }
}

+ (NSString*)nameForCourseType:(CourseType)courseType {
    switch (courseType) {
        case CourseTypeRegular:
            return @"Regular";
        case CourseTypeHonors:
            return @"Honors";
        case CourseTypeAP:
            return @"AP";
    }
}

@end
