//
//  SHViewPagerDelegate.h
//  SHViewPager
//
//  Created by shabib hossain on 9/20/16.
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

#import <Foundation/Foundation.h>

/**
 enum to determine topbar menu button width
 */
typedef NS_ENUM(NSInteger, SHViewPagerMenuWidthType) {
    SHViewPagerMenuWidthTypeDefault, /** default width for menus, (screen_width / 5) i.e.64points wide in iPhone */
    SHViewPagerMenuWidthTypeWide, /** wider menus, (screen_width / 3) i.e. 107points wide in iPhone */
    SHViewPagerMenuWidthTypeNarrow /** narrow menus, (screen_width / 7) i.e. 46points wide in iPhone */
};

@class SHViewPager;

@protocol SHViewPagerDelegate <NSObject>

@optional

/**
 the indicator image for the current index page.
 preferred image size is screen_width x 7;
 i.e. if app runs on iphone 5, image size should be 320x7;
 */
- (UIImage * _Nonnull)indexIndicatorImageForViewPager:(SHViewPager * _Nonnull)viewPager;

/**
 the indicator image during the scrolling animation state.
 preferred image size is screen_width x 7;
 i.e. if app runs on iphone 5, image size should be 320x7.
 run and check example code to understand the behavior more clearly.
 */
- (UIImage * _Nonnull)indexIndicatorImageDuringScrollAnimationForViewPager:(SHViewPager * _Nonnull)viewPager;

/** called when page is about to move. */
- (void)viewPager:(SHViewPager * _Nonnull)viewPager willMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

/** called when a page has moved. */
- (void)viewPager:(SHViewPager * _Nonnull)viewPager didMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

/** called when the first page is loaded. */
- (void)firstContentPageLoadedForViewPager:(SHViewPager * _Nonnull)viewPager;

/**
 the title to be displayed right below the indicator image
 if not implemented, the area should be hidden and covered by the content view
 */
- (NSString * _Nonnull)viewPager:(SHViewPager * _Nonnull)viewPager headerTitleForPageMenuAtIndex:(NSInteger)index;

/**
 the image to be displayed for the menu button highlited state.
 don't implement if viewPager:titleForPageMenuAtIndex is already implemented.
 preferred image size is button_width x 44;
 i.e. if menuWidthTypeInViewPager: returns SHViewPageMenuWidthTypeDefault, then
 image size should be 64x44 in iPhone.
 */
- (UIImage * _Nonnull)viewPager:(SHViewPager * _Nonnull)viewPager highlitedImageForPageMenuAtIndex:(NSInteger)index;

/**
 the image to be displayed for the menu button selected state.
 don't implement if viewPager:titleForPageMenuAtIndex is already implemented.
 preferred image size is button_width x 44;
 i.e. if menuWidthTypeInViewPager: returns SHViewPageMenuWidthTypeDefault, then
 image size should be 64x44 in iPhone.
 */
- (UIImage * _Nonnull)viewPager:(SHViewPager *  _Nonnull)viewPager selectedImageForPageMenuAtIndex:(NSInteger)index;

/**
 menu width type for the top bar.
 if not implemented SHViewPagerMenuWidthTypeDefault will be counted.
 */
- (SHViewPagerMenuWidthType)menuWidthTypeInViewPager:(SHViewPager * _Nonnull)viewPager;

/**
 background color for the top bar.
 if not implemented [UIColor whiteColor] will be used.
 */
- (UIColor * _Nonnull)backgroundColorForMenuInViewPager:(SHViewPager * _Nonnull)viewPager;

/**
 font for the menu.
 if not implemented, the system font will be used.
 */
- (UIFont * _Nonnull)fontForMenuInViewPager:(SHViewPager * _Nonnull)viewPager;

/**
 text color for the menu.
 if not implemented, the system font color will be used.
 */
- (UIColor * _Nonnull)textColorForMenuInViewPager:(SHViewPager * _Nonnull)viewPager;

@end
