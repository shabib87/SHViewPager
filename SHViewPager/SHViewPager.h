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

#import <UIKit/UIKit.h>

@class SHViewPager;

// enum to determine topbar menu button width
typedef NS_ENUM(NSInteger, SHViewPagerMenuWidthType) {
    SHViewPagerMenuWidthTypeDefault, // default width for menus, (screen_width / 5) i.e.64points wide in iPhone
    SHViewPagerMenuWidthTypeWide, // wider menus, (screen_width / 3) i.e. 107points wide in iPhone
    SHViewPagerMenuWidthTypeNarrow // narrow menus, (screen_width / 7) i.e. 46points wide in iPhone
};

@protocol SHViewPagerDataSource <NSObject>

@required

// total number of pages to be displayed by the controller
- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager;

// the viewcontroller that will contain the pages, in most of the cases it will be the same viewcontroller that is acting as the datasource and delegate
// i.e. return value will be 'self'
- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager;

// the viewcontroller that is to be shown as as a page in the pager
- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index;

@optional

// the indicator image for the current index page
// preferred image size is screen_width x 7
// i.e. if app runs on iphone, image size should be 320x7
- (UIImage *)indexIndicatorImageForViewPager:(SHViewPager *)viewPager;

// the indicator image during the scrolling animation state
// preferred image size is screen_width x 7
// i.e. if app runs on iphone, image size should be 320x7
// run and check example code to understand the behavior more clearly
- (UIImage *)indexIndicatorImageDuringScrollAnimationForViewPager:(SHViewPager *)viewPager;

// Important: either viewPager:imageForPageMenuAtIndex or viewPager:titleForPageMenuAtIndex has to be implemented, but not both

// the title to be displayed on the menu button,
// don't implement if viewPager:imageForPageMenuAtIndex is already implemented
- (NSString *)viewPager:(SHViewPager *)viewPager titleForPageMenuAtIndex:(NSInteger)index;

// the image to be displayed on the menu button
// don't implement if viewPager:titleForPageMenuAtIndex is already implemented
// preferred image size is button_width x 44
// i.e. if menuWidthTypeInViewPager: returns SHViewPageMenuWidthTypeDefault, then
// image size should be 64x44 in iPhone
- (UIImage *)viewPager:(SHViewPager *)viewPager imageForPageMenuAtIndex:(NSInteger)index;

// the title to be displayed right below the indicator image
// if not implemented, the area should be hidden and covered by the content view
- (NSString *)viewPager:(SHViewPager *)viewPager headerTitleForPageMenuAtIndex:(NSInteger)index;

// the image to be displayed for the menu button highlited state
// don't implement if viewPager:titleForPageMenuAtIndex is already implemented
// preferred image size is button_width x 44
// i.e. if menuWidthTypeInViewPager: returns SHViewPageMenuWidthTypeDefault, then
// image size should be 64x44 in iPhone
- (UIImage *)viewPager:(SHViewPager *)viewPager highlitedImageForPageMenuAtIndex:(NSInteger)index;

// the image to be displayed for the menu button selected state
// don't implement if viewPager:titleForPageMenuAtIndex is already implemented
// preferred image size is button_width x 44
// i.e. if menuWidthTypeInViewPager: returns SHViewPageMenuWidthTypeDefault, then
// image size should be 64x44 in iPhone
- (UIImage *)viewPager:(SHViewPager *)viewPager selectedImageForPageMenuAtIndex:(NSInteger)index;

// menu width type for the top bar
// if not implemented SHViewPagerMenuWidthTypeDefault will be counted
- (SHViewPagerMenuWidthType)menuWidthTypeInViewPager:(SHViewPager *)viewPager;

@end

@protocol SHViewPagerDelegate <NSObject>

@optional

// called when page is about to move
- (void)viewPager:(SHViewPager *)viewPager willMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

// called when a page has moved
- (void)viewPager:(SHViewPager *)viewPager didMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

// called when the first page is loaded
- (void)firstContentPageLoadedForViewPager:(SHViewPager *)viewPager;

@end

@interface SHViewPager : UIView

@property (nonatomic, weak) IBOutlet id <SHViewPagerDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id <SHViewPagerDelegate> delegate;

// returns the array of the menu buttons
@property (nonatomic, readonly) NSArray *menuButtons;

// returns a dictionay of the content viewcontrollers, key for the value is set as their index
@property (nonatomic, readonly) NSDictionary *contentViewControllers;

// populates or, re-populates the pager contents
// reloads everything from scratch
// pager will display nothing unless this method is called
// if the datasource is not changing, call it once at the begining
// if the datasource is dynamic and changing, call this method everytime you need
// to re-populate the pager (as you do in UITableView or, UIPickerView or, UICollectionView)
- (void)reloadData;

// fixes bug for scrollview's content offset reset.
// this is a hacky solution, any better solution is welcome.
// check closed issues #1 & #2 for more details.
-(void)pagerWillLayoutSubviews;

@end
