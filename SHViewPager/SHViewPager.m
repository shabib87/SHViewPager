//
//  SHViewPager.m
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

#import "SHViewPager.h"

@interface SHViewPager ()
{
    UIScrollView *topTabScroll;
    UIScrollView *contentScroll;
    
    UILabel *headerTitleLabel;
    
    UIImageView *indexIndicatorImageView;
    
    NSInteger fromIndex;
    NSInteger toIndex;
    
    NSMutableArray *_menuButtons;
    NSMutableDictionary *_contentViewControllers;
}

@property (nonatomic, strong) UIViewController *containerViewController;

@end

@implementation SHViewPager

@synthesize dataSource;
@synthesize delegate;

@synthesize containerViewController;

#pragma mark - Initialization

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self commonSetup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self commonSetup];
}

-(void)commonSetup
{
    _menuButtons = [[NSMutableArray alloc] init];
    _contentViewControllers = [[NSMutableDictionary alloc] init];
    
    topTabScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
    
    if ( [self.dataSource respondsToSelector:@selector(colorForMenuInViewPager:)] )
    {
        topTabScroll.backgroundColor = [self.dataSource colorForMenuInViewPager:self];
    }
    else
    {
        topTabScroll.backgroundColor = [UIColor whiteColor];
    }

    indexIndicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, self.bounds.size.width, 7)];
    
    headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, self.bounds.size.width, 20)];
    headerTitleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    headerTitleLabel.textColor = [UIColor lightGrayColor];
    headerTitleLabel.backgroundColor = [UIColor whiteColor];
    headerTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 71, self.bounds.size.width, self.bounds.size.height - 71)];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAction:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeAction:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self addSubview:topTabScroll];
    [self addSubview:indexIndicatorImageView];
    [self addSubview:headerTitleLabel];
    [self addSubview:contentScroll];
    
    [self addGestureRecognizer:rightSwipe];
    [self addGestureRecognizer:leftSwipe];
}

-(void)pagerWillLayoutSubviews
{
    [self moveToTargetIndex];
}

#pragma mark - reload data

-(void)reloadData
{
    [self checkDataSourceIsSet];
    
    fromIndex =
    toIndex = 0;
    
    [_menuButtons removeAllObjects];
    [_contentViewControllers removeAllObjects];
    
    [topTabScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [contentScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (![self.dataSource respondsToSelector:@selector(viewPager:headerTitleForPageMenuAtIndex:)])
    {
        headerTitleLabel.hidden = YES;
        contentScroll.frame = CGRectMake(0, 51, self.bounds.size.width, self.bounds.size.height - 51);
    }
    
    self.containerViewController = [self.dataSource containerControllerForViewPager:self];
    
    // is supposed to fix bug for scrollview's content offset reset for iOS 7
    // but somehow doesn't work
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        self.containerViewController.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self setIndicatorImage];
    [self createPages];
}

#pragma mark - create view

-(void)setIndicatorImage
{
    if ([self.dataSource respondsToSelector:@selector(indexIndicatorImageForViewPager:)])
    {
        indexIndicatorImageView.backgroundColor = [UIColor clearColor];
        UIImage *indexIndicatorImage = [self.dataSource indexIndicatorImageForViewPager:self];
        
        indexIndicatorImageView.image = indexIndicatorImage;
    }
    else
    {
        indexIndicatorImageView.backgroundColor = [UIColor redColor];
    }
}

-(void)createPages
{
    [self setUpTopTab];
    [self setUpFirstContentView];
}

-(void)setUpTopTab
{
    NSInteger dataItems = [self.dataSource numberOfPagesInViewPager:self];
    
    NSInteger kTopTabWidth = [self menuWidth];
    NSInteger kTopTabOffsetX = [self menuOffsetX];
    
    for (NSInteger i = 0; i < dataItems; i++)
    {
        UIButton *catButton = [UIButton buttonWithType:UIButtonTypeCustom];
        catButton.frame = CGRectMake(kTopTabOffsetX + kTopTabWidth * i, 0, kTopTabWidth, topTabScroll.bounds.size.height);
        catButton.backgroundColor = [UIColor clearColor];
        
        catButton.tag = i;
        [catButton addTarget:self action:@selector(changeIndexAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.dataSource respondsToSelector:@selector(viewPager:titleForPageMenuAtIndex:)] && (![self.dataSource respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)] || ![self.dataSource viewPager:self imageForPageMenuAtIndex:i]))
        {
            NSString *buttonTitle = [self.dataSource viewPager:self titleForPageMenuAtIndex:i];
            
            [catButton setTitle:buttonTitle forState:UIControlStateNormal];
            [catButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            if ( [self.dataSource respondsToSelector:@selector(fontForMenu:)] )
            {
                catButton.titleLabel.font = [self.dataSource fontForMenu:self];
            }
            else
            {
                catButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            }
            
            catButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            catButton.titleLabel.numberOfLines = 0;
            catButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        if ([self.dataSource respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)] && (![self.dataSource respondsToSelector:@selector(viewPager:titleForPageMenuAtIndex:)] || ![self.dataSource viewPager:self titleForPageMenuAtIndex:i]))
        {
            UIImage *buttonImage = [self.dataSource viewPager:self imageForPageMenuAtIndex:i];
            
            [catButton setImage:buttonImage forState:UIControlStateNormal];
            
            if ([self.dataSource respondsToSelector:@selector(viewPager:highlitedImageForPageMenuAtIndex:)])
            {
                UIImage *highlitedButtonImage = [self.dataSource viewPager:self imageForPageMenuAtIndex:i];
                
                [catButton setImage:highlitedButtonImage forState:UIControlStateHighlighted];
            }
        }
        
        [topTabScroll addSubview:catButton];
        [_menuButtons addObject:catButton];
    }
}

-(void)setUpFirstContentView
{
    [self setUpContentViewForTargetIndex:0];
    [self setUpHeaderTitleTextAtIndex:0];
    
    if ([self.dataSource respondsToSelector:@selector(viewPager:selectedImageForPageMenuAtIndex:)] && [self.dataSource respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)])
    {
        UIImage *buttonImage = [self.dataSource viewPager:self selectedImageForPageMenuAtIndex:0];
        UIButton *button = [_menuButtons objectAtIndex:0];
        [button setImage:buttonImage forState:UIControlStateNormal];
    }
    
    if ([self.delegate respondsToSelector:@selector(firstContentPageLoadedForViewPager:)])
    {
        [delegate firstContentPageLoadedForViewPager:self];
    }
}

