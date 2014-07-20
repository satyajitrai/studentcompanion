//
//  TaskType.h
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/19/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <Parse/Parse.h>

@interface TaskType : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) NSString *name;
@property (retain) NSString *description;
@end
