//
//  SHExample2VC.m
//  SHViewPager
//
//  Created by shabib hossain on 8/28/16.
//  Copyright © 2016 shabib87. All rights reserved.
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
