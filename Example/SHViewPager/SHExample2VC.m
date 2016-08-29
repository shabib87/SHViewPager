//
//  SHExample2VC.m
//  SHViewPager
//
//  Created by shabib hossain on 8/28/16.
//  Copyright © 2014-2016 Code with Shabib. All rights reserved.
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

#import "SHExample2VC.h"
#import "SHViewPager.h"
#import "SHContentViewController.h"

@interface SHExample2VC () <SHViewPagerDataSource, SHViewPagerDelegate> {
    NSArray *menuItems;
}

@property (nonatomic, weak) IBOutlet SHViewPager *pager;

@end

@implementation SHExample2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    menuItems = [[NSArray alloc] initWithObjects:@"menu 1", @"menu 2", @"menu 3", @"menu 4", @"menu 5", @"menu 6", @"menu 7", @"menu 8", @"menu 9", nil];
    [_pager reloadData];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // fixes bug for scrollview's content offset reset.
    // check SHViewPager's reloadData method to get the idea.
    // this is a hacky solution, any better solution is welcome.
    // check closed issues #1 & #2 for more details.
    // this is the example to fix the bug, to test this
    // comment out the following lines
    // and check what happens.
    
    if (menuItems.count) {
        [_pager pagerWillLayoutSubviews];
    }
}

#pragma mark - SHViewPagerDataSource stack

- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager {
    return menuItems.count;
}

- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager {
    return self;
}

- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index {
    SHContentViewController *contentVC = [[SHContentViewController alloc] initWithNibName:@"SHContentViewController" bundle:nil];
    contentVC.selectionIndicatorString = [NSString stringWithFormat:@"Currently Selected :index %ld", index + 1];
    return contentVC;
}

- (UIImage *)indexIndicatorImageForViewPager:(SHViewPager *)viewPager {
    return [UIImage imageNamed:@"IndexIndicatorIcon"];
}

- (UIImage *)indexIndicatorImageDuringScrollAnimationForViewPager:(SHViewPager *)viewPager {
    return [UIImage imageNamed:@"IndexIndicatorMovingIcon"];
}

- (UIImage *)viewPager:(SHViewPager *)viewPager imageForPageMenuAtIndex:(NSInteger)index {
    NSString *imageName = [NSString stringWithFormat:@"Menu%ld", index + 1];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)viewPager:(SHViewPager *)viewPager highlitedImageForPageMenuAtIndex:(NSInteger)index {
    NSString *imageName = [NSString stringWithFormat:@"Menu%ld_h", index + 1];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)viewPager:(SHViewPager *)viewPager selectedImageForPageMenuAtIndex:(NSInteger)index {
    NSString *imageName = [NSString stringWithFormat:@"Menu%ld_h", index + 1];
    return [UIImage imageNamed:imageName];
}

- (NSString *)viewPager:(SHViewPager *)viewPager headerTitleForPageMenuAtIndex:(NSInteger)index {
    return [menuItems objectAtIndex:index];
}

- (SHViewPagerMenuWidthType)menuWidthTypeInViewPager:(SHViewPager *)viewPager {
    return SHViewPagerMenuWidthTypeNarrow;
}

#pragma mark - SHViewPagerDelegate stack

- (void)firstContentPageLoadedForViewPager:(SHViewPager *)viewPager {
    NSLog(@"first viewcontroller content loaded");
}

- (void)viewPager:(SHViewPager *)viewPager willMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    NSLog(@"content will move to page %ld from page: %ld", toIndex, (long)fromIndex);
}

- (void)viewPager:(SHViewPager *)viewPager didMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    NSLog(@"content moved to page %ld from page: %ld", toIndex, (long)fromIndex);
}

@end
