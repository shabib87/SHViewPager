SHViewPagerExample
==================

A simple view pager for iOS. Compatible with iOS 6.0 or later.

**SHViewPager**

`version 1.0`, compatible with `iOS 6.0` or, later

**Created by shabib hossain on 5/15/14.**

**Copyright (c) 2014 shabib hossain. All rights reserved.**

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

**How to use:**

Take the `SHViewPager.h`, `SHViewPager.m` and `SHViewPagerController.h`, `SHViewPagerController.m` and add them to your project.
You can either, make your desired UIViewController class a subclass of SHViewPagerController or, create the SHViewPager in your code and subview it or, you can outlet it in your xib file.
The SHViewPager needs it's datasource and delegate protocol to be implemented.
Three datasource methods are required and others are optional.

* The required datasource methods are:
```objC
// total number of pages to be displayed by the controller
- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager;
```
```
// the viewcontroller that will contain the pages, in most of the cases it will be the same viewcontroller that is acting as the datasource and delegate
// i.e. return value will be 'self'
- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager;
```

```
// the viewcontroller that is to be shown as as a page in the pager
- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index;
````

## Happy coding :)

Shabib Hossain

May 16, 2014
