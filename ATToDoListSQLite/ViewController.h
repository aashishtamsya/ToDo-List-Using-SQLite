//
//  ViewController.h
//  ATToDoListSQLite
//
//  Created by Felix ITs 01 on 23/08/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "ATDatabaseManager.h"
#import "EditViewController.h"


@interface ViewController : UIViewController <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *allTasks;
}
- (IBAction)insertAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITableView *taskTableView;


@end

