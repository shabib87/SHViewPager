//
//  SHViewPager.h
//  SHViewPager
//  version 1.0, compatible with iOS 6.0 and greater
//
//  Created by shabib hossain on 5/15/14.
//  Copyright (c) 2014 shabib hossain. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "SHContentVC.h"

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
