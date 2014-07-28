//
//  TargetUniversity.h
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/21/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <Parse/Parse.h>

@class User;
@class University;

@interface TargetUniversity : PFObject<PFSubclassing>

+(NSString *)parseClassName;

@property (retain) User *user;
@property (retain) University *university;
@end
