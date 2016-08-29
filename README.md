![KVNProgress](Images/codewithshabib.png)

# SHViewPager

[![Version](https://img.shields.io/cocoapods/v/SHViewPager.svg?style=flat)](http://cocoapods.org/pods/SHViewPager)
[![License](https://img.shields.io/cocoapods/l/SHViewPager.svg?style=flat)](http://cocoapods.org/pods/SHViewPager)
[![Platform](https://img.shields.io/cocoapods/p/SHViewPager.svg?style=flat)](http://cocoapods.org/pods/SHViewPager)

- A simple view pager for iOS, which acts similar to android's viewPager. Compatible with iOS 8.0 or later.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

**Recommended way**
SHViewPager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SHViewPager"
```

**Manual way**

Take the `SHViewPager.h`, `SHViewPager.m` and `SHViewPagerController.h`, `SHViewPagerController.m` and add them to your project.
You can either, make your desired `UIViewController` class a `subclass` of `SHViewPagerController` or, create the `SHViewPager` in your code and subview it or, you can outlet it in your xib file.

##How to use:

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
- (void)viewDidLoad {
    [super viewDidLoad];
    // your code
    [viewPager reloadData];
}
```

## Author

**Created by** Ahmad Shabibul Hossain on 5/15/14.

## License

SHViewPager is available under the MIT license. See the LICENSE file for more info.
