//
//  University.m
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/19/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "University.h"
#import <Parse/PFObject+Subclass.h>

@implementation University

+ (NSString *)parseClassName {
    return @"University";
}

@dynamic name;
@dynamic city;
@dynamic state;
@dynamic programType;
@dynamic minimumGPA;

+ (void)getUniversitiesWithBlock:(void(^)(NSArray *objects, NSError *error))block {
    PFQuery *query = [PFQuery queryWithClassName:[University parseClassName]];
    [query findObjectsInBackgroundWithBlock:block];
}

- (NSString *)programTypeString {
    switch (self.programType) {
        case ProgramTypeGraduate:
            return @"Graduate";
        case ProgramTypeHighSchool:
            return @"High School";
        case ProgramTypeUnderGrad:
            return @"Undergraduate";
    }
}

@end
