//
//  SHContentVC.m
//  SHViewPager
//  version 1.0, compatible with iOS 6.0 and greater
//
//  Created by shabib hossain on 5/15/14.
//  Copyright (c) 2014 shabib hossain. All rights reserved.
//
//  This software is licenced under MIT licence.
//  Please check LICENCE.md for more details.
//

#import "SHContentVC.h"
#import "SHBugCheckVC.h"

@interface SHContentVC () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITextField *inputField;
    IBOutlet UILabel *inputLabel;
    IBOutlet UILabel *selectionLabel;
}

@end

@implementation SHContentVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    inputLabel.text = textField.text;
    [textField resignFirstResponder];
    
    return YES;
}

-(IBAction)updateInputLabel:(id)sender
{
    inputLabel.text = inputField.text;
    [inputField resignFirstResponder];
}

-(IBAction)resetLabels:(id)sender
{
    inputLabel.text = @"insert text and press update";
    selectionLabel.text = @"select a row from the table";
}

-(IBAction)pushBugAction:(id)sender
{
    SHBugCheckVC *bugVC = [[SHBugCheckVC alloc] initWithNibName:@"SHBugCheckVC" bundle:nil];
    
    [self.navigationController pushViewController:bugVC animated:YES];
}

#pragma mark - tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"table cell %d", indexPath.row + 1];
    
    return cell;
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectionLabel.text = [NSString stringWithFormat:@"cell %d selected", indexPath.row + 1];
}

@end
