//
//  LwkShufflingFigure.h
//  Huihui
//
//  Created by 伟凯   刘 on 2017/2/21.
//  Copyright © 2017年 pg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LwkShufflingFigure : UIView <UIScrollViewDelegate>
- (instancetype)initWithFrame:(CGRect)frame andAddImageStrUrl:(NSArray *)images;
- (void)setPageCurrentPageIndicatorTintColor:(UIColor *)currentColor andPageIndicatorTintColor:(UIColor *)IndicatorTintColor;
- (void)setTimerInterval:(double)Interva;
@end
