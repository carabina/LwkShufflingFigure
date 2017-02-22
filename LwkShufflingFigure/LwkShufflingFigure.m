//
//  LwkShufflingFigure.m
//  Huihui
//
//  Created by 伟凯   刘 on 2017/2/21.
//  Copyright © 2017年 pg. All rights reserved.
//

#import "LwkShufflingFigure.h"

@implementation LwkShufflingFigure{
    UIScrollView * _scrollView;
    NSMutableArray * _imagesArray;
    UIPageControl * _pageControl;
    NSTimer * _timer;
    
}

- (instancetype)initWithFrame:(CGRect)frame andAddImageStrUrl:(NSMutableArray *)images{
    self = [super initWithFrame:frame];
    if (self){
        _imagesArray = [[NSMutableArray alloc] init];
        [self createUI:images];
    }
    return  self;
}
- (void)createUI:(NSMutableArray *)images{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    for (id image in images){
        [_imagesArray addObject:image];
    }
    [_imagesArray addObject:[images firstObject]];
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * [_imagesArray count], 0.0);
    
    for (int i = 0; i < [_imagesArray count]; i++){
        CGRect rect = CGRectMake([[UIScreen mainScreen] bounds].size.width * i, 0, [[UIScreen mainScreen] bounds].size.width, _scrollView.frame.size.height);
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
        imageView.image = (UIImage *)_imagesArray[i];
        [_scrollView addSubview:imageView];
    }
    CGRect pageControlRect = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30);
    _pageControl = [[UIPageControl alloc] initWithFrame:pageControlRect];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.numberOfPages = [images count];
    [self addSubview:_pageControl];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(add) userInfo:nil repeats:YES];
    
    
}
- (void)add{
    int index = _scrollView.contentOffset.x/[[UIScreen mainScreen] bounds].size.width;
    CGPoint point = _scrollView.contentOffset;
    if (index != [_imagesArray count] - 1){
        point.x += [[UIScreen mainScreen] bounds].size.width;
        
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = point;
            int index = _scrollView.contentOffset.x/[[UIScreen mainScreen] bounds].size.width;
            if (index == [_imagesArray count] - 1){
                _pageControl.currentPage = 0;
            }else{
                _pageControl.currentPage = index;
            }
        }];
        
    }else{
        _pageControl.currentPage = 0;
        _scrollView.contentOffset = CGPointMake(0.0, 0.0);
        //关闭再开启定时器，为了不卡顿
        [_timer setFireDate:[NSDate distantFuture]];
        [_timer setFireDate:[NSDate distantPast]];
        
        
    }
}
- (void)setPageCurrentPageIndicatorTintColor:(UIColor *)currentColor andPageIndicatorTintColor:(UIColor *)IndicatorTintColor{
    _pageControl.currentPageIndicatorTintColor = currentColor;
    _pageControl.pageIndicatorTintColor = IndicatorTintColor;
}
- (void)setTimerInterval:(double)Interva{
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer invalidate];
    _timer = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval:Interva target:self selector:@selector(add) userInfo:nil repeats:YES];
}

@end
