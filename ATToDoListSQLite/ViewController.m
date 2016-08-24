//
//  ViewController.m
//  ATToDoListSQLite
//
//  Created by Felix ITs 01 on 23/08/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self updateTaskTableView];
}

-(void)fetchAllTask {
    
    allTasks = [[ATDatabaseManager sharedManager]executeSelectQuery:@"SELECT * FROM TASKS"];
    
}


-(void)updateTaskTableView {
    
    [self fetchAllTask];
    if (allTasks.count > 0) {
        [self.taskTableView reloadData];

    }
}

-(void)insertTask:(NSString *)text {
    if (text.length > 0 && ![text isEqualToString:@""]) {
        
        Task *taskModel = [[Task alloc]init];
        taskModel.text = text;
        taskModel.task_id = [text uppercaseString];
        
        if ([[ATDatabaseManager sharedManager]insertTask:taskModel]) {
            NSLog(@"Task inserted.");
            [self updateTaskTableView];
            self.textField.text = @"";
        }
        else {
            NSLog(@"Unable to insert task.");
        }
        
    }
}

- (IBAction)insertAction:(id)sender {
    
    NSString *text = self.textField.text;
    
    [self insertTask:text];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSString *text = self.textField.text;
    
    [self insertTask:text];
    
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return allTasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    Task *taskModel = [allTasks objectAtIndex:indexPath.row];
    
    cell.textLabel.text = taskModel.text;

    if (taskModel.completed) {
        cell.backgroundColor = [UIColor greenColor];
    }
    else {
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EditViewController *editView = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    
    editView.taskSelected = [allTasks objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:editView animated:YES];
    
}


@end
