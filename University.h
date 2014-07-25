//
//  University.h
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/19/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <Parse/Parse.h>

typedef NS_ENUM(NSInteger, ProgramType) {
    ProgramTypeHighSchool,
    ProgramTypeUnderGrad,
    ProgramTypeGraduate
};

typedef NS_ENUM(NSInteger, YearType) {
    YearTypeFreshman,
    YearTypeSophmore,
    YearTypeJunior,
    YearTypeSenior
};

@interface University : PFObject<PFSubclassing>

+ (NSString *)parseClassName;
+(void)getUniversitiesWithBlock:(void(^)(NSArray *objects, NSError *error))block;

@property (retain) NSString *name;
@property (retain) NSString *city;
@property (retain) NSString *state;
@property (assign) ProgramType programType;
@property (retain) NSNumber *minimumGPA;

- (NSString*)programTypeString;

@end
