//
//  SHViewPagerDataSource.h
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

@class SHViewPager;

@protocol SHViewPagerDataSource <NSObject>

@required

/** total number of pages to be displayed by the controller */
- (NSInteger)numberOfPagesInViewPager:(SHViewPager  * _Nonnull)viewPager;

/**
 the viewcontroller that will contain the pages, in most of the cases it will be the same viewcontroller that is acting as the datasource and delegate;
 i.e. return value will be 'self'.
 */
- (UIViewController * _Nonnull)containerControllerForViewPager:(SHViewPager * _Nonnull)viewPager;

/** the viewcontroller that is to be shown as as a page in the pager */
- (UIViewController * _Nonnull)viewPager:(SHViewPager * _Nonnull)viewPager controllerForPageAtIndex:(NSInteger)index;

@optional

/**
 Important: either viewPager:imageForPageMenuAtIndex or viewPager:titleForPageMenuAtIndex has to be implemented, but not both.
 the title to be displayed on the menu button.
 don't implement if viewPager:imageForPageMenuAtIndex is already implemented.
 */
- (NSString * _Nonnull)viewPager:(SHViewPager * _Nonnull)viewPager titleForPageMenuAtIndex:(NSInteger)index;

/**
 the image to be displayed on the menu button.
 don't implement if viewPager:titleForPageMenuAtIndex is already implemented.
 preferred image size is button_width x 44;
 i.e. if menuWidthTypeInViewPager: returns SHViewPageMenuWidthTypeDefault, then
 image size should be 64x44 in iPhone.
 */
- (UIImage * _Nonnull)viewPager:(SHViewPager * _Nonnull)viewPager imageForPageMenuAtIndex:(NSInteger)index;

@end
