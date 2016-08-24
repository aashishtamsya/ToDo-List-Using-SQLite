//
//  EditViewController.m
//  ATToDoListSQLite
//
//  Created by Felix ITs 01 on 23/08/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    

    [self initScreen];
}

-(void)initScreen {
    
    selectedTask = self.taskSelected;
    self.textField.text = selectedTask.text;
    self.completedSwitch.on = selectedTask.completed;
    self.updateButton.enabled = NO;
    previousText = selectedTask.text;
    self.textField.enabled = NO;
    self.completedSwitch.enabled = NO;
    previousCompleted = selectedTask.completed;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)checkText:(NSString *)previousText current:(NSString *)currentText {
    
    if ([currentText isEqualToString:previousText]) {
        self.updateButton.enabled = NO;
    }
    else {
        self.updateButton.enabled = YES;
    }
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    selectedTask.text = self.textField.text;
    [textField resignFirstResponder];
    changedText = textField.text;
    [self checkText:previousText current:changedText];
    return YES;
}

- (IBAction)editAction:(id)sender {
    
    UIButton *button = sender;
    
    if ([button.titleLabel.text isEqualToString:@"Edit"]) {
        [button setTitle:@"Reset" forState:UIControlStateNormal];
        self.textField.enabled = YES;
        self.completedSwitch.enabled = YES;
    }
    else if ([button.titleLabel.text isEqualToString:@"Reset"]  ) {
        [button setTitle:@"Edit" forState:UIControlStateNormal];
        self.textField.enabled = NO;
        self.completedSwitch.enabled = NO;
        self.textField.text = previousText;
        self.completedSwitch.on = previousCompleted;
    }
    
    
    
}

- (IBAction)deleteAction:(id)sender {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are You Sure?" message:@"Once deleted, you will be unable to retrieve it back." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[ATDatabaseManager sharedManager]deleteTask:selectedTask];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}
- (IBAction)updateAction:(id)sender {
    
    if([[ATDatabaseManager sharedManager]updateTask:selectedTask]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Unable to update" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
    }
    
    
}
- (IBAction)completedAction:(id)sender {
    
    UISwitch *mySwitch = sender;
    
    if (mySwitch.isOn) {
        selectedTask.completed = YES;
    }
    else {
        selectedTask.completed = NO;
    }
    
    if (selectedTask.completed == previousCompleted) {
        self.updateButton.enabled = NO;
    }
    else {
        self.updateButton.enabled = YES;
    }
    
}
@end
