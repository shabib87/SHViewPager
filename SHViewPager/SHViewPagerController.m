//
//  SHViewPagerController.m
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

#import "SHViewPagerController.h"

@implementation SHViewPagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewPager = [[SHViewPager alloc] initWithFrame:self.view.bounds];
    _viewPager.dataSource = self;
    _viewPager.delegate = self;
    
    [self.view addSubview:_viewPager];
}

#pragma mark - SHViewPagerDataSource stack

- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager
{
    @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #numberOfPagesInViewPager:" userInfo:nil]);
}

- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager
{
    @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #containerControllerForViewPager:" userInfo:nil]);
}

- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index
{
    @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #viewPager:controllerForPageAtIndex:" userInfo:nil]);
}

@end