-(void)setUpContentViewForTargetIndex:(int)index
{
    NSString *key = [NSString stringWithFormat:@"contentView-%d",index];
    
    if ([_contentViewControllers objectForKey:key])
    {
        return;
    }
    else
    {
        UIViewController *contentVC = [self.dataSource viewPager:self controllerForPageAtIndex:index];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) * index, 0, CGRectGetWidth(self.bounds), contentScroll.bounds.size.height)];
        contentVC.view.frame = contentView.bounds;
        contentView.layer.masksToBounds = YES;
        
        [contentView addSubview:contentVC.view];
        [contentVC didMoveToParentViewController:self.containerViewController];
        [self.containerViewController addChildViewController:contentVC];
        
        [contentScroll addSubview:contentView];
        [_contentViewControllers setObject:contentView forKey:key];
    }
}

-(void)setUpHeaderTitleTextAtIndex:(NSInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(viewPager:headerTitleForPageMenuAtIndex:)])
    {
        NSString *headerTitle = [self.dataSource viewPager:self headerTitleForPageMenuAtIndex:index];
        
        headerTitleLabel.text = headerTitle;
    }
}

-(NSInteger)menuWidth
{
    SHViewPagerMenuWidthType widthType = [self menuWidthType];
    
    switch (widthType)
    {
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

-(NSInteger)menuOffsetX
{
    SHViewPagerMenuWidthType widthType = [self menuWidthType];
    
    NSInteger kTopTabWidth;
    switch (widthType)
    {
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

-(SHViewPagerMenuWidthType)menuWidthType
{
    if ([self.dataSource respondsToSelector:@selector(menuWidthTypeInViewPager:)])
    {
        return [self.dataSource menuWidthTypeInViewPager:self];
    }
    return SHViewPagerMenuWidthTypeDefault;
}

#pragma mark - datasource debugging

-(void)checkDataSourceIsSet
{
    if (!self.dataSource)
    {
        @throw ([NSException exceptionWithName:@"DataSourceNotFoundException" reason:@"There is no dataSource for the viewPager" userInfo:nil]);
    }
    
    if (![self.dataSource respondsToSelector:@selector(numberOfPagesInViewPager:)])
    {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #numberOfPagesInViewPager:" userInfo:nil]);
    }
    
    if (![self.dataSource respondsToSelector:@selector(containerControllerForViewPager:)])
    {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #containerControllerForViewPager:" userInfo:nil]);
    }
    
    if (![self.dataSource respondsToSelector:@selector(viewPager:controllerForPageAtIndex:)])
    {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #viewPager:controllerForPageAtIndex:" userInfo:nil]);
    }
    
    if (!([self.dataSource respondsToSelector:@selector(viewPager:titleForPageMenuAtIndex:)] || [self.dataSource respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)]))
    {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #viewPager:titleForPageMenuAtIndex: or #viewPager:imageForPageMenuAtIndex:, not both" userInfo:nil]);
    }
    
    if ([self.dataSource respondsToSelector:@selector(viewPager:titleForPageMenuAtIndex:)] && ([self.dataSource respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)] || [self.dataSource respondsToSelector:@selector(viewPager:selectedImageForPageMenuAtIndex:)] || [self.dataSource respondsToSelector:@selector(viewPager:highlitedImageForPageMenuAtIndex:)]))
    {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException" reason:@"You should implement #viewPager:titleForPageMenuAtIndex: or #viewPager:imageForPageMenuAtIndex:, not both. #viewPager:selectedImageForPageMenuAtIndex and #viewPager:highlitedImageForPageMenuAtIndex only to be implemented if #viewPager:imageForPageMenuAtIndex is implemented instead of #viewPager:titleForPageMenuAtIndex" userInfo:nil]);
    }
}

#pragma mark - target action methods

-(void)changeIndexAction:(UIButton *)sender
{
    fromIndex = toIndex;
    toIndex = sender.tag;
    [self moveToTargetIndex];
}

-(void)leftSwipeAction:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (toIndex < _menuButtons.count - 1)
        {
            fromIndex = toIndex;
            toIndex++;
            [self moveToTargetIndex];
        }
    }
}

