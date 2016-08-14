//
//  XFMovieBrowser.h
//  xf-淘票票demo
//
//  Created by 朱晓峰 on 16/8/14.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFMovie.h"

#define kMovieBrowserHeight 125.0

@class XFMovieBrowser;
@protocol XFMovieBrowserdelegate <NSObject>
@optional

- (void)movieBrowser:(XFMovieBrowser *)movieBrowser didSelectItemAtIndex:(NSInteger)index;
- (void)movieBrowser:(XFMovieBrowser *)movieBrowser didEndScrollingAtIndex:(NSInteger)index;
- (void)movieBrowser:(XFMovieBrowser *)movieBrowser didChangeItemAtIndex:(NSInteger)index;


@end

@interface XFMovieBrowser : UIView
@property(nonatomic,assign)id<XFMovieBrowserdelegate> delegate;
@property (nonatomic, assign, readonly)  NSInteger currentIndex;
- (instancetype)initWithFrame:(CGRect)frame movies:(NSArray *)movies;
- (instancetype)initWithFrame:(CGRect)frame movies:(NSArray *)movies currentIndex:(NSInteger)index;
- (void)setCurrentMovieIndex:(NSInteger)index;
@end
