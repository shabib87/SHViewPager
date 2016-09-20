//
//  SHViewPager.h
//  SHViewPager

//
//  Created by shabib hossain on 5/15/14.
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

#import <UIKit/UIKit.h>
#import "SHBaseView.h"
#import "SHViewPagerDelegate.h"
#import "SHViewPagerDataSource.h"

@interface SHViewPager : SHBaseView

@property (nonatomic, nonnull) IBOutlet id <SHViewPagerDataSource> dataSource;
@property (nonatomic, nonnull) IBOutlet id <SHViewPagerDelegate> delegate;

/** returns the array of the menu buttons. */
@property (nonatomic, readonly, nonnull) NSArray *menuButtons;

/** returns a dictionay of the content viewcontrollers, key for the value is set as their index. */
@property (nonatomic, readonly, nonnull) NSDictionary *contentViewControllers;

/**
 populates or, re-populates the pager contents.
 reloads everything from scratch.
 pager will display nothing unless this method is called.
 if the datasource is not changing, call it once at the begining.
 if the datasource is dynamic and changing, call this method everytime you need.
 to re-populate the pager (as you do in UITableView or, UIPickerView or, UICollectionView).
 */
- (void)reloadData;

/**
 fixes bug for scrollview's content offset reset.
 this is a hacky solution, any better solution is welcome.
 check closed issues #1 & #2 for more details.
 */
-(void)pagerWillLayoutSubviews;

@end