-(void)rightSwipeAction:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (toIndex > 0)
        {
            fromIndex = toIndex;
            toIndex--;
            [self moveToTargetIndex];
        }
    }
}

-(void)moveToTargetIndex
{
    [self setUpHeaderTitleTextAtIndex:toIndex];
    [self setUpContentViewForTargetIndex:toIndex];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        if ([self.dataSource respondsToSelector:@selector(indexIndicatorImageForViewPager:)] && [self.dataSource respondsToSelector:@selector(indexIndicatorImageDuringScrollAnimationForViewPager:)])
        {
            indexIndicatorImageView.image = [self.dataSource indexIndicatorImageDuringScrollAnimationForViewPager:self];
        }
        
        if ([self.dataSource respondsToSelector:@selector(viewPager:selectedImageForPageMenuAtIndex:)] && [self.dataSource respondsToSelector:@selector(viewPager:imageForPageMenuAtIndex:)])
        {
            UIImage *buttonImage = [self.dataSource viewPager:self imageForPageMenuAtIndex:fromIndex];
            UIButton *button = [_menuButtons objectAtIndex:fromIndex];
            [button setImage:buttonImage forState:UIControlStateNormal];
            
            UIImage *selectedImage = [self.dataSource viewPager:self selectedImageForPageMenuAtIndex:toIndex];
            UIButton *selectedButton = [_menuButtons objectAtIndex:toIndex];
            [selectedButton setImage:selectedImage forState:UIControlStateNormal];
        }
        
        if ([self.delegate respondsToSelector:@selector(viewPager:willMoveToPageAtIndex:fromIndex:)])
        {
            [self.delegate viewPager:self willMoveToPageAtIndex:toIndex fromIndex:fromIndex];
        }
        [topTabScroll setContentOffset:CGPointMake((toIndex * [self menuWidth]), 0)];
        [contentScroll setContentOffset:CGPointMake(toIndex * CGRectGetWidth(self.bounds), 0)];
    } completion:^(BOOL finished){
        
        if ([self.delegate respondsToSelector:@selector(viewPager:didMoveToPageAtIndex:fromIndex:)])
        {
            [self.delegate viewPager:self didMoveToPageAtIndex:toIndex fromIndex:fromIndex];
        }
        
        if ([self.dataSource respondsToSelector:@selector(indexIndicatorImageForViewPager:)] && [self.dataSource respondsToSelector:@selector(indexIndicatorImageDuringScrollAnimationForViewPager:)])
        {
            indexIndicatorImageView.image = [self.dataSource indexIndicatorImageForViewPager:self];
        }
    }];
}

#pragma mark - view properties

-(NSArray *)menuButtons
{
    return _menuButtons;
}

-(NSDictionary *)contentViewControllers
{
    return _contentViewControllers;
}

@end
