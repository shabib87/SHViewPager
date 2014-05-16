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

#import "SHImplementaion2VC.h"
#import "SHViewPager.h"
#import "SHContentVC.h"

@interface SHImplementaion2VC () <SHViewPagerDataSource, SHViewPagerDelegate>
{
    IBOutlet SHViewPager *pager;
    
    NSArray *menuItems;
}

@end

@implementation SHImplementaion2VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.navigationItem.title = @"Implementation Example 2";
        
        menuItems = [[NSArray alloc] initWithObjects:@"menu 1", @"menu 2", @"menu 3", @"menu 4", @"menu 5", @"menu 6", @"menu 7", @"menu 8", @"menu 9", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [pager reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SHViewPagerDataSource stack

- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager
{
    return menuItems.count;
}

- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager
{
    return self;
}

- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index
{
    SHContentVC *contentVC = [[SHContentVC alloc] initWithNibName:@"SHContentVC" bundle:nil];
    return contentVC;
}

- (UIImage *)indexIndicatorImageForViewPager:(SHViewPager *)viewPager
{
    return [UIImage imageNamed:@"horizontal_line.png"];
}

- (UIImage *)viewPager:(SHViewPager *)viewPager imageForPageMenuAtIndex:(NSInteger)index
{
    NSString *imageName = [NSString stringWithFormat:@"menu%d.png", index + 1];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)viewPager:(SHViewPager *)viewPager highlitedImageForPageMenuAtIndex:(NSInteger)index
{
    NSString *imageName = [NSString stringWithFormat:@"menu%d_h.png", index + 1];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)viewPager:(SHViewPager *)viewPager selectedImageForPageMenuAtIndex:(NSInteger)index
{
    NSString *imageName = [NSString stringWithFormat:@"menu%d_h.png", index + 1];
    return [UIImage imageNamed:imageName];
}

- (NSString *)viewPager:(SHViewPager *)viewPager headerTitleForPageMenuAtIndex:(NSInteger)index
{
    return [menuItems objectAtIndex:index];
}

- (SHViewPagerMenuWidthType)menuWidthTypeInViewPager:(SHViewPager *)viewPager
{
    return SHViewPagerMenuWidthTypeNarrow;
}

#pragma mark - SHViewPagerDelegate stack

- (void)firstContentPageLoadedForViewPager:(SHViewPager *)viewPager
{
    NSLog(@"first viewcontroller content loaded");
}

- (void)viewPager:(SHViewPager *)viewPager willMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"content will move to page %d from page: %d", toIndex, fromIndex);
}

- (void)viewPager:(SHViewPager *)viewPager didMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"content moved to page %d from page: %d", toIndex, fromIndex);
}

@end
