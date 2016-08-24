//
//  ATDatabaseManager.h
//  ATToDoListSQLite
//
//  Created by Felix ITs 01 on 23/08/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllConstants.h"
#import "Task.h"
#import <sqlite3.h>

@interface ATDatabaseManager : NSObject
{
    sqlite3 *myDatabase;
}

+(instancetype)sharedManager;
-(NSString *)getDatabasePath;
-(void)copyDatabaseFromMainBundleToSandbox;

-(BOOL)executeQuery:(NSString *)query;

-(NSArray *)executeSelectQuery:(NSString *)query;


-(BOOL)insertTask: (Task *)taskModel;
-(BOOL)updateTask:(Task *)taskModel;
-(void)deleteTask:(Task *)taskModel;

@end

