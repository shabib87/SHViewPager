//
//  SHViewPager.m
//  SHViewPager
//
//  Created by shabib hossain on 8/28/16.
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

#import "SHViewPager.h"

@interface SHViewPager () {
    NSInteger fromIndex;
    NSInteger toIndex;
    
    NSMutableArray *_menuButtons;
    NSMutableArray *_contentViews;
    
    NSMutableDictionary *_contentViewControllersViews;
}
@property (nonatomic, weak) UIViewController *containerViewController;

@property (nonatomic, weak) IBOutlet UIScrollView *topTabScroll;
@property (nonatomic, weak) IBOutlet UIScrollView *contentScroll;
@property (nonatomic, weak) IBOutlet UILabel *headerTitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *indexIndicatorImageView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentScrollTopConstraint;

@end

@implementation SHViewPager

- (id)init {
    if (self == [super init]) {
        [self commonInitWithNibName:@"SHViewPager"];
        [self commonSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self commonInitWithNibName:@"SHViewPager"];
        [self commonSetup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commonInitWithNibName:@"SHViewPager"];
        [self commonSetup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateFrames];
}

- (void)drawRect:(CGRect)rect {
    [self updateFrames];
}

- (void)updateFrames {
    [self updateMenuFrames];
    [self updateContentFrames];
}

- (void)updateMenuFrames {
    [self setNeedsLayout];
    NSInteger kTopTabMenuButtonWidth = [self menuWidth];
    NSInteger kTopTabMenuButtonOffsetX = [self menuOffsetX];
    int i = 0;
    for (UIButton *menuButton in _menuButtons) {
        menuButton.frame = CGRectMake(kTopTabMenuButtonOffsetX + kTopTabMenuButtonWidth * i, 0, kTopTabMenuButtonWidth, _topTabScroll.bounds.size.height);
        i++;
    }
}

- (void)updateContentFrames {
    [self setNeedsLayout];
    int i = 0;
    for (UIView *contentView in _contentViews) {
        contentView.frame = CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, _contentScroll.bounds.size.height);
        i++;
    }
}

-(void)commonSetup{
    _menuButtons = [[NSMutableArray alloc] init];
    _contentViews = [[NSMutableArray alloc] init];
    _contentViewControllersViews = [[NSMutableDictionary alloc] init];
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAction:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeAction:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    // Prevent SHViewPager from blocking tap to scroll to top gestures in sub views
    _topTabScroll.scrollsToTop = NO;
    _contentScroll.scrollsToTop = NO;
    [self addGestureRecognizer:rightSwipe];
    [self addGestureRecognizer:leftSwipe];
}

#pragma mark - reload data

