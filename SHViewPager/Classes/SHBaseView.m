//
//  SHBaseView.h
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

#import "SHBaseView.h"
#import "PodAsset.h"

@interface SHBaseView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;

@end

@implementation SHBaseView

- (void)commonInitWithNibName:(NSString *)nibName {
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *view = [self viewNibName:nibName];
    _customConstraints = [[NSMutableArray alloc] init];
    [self setSubview:view];
}

- (void)commonInitWithView:(UIView *)contentView {
    _customConstraints = [[NSMutableArray alloc] init];
    [self setSubview:contentView];
}

- (void)setSubview:(UIView *)view {
    
    if (view != nil) {
        
        _containerView = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self setNeedsUpdateConstraints];
    }
}

- (UIView *)viewNibName:(NSString *)nibName {
    
    UIView *view = nil;
    NSString *bundlePath = [PodAsset bundlePathForPod:@"SHViewPager"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSArray *objects = [bundle loadNibNamed:nibName owner:self options:nil];

    for (id object in objects) {
        
        if ([object isKindOfClass:[UIView class]]) {
            
            view = object;
            break;
        }
    }
    
    return view;
}

- (void)updateConstraints {
    
    [self clearConstraints];
    
    if (self.containerView != nil) {
        
        [self setViewConstraints];
    }
    
    [super updateConstraints];
}

- (void)setViewConstraints {
    
    UIView *view = self.containerView;
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    [self.customConstraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:views]];
    [self.customConstraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];
    [self addConstraints:self.customConstraints];
}

- (void)clearConstraints {
    
    [self removeConstraints:self.customConstraints];
    [self.customConstraints removeAllObjects];
}

@end
