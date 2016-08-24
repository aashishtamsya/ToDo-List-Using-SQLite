//
//  ATDatabaseManager.m
//  ATToDoListSQLite
//
//  Created by Felix ITs 01 on 23/08/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

#import "ATDatabaseManager.h"

@implementation ATDatabaseManager

+(instancetype)sharedManager {
    
    static ATDatabaseManager *sharedInstance;
    
    if (sharedInstance == nil) {
        sharedInstance = [[ATDatabaseManager alloc]init];
    }
    
    return sharedInstance;
    
}

-(NSString *)getDatabasePath {
    
    NSArray *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *databasePath = [[docDir objectAtIndex:0]stringByAppendingPathComponent:kDatabaseFullName];
    
    NSLog(@"DATABASE PATH \n\n%@\n\n",databasePath);
    
    return databasePath;
}


-(void)copyDatabaseFromMainBundleToSandbox
{
    NSString *sourcePath = [[NSBundle mainBundle]pathForResource:kDatabaseName ofType:kDatabaseExtension];
    
    NSLog(@"%@",sourcePath);
    
    NSString *destionationPath = [self getDatabasePath];
    
    BOOL isSourceExist = [[NSFileManager defaultManager]fileExistsAtPath:sourcePath];
    BOOL isDestionationExist = [[NSFileManager defaultManager]fileExistsAtPath:destionationPath];
    
    if (isSourceExist) {
        
        if (isDestionationExist) {
            NSLog(@"Database is already copied!");
        }
        else {
            //copy logic
            
            NSError *error;
            [[NSFileManager defaultManager]copyItemAtPath:sourcePath toPath:destionationPath error:&error];
            
            if (error) {
                NSLog(@"%@",error.localizedDescription);
            }
            else {
                NSLog(@"Successfully Copied Database.");
            }
            
        }
        
    }
    else {
        NSLog(@"Database Main Bundle madhe nai h.");
    }
}


-(BOOL)executeQuery:(NSString *)query {
    
    BOOL status = false;
    sqlite3_stmt *statement;
    const char * UTFQuery = [query UTF8String];
    const char * UTFDatabasePath = [[self getDatabasePath] UTF8String];
    
    if (sqlite3_open(UTFDatabasePath,&myDatabase) == SQLITE_OK) {
        
        if (sqlite3_prepare_v2(myDatabase,UTFQuery,-1,&statement,NULL) == SQLITE_OK) {
            
            if (sqlite3_step(statement) == SQLITE_DONE) {
                status = true;
            }
        }
        
        sqlite3_close(myDatabase);
        
    }
    
    return status;
    
}

-(NSArray *)executeSelectQuery:(NSString *)query {

    NSMutableArray *allTasks = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement;
    const char * UTFQuery = [query UTF8String];
    const char * UTFDatabasePath = [[self getDatabasePath] UTF8String];
    
    if (sqlite3_open(UTFDatabasePath,&myDatabase) == SQLITE_OK) {
        
        if (sqlite3_prepare_v2(myDatabase,UTFQuery,-1,&statement,NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                

                int idFrom = sqlite3_column_bytes(statement,0);
//                const unsigned char * UTFID = sqlite3_column_text(statement,0);
                
                const unsigned char * UTFTask_id = sqlite3_column_text(statement,1);
                
                const unsigned char * UTFText = sqlite3_column_text(statement,2);
                
                int completedInt = sqlite3_column_bytes(statement,3);
                
                BOOL completed = NO;
                
                if (completedInt == 0) {
                    completed = NO;
                }
                else if (completedInt == 1) {
                    completed = YES;
                }
                
                NSString *task_id = [NSString stringWithUTF8String:(const char *)UTFTask_id];
                
                NSString *text = [NSString stringWithUTF8String:(const char *)UTFText];
                
                Task *taskModel = [[Task alloc]initWithID:idFrom task_id:task_id Text:text completed:completed];
                
                [allTasks addObject:taskModel];
                
                
            }
        }
        
    }
    
    NSArray *array = [NSArray arrayWithArray:allTasks];
    
    return array;
}

-(BOOL)insertTask: (Task *)taskModel {
    NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO TASKS (TASK_ID,TEXT,COMPLETED) VALUES ('%@','%@','%d')",taskModel.task_id,taskModel.text,taskModel.completed];
    
    NSLog(@"%@",insertQuery);
    
    if([[ATDatabaseManager sharedManager]executeQuery:insertQuery] == YES) {
        return YES;
    }
    else {
        return NO;
    }
}

-(BOOL)updateTask:(Task *)taskModel {
    
    
    
    //    UPDATE COMPANY SET ADDRESS = 'Texas', SALARY = 20000.00;
    
    NSString *updateQuery = [NSString stringWithFormat:@"UPDATE TASKS SET TEXT = '%@', COMPLETED = '%d' WHERE TASK_ID = '%@'",taskModel.text,taskModel.completed,taskModel.task_id];
    
    if ([[ATDatabaseManager sharedManager]executeQuery:updateQuery]) {
        NSLog(@"Success : Updated Tasks %d",taskModel.ID);
        return YES;
    }
    else {
        NSLog(@"Unable to update task.");
        return NO;

    }
}


-(void)deleteTask:(Task *)taskModel {
//    DELETE FROM COMPANY WHERE ID = 7
    
    NSString *updateQuery = [NSString stringWithFormat:@"DELETE FROM TASKS WHERE TASK_ID = '%@'",taskModel.task_id];
    
    if ([[ATDatabaseManager sharedManager]executeQuery:updateQuery]) {
        NSLog(@"Success : Deleted Task %@",taskModel.task_id);
    }
    else {
        NSLog(@"Unable to delete task.");
        
    }
}


@end
