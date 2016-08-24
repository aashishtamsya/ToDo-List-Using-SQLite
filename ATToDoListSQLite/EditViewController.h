//
//  EditViewController.h
//  ATToDoListSQLite
//
//  Created by Felix ITs 01 on 23/08/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "ATDatabaseManager.h"

@interface EditViewController : UIViewController <UITextFieldDelegate>
{
    Task *selectedTask;
    NSString *previousText;
    NSString *changedText;
    BOOL previousCompleted;
    BOOL changedCompleted;
}


@property (nonatomic,retain) Task *taskSelected;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)editAction:(id)sender;

- (IBAction)deleteAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *updateButton;

- (IBAction)updateAction:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *completedSwitch;


- (IBAction)completedAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textField;










@end