-(void)reloadData {
    [self checkDataSourceIsSet];
    
    fromIndex =
    toIndex = 0;
    
    [_menuButtons removeAllObjects];
    [_contentViews removeAllObjects];
    [_contentViewControllersViews removeAllObjects];
    
    [_topTabScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_contentScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.containerViewController = [self.dataSource containerControllerForViewPager:self];
    
    // is supposed to fix bug for scrollview's content offset reset for iOS 7
    // but somehow doesn't work
    self.containerViewController.automaticallyAdjustsScrollViewInsets = NO;
    [self createPages];
}

#pragma mark - create view

-(void)setIndicatorImage {
    if ([self.delegate respondsToSelector:@selector(indexIndicatorImageForViewPager:)]) {
        _indexIndicatorImageView.backgroundColor = [UIColor clearColor];
        UIImage *indexIndicatorImage = [self.delegate indexIndicatorImageForViewPager:self];
        _indexIndicatorImageView.image = indexIndicatorImage;
    } else {
        _indexIndicatorImageView.backgroundColor = [UIColor redColor];
    }
}

-(void)createPages{
    [self setUpTopTab];
    [self setUpFirstContentView];
}

-(void)setUpTopTab{
    if ( [self.delegate respondsToSelector:@selector(backgroundColorForMenuInViewPager:)]) {
        _topTabScroll.backgroundColor = [self.delegate backgroundColorForMenuInViewPager:self];
    }
    NSInteger dataItems = [self.dataSource numberOfPagesInViewPager:self];
    for (NSInteger i = 0; i < dataItems; i++) {
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.backgroundColor = [UIColor clearColor];
        menuButton.tag = i;
        [menuButton addTarget:self action:@selector(changeIndexAction:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.dataSource respondsToSelector:@selector(viewPager:titleForPageMenuAtIndex:)] && (![self.dataSource respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)] || ![self.dataSource viewPager:self imageForPageMenuAtIndex:i])) {
            NSString *buttonTitle = [self.dataSource viewPager:self titleForPageMenuAtIndex:i];
            [menuButton setTitle:buttonTitle forState:UIControlStateNormal];
            if ( [self.delegate respondsToSelector:@selector(fontForMenuInViewPager:)] ) {
                menuButton.titleLabel.font = [self.delegate fontForMenuInViewPager:self];
            } else {
                menuButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            }
            
            if ( [self.delegate respondsToSelector:@selector(textColorForMenuInViewPager:)] ) {
                [menuButton setTitleColor:[self.delegate textColorForMenuInViewPager:self] forState:UIControlStateNormal];
            } else {
                [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            menuButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            menuButton.titleLabel.numberOfLines = 0;
            menuButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        if ([self.dataSource respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)] && (![self.dataSource respondsToSelector:@selector(viewPager:titleForPageMenuAtIndex:)] || ![self.dataSource viewPager:self titleForPageMenuAtIndex:i])) {
            UIImage *buttonImage = [self.dataSource viewPager:self imageForPageMenuAtIndex:i];
            [menuButton setImage:buttonImage forState:UIControlStateNormal];
            
            if ([self.dataSource respondsToSelector:@selector(viewPager:highlitedImageForPageMenuAtIndex:)]) {
                UIImage *highlitedButtonImage = [self.dataSource viewPager:self imageForPageMenuAtIndex:i];
                
                [menuButton setImage:highlitedButtonImage forState:UIControlStateHighlighted];
            }
        }
        
        [_topTabScroll addSubview:menuButton];
        [_menuButtons addObject:menuButton];
    }
}

-(void)setUpFirstContentView {
    NSInteger dataItems = [self.dataSource numberOfPagesInViewPager:self];
    for (NSInteger i = 0; i < dataItems; i++) {
        UIView *placeHolderView = [[UIView alloc] init];
        [_contentViews addObject:placeHolderView];
    }
    [self setUpContentViewForTargetIndex:0];
    [self setUpHeaderTitleTextAtIndex:0];
    if ([self.delegate respondsToSelector:@selector(viewPager:selectedImageForPageMenuAtIndex:)] && [self.delegate respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)]) {
        UIImage *buttonImage = [self.delegate viewPager:self selectedImageForPageMenuAtIndex:0];
        UIButton *button = [_menuButtons objectAtIndex:0];
        [button setImage:buttonImage forState:UIControlStateNormal];
        [self notifyDelegateAboutFirstContentPageLoaded];
    }
}

- (void)notifyDelegateAboutFirstContentPageLoaded {
    
    if ([self.delegate respondsToSelector:@selector(firstContentPageLoadedForViewPager:)]) {
        [_delegate firstContentPageLoadedForViewPager:self];
    }
}

-(void)setUpContentViewForTargetIndex:(NSInteger)index {
    NSString *vcKey = [NSString stringWithFormat:@"contentView-%ld",(long)index];
    if ([_contentViewControllersViews objectForKey:vcKey]) return;
    else {
        UIViewController *contentVC = [self.dataSource viewPager:self controllerForPageAtIndex:index];
        [_contentScroll addSubview:contentVC.view];
        [contentVC didMoveToParentViewController:self.containerViewController];
        [self.containerViewController addChildViewController:contentVC];
        [_contentViews replaceObjectAtIndex:index withObject:contentVC.view];
        [_contentViewControllersViews setObject:contentVC.view forKey:vcKey];
    }
    [self updateContentFrames];
}

-(void)setUpHeaderTitleTextAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(viewPager:headerTitleForPageMenuAtIndex:)]) {
        NSString *headerTitle = [self.delegate viewPager:self headerTitleForPageMenuAtIndex:index];
        _headerTitleLabel.text = headerTitle;
    } else {
        _headerTitleLabel.hidden = YES;
    }
}

-(NSInteger)menuWidth {
    SHViewPagerMenuWidthType widthType = [self menuWidthType];
    
    switch (widthType){
        case SHViewPagerMenuWidthTypeDefault:
            return self.bounds.size.width / 5;
            
        case SHViewPagerMenuWidthTypeNarrow:
            return self.bounds.size.width / 7;
            
        case SHViewPagerMenuWidthTypeWide:
            return self.bounds.size.width / 3;
            
        default:
            break;
    }
}

-(NSInteger)menuOffsetX {
    SHViewPagerMenuWidthType widthType = [self menuWidthType];
    
    NSInteger kTopTabWidth;
    switch (widthType) {
        case SHViewPagerMenuWidthTypeDefault:
            kTopTabWidth = self.bounds.size.width / 5;
            return kTopTabWidth * 2;
            
        case SHViewPagerMenuWidthTypeNarrow:
            kTopTabWidth = self.bounds.size.width / 7;
            return kTopTabWidth * 3;
            
        case SHViewPagerMenuWidthTypeWide:
            kTopTabWidth = self.bounds.size.width / 3;
            return kTopTabWidth;
            
        default:
            break;
    }
}

-(SHViewPagerMenuWidthType)menuWidthType {
    if ([self.delegate respondsToSelector:@selector(menuWidthTypeInViewPager:)]) {
        return [self.delegate menuWidthTypeInViewPager:self];
    }
    return SHViewPagerMenuWidthTypeDefault;
}

#pragma mark - datasource debugging

