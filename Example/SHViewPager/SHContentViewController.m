//
//  SHContentViewController.m
//  SHViewPager
//
//  Created by shabib hossain on 8/28/16.
//  Copyright © 2016 Code with Shabib. All rights reserved.
//

#import "SHContentViewController.h"

@interface SHContentViewController ()

@property (nonatomic, weak) IBOutlet UILabel *selectionLabel;

@end

@implementation SHContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    _selectionLabel.text = _selectionIndicatorString;
}

@end
