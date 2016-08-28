//
//  SHExample1VC.m
//  SHViewPager
//
//  Created by shabib hossain on 8/28/16.
//  Copyright © 2016 shabib87. All rights reserved.
//

#import "SHExample1VC.h"
#import "SHContentViewController.h"

@interface SHExample1VC () {
    NSArray *menuItems;
}

@end

@implementation SHExample1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuItems = [[NSArray alloc] initWithObjects:@"menu 1", @"menu 2", @"menu 3", @"menu 4", @"menu 5", @"menu 6", @"menu 7", @"menu 8", @"menu 9", nil];
    [self.viewPager reloadData];
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
        [self.viewPager pagerWillLayoutSubviews];
    }
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
    SHContentViewController *contentVC = [[SHContentViewController alloc] initWithNibName:@"SHContentViewController" bundle:nil];
    contentVC.selectionIndicatorString = [NSString stringWithFormat:@"Currently Selected :%ld index", index];
    return contentVC;
}

- (UIImage *)indexIndicatorImageForViewPager:(SHViewPager *)viewPager {
    return [UIImage imageNamed:@"horizontal_line.png"];
}

- (UIImage *)indexIndicatorImageDuringScrollAnimationForViewPager:(SHViewPager *)viewPager {
    return [UIImage imageNamed:@"horizontal_line_moving.png"];
}

- (NSString *)viewPager:(SHViewPager *)viewPager titleForPageMenuAtIndex:(NSInteger)index {
    return [menuItems objectAtIndex:index];
}

- (SHViewPagerMenuWidthType)menuWidthTypeInViewPager:(SHViewPager *)viewPager {
    return SHViewPagerMenuWidthTypeWide;
}

#pragma mark - SHViewPagerDelegate stack

- (void)firstContentPageLoadedForViewPager:(SHViewPager *)viewPager {
    NSLog(@"first viewcontroller content loaded");
}

- (void)viewPager:(SHViewPager *)viewPager willMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    NSLog(@"content will move to page %ld from page: %ld", toIndex, fromIndex);
}

- (void)viewPager:(SHViewPager *)viewPager didMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    NSLog(@"content moved to page %ld from page: %ld", toIndex, fromIndex);
}

@end