-(void)checkDataSourceIsSet {
    if (!self.dataSource) {
        @throw ([NSException exceptionWithName:@"DataSourceNotFoundException" reason:@"There is no dataSource for the viewPager" userInfo:nil]);
    }
    
    if (![self.dataSource respondsToSelector:@selector(numberOfPagesInViewPager:)]) {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #numberOfPagesInViewPager:" userInfo:nil]);
    }
    
    if (![self.dataSource respondsToSelector:@selector(containerControllerForViewPager:)]) {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #containerControllerForViewPager:" userInfo:nil]);
    }
    
    if (![self.dataSource respondsToSelector:@selector(viewPager:controllerForPageAtIndex:)]) {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #viewPager:controllerForPageAtIndex:" userInfo:nil]);
    }
    
    if (!([self.dataSource respondsToSelector:@selector(viewPager:titleForPageMenuAtIndex:)] || [self.dataSource respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)])) {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #viewPager:titleForPageMenuAtIndex: or #viewPager:imageForPageMenuAtIndex:, not both" userInfo:nil]);
    }
    
    if ([self.dataSource respondsToSelector:@selector(viewPager:titleForPageMenuAtIndex:)] && ([self.dataSource respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)] || [self.dataSource respondsToSelector:@selector(viewPager:selectedImageForPageMenuAtIndex:)] || [self.dataSource respondsToSelector:@selector(viewPager:highlitedImageForPageMenuAtIndex:)])) {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #viewPager:titleForPageMenuAtIndex: or #viewPager:imageForPageMenuAtIndex:, not both. #viewPager:selectedImageForPageMenuAtIndex and #viewPager:highlitedImageForPageMenuAtIndex only to be implemented if #viewPager:imageForPageMenuAtIndex is implemented instead of #viewPager:titleForPageMenuAtIndex" userInfo:nil]);
    }
}

#pragma mark - target action methods

-(void)changeIndexAction:(UIButton *)sender {
    fromIndex = toIndex;
    toIndex = sender.tag;
    [self moveToTargetIndex];
}

-(void)leftSwipeAction:(UISwipeGestureRecognizer *)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (toIndex < _menuButtons.count - 1) {
            fromIndex = toIndex;
            toIndex++;
            [self moveToTargetIndex];
        }
    }
}

-(void)rightSwipeAction:(UISwipeGestureRecognizer *)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        if (toIndex > 0) {
            fromIndex = toIndex;
            toIndex--;
            [self moveToTargetIndex];
        }
    }
}

-(void)moveToTargetIndex {
    [self setUpHeaderTitleTextAtIndex:toIndex];
    [self setUpContentViewForTargetIndex:toIndex];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        if ([self.delegate respondsToSelector:@selector(indexIndicatorImageForViewPager:)] && [self.delegate respondsToSelector:@selector(indexIndicatorImageDuringScrollAnimationForViewPager:)]) {
            _indexIndicatorImageView.image = [self.delegate indexIndicatorImageDuringScrollAnimationForViewPager:self];
        }
        
        if ([self.delegate respondsToSelector:@selector(viewPager:selectedImageForPageMenuAtIndex:)] && [self.delegate respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)]) {
            UIImage *buttonImage = [self.dataSource viewPager:self imageForPageMenuAtIndex:fromIndex];
            UIButton *button = [_menuButtons objectAtIndex:fromIndex];
            [button setImage:buttonImage forState:UIControlStateNormal];
            
            UIImage *selectedImage = [self.delegate viewPager:self selectedImageForPageMenuAtIndex:toIndex];
            UIButton *selectedButton = [_menuButtons objectAtIndex:toIndex];
            [selectedButton setImage:selectedImage forState:UIControlStateNormal];
        }
        
        if ([self.delegate respondsToSelector:@selector(viewPager:willMoveToPageAtIndex:fromIndex:)]) {
            [self.delegate viewPager:self willMoveToPageAtIndex:toIndex fromIndex:fromIndex];
        }
        [_topTabScroll setContentOffset:CGPointMake((toIndex * [self menuWidth]), 0)];
        [_contentScroll setContentOffset:CGPointMake(toIndex * CGRectGetWidth(self.bounds), 0)];
    } completion:^(BOOL finished){
        
        if ([self.delegate respondsToSelector:@selector(viewPager:didMoveToPageAtIndex:fromIndex:)]) {
            [self.delegate viewPager:self didMoveToPageAtIndex:toIndex fromIndex:fromIndex];
        }
        
        if ([self.delegate respondsToSelector:@selector(indexIndicatorImageForViewPager:)] && [self.delegate respondsToSelector:@selector(indexIndicatorImageDuringScrollAnimationForViewPager:)]) {
            _indexIndicatorImageView.image = [self.delegate indexIndicatorImageForViewPager:self];
        }
    }];
}

#pragma mark - view properties

-(NSArray *)menuButtons {
    return _menuButtons;
}

-(NSDictionary *)contentViewControllers {
    return _contentViewControllersViews;
}

-(void)pagerWillLayoutSubviews {
    [self moveToTargetIndex];
}

@end
