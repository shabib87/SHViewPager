# PodAsset

[![CI Status](http://img.shields.io/travis/haifengkao/PodAsset.svg?style=flat)](https://travis-ci.org/haifengkao/PodAsset)
[![Coverage Status](https://coveralls.io/repos/haifengkao/PodAsset/badge.svg?branch=master&service=github)](https://coveralls.io/github/haifengkao/PodAsset?branch=master)
[![Version](https://img.shields.io/cocoapods/v/PodAsset.svg?style=flat)](http://cocoapods.org/pods/PodAsset)
[![License](https://img.shields.io/cocoapods/l/PodAsset.svg?style=flat)](http://cocoapods.org/pods/PodAsset)
[![Platform](https://img.shields.io/cocoapods/p/PodAsset.svg?style=flat)](http://cocoapods.org/pods/PodAsset)

## Usage

Why is it so painful to access the assets in CocoaPods? 
Pain No More!

Get the damn image:
```objc
NSData* data = [PodAsset dataForFilename:@"SomeDamnImage.jpg" pod:@"SomePod"];
```

Get the damn json:
```objc
NSString* jsonString = [PodAsset stringForFilename:@"SomeDamn.json" pod:@"SomePod"];
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
The resource bundle name, by default, is the pod name. 
If not, please check the third party pod's podspec and find out the resource bundle name:
```ruby
  s.resource_bundles = {
    'PodAsset' => ['Pod/Assets/*.png']
  }
```
In the above example, the bundle name is `PodAsset`.

## Installation

PodAsset is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PodAsset"
```

## How It works

Pod Asset will search all bundles and find the correct one.

## Author

Hai Feng Kao, haifeng@cocoaspice.in

## License

PodAsset is available under the MIT license. See the LICENSE file for more info.
