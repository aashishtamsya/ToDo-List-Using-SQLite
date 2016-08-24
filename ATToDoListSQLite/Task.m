//
//  Task.m
//  ATToDoListSQLite
//
//  Created by Felix ITs 01 on 23/08/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

#import "Task.h"

@implementation Task
@synthesize completed;
@synthesize text;
@synthesize task_id;
@synthesize ID;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.text = @"";
        self.completed = NO;
    }
    return self;
}

-(instancetype)initWithID:(int) idFrom
                  task_id:(NSString *)task_id
                     Text:(NSString *)textFrom
                completed:(BOOL)completedFrom {
    
    Task *taskModel = [[Task alloc]init];
    taskModel.task_id = task_id;
    taskModel.ID = idFrom;
    taskModel.text = textFrom;
    taskModel.completed = completedFrom;
    return taskModel;
}


@end
