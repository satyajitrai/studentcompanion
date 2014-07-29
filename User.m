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
#import "TargetUniversity.h"

@implementation User

@dynamic displayName;
@dynamic programType;
@dynamic programName;
@dynamic yearType;

- (void)getCoursesWithBlock:(void(^)(NSArray *courses, NSError *error))block {
    PFQuery *query = [PFQuery queryWithClassName:[Course parseClassName]];
    [query whereKey:@"user" equalTo:(User*)self];
    
    [query findObjectsInBackgroundWithBlock:block];
}

- (void) addCourse:(Course *)course withBlock:(void(^)(BOOL succeeded, NSError *error))block {
    course.user = (User*)self;
    [course saveInBackgroundWithBlock:block];
}

- (void)getUniversitiesWithBlock:(void(^)(NSArray *universities, NSError *error))block {
    PFQuery *query = [PFQuery queryWithClassName:[University parseClassName]];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    //[query whereKey:@"user" equalTo:(User*)self];
    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error) {
//            block(objects, error);
//        } else {
//            NSMutableArray *universities = [[NSMutableArray alloc] init];
//            for (TargetUniversity *tu in objects) {
//                [universities addObject:tu.university];
//            }
//            block(universities, error);
//        }
//    }];
    
    [query findObjectsInBackgroundWithBlock:block];
}

- (void)addUniversity:(University *)university withBlock:(void(^)(BOOL succeeded, NSError *error))block {
    [university saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error saving university: %@", error.description);
        } else {
            NSLog(@"Saved University %@", university);
//            TargetUniversity *targetUniversity = [TargetUniversity object];
//            targetUniversity.university = (University *)university;
//            targetUniversity.user = (User*)self;
//            [targetUniversity saveInBackgroundWithBlock:block];
            block(succeeded, error);
        }
    }];
}

@end
