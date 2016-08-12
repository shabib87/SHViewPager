SHViewPagerExample
==================

- A simple view pager for iOS. Compatible with iOS 6.0 or later.

##SHViewPager

`version 1.0`, compatible with iOS 6.0 or, later

**Created by** shabib hossain on 5/15/14.

**Copyright (c)** 2014 shabib hossain. All rights reserved.
- This software is licenced under MIT licence. Please check `LICENCE.md` for more details.

##How to use:

Take the `SHViewPager.h`, `SHViewPager.m` and `SHViewPagerController.h`, `SHViewPagerController.m` and add them to your project.
You can either, make your desired `UIViewController` class a `subclass` of `SHViewPagerController` or, create the `SHViewPager` in your code and subview it or, you can outlet it in your xib file.
The `SHViewPager` needs it's `datasource` and `delegate` protocol to be implemented.
Three `datasource` methods are required and others are optional.

**The required datasource methods are:**
```objc
// total number of pages to be displayed by the controller
- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager;
```
```objc
// the viewcontroller that will contain the pages, in most of the cases it will be the same viewcontroller that is acting as the datasource and delegate
// i.e. return value will be 'self'
- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager;
```
```objc
// the viewcontroller that is to be shown as as a page in the pager
- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index;
````

To display the contents, you need to call the instance method `reloadData` in your desired method block, typically in `viewDidLoad`.

-Example:

```objc
- (void)viewDidLoad
{
    [super viewDidLoad];
    // your code
    [viewPager reloadData];
}
```

Happy coding :)

Shabib Hossain

May 16, 2014
