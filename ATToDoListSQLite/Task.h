//
//  Task.h
//  ATToDoListSQLite
//
//  Created by Felix ITs 01 on 23/08/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic,strong) NSString *task_id;
@property (nonatomic,strong) NSString *text;
@property (nonatomic) BOOL completed;
@property (nonatomic) int ID;


-(instancetype)initWithID:(int) idFrom
                  task_id:(NSString *)task_id
                     Text:(NSString *)textFrom
                completed:(BOOL)completedFrom;


@end
