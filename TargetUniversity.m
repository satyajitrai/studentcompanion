//
//  TargetUniversity.m
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/21/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "TargetUniversity.h"
#import <Parse/PFObject+Subclass.h>

@implementation TargetUniversity

+(NSString *)parseClassName {
    return @"TargetUniversity";
}

@dynamic user;
@dynamic university;
@end
