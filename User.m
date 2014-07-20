//
//  User.m
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/18/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "User.h"
#import <Parse/PFObject+Subclass.h>
#import "Course.h"

@implementation User

@dynamic displayName;
@dynamic programType;
@dynamic programName;
@dynamic yearType;

- (void)getCoursesWithBlock:(void(^)(NSArray *objects, NSError *error))block {
    PFQuery *query = [PFQuery queryWithClassName:[Course parseClassName]];
    [query whereKey:@"user" equalTo:(User*)self];
    
    [query findObjectsInBackgroundWithBlock:block];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@ displayName: %@", super.description, self.displayName];
}

@end
