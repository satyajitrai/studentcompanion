//
//  TaskType.m
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/19/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "TaskType.h"
#import <Parse/PFObject+Subclass.h>

@implementation TaskType

+ (NSString *)parseClassName {
    return @"TaskType";
}

@dynamic name;
@dynamic description;

@end
