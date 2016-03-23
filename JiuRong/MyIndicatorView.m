//
//  MyIndicatorView.m
//  viewtest
//
//  Created by 刘仰清 on 16/3/8.
//  Copyright © 2016年 刘仰清. All rights reserved.
//

#import "MyIndicatorView.h"

@implementation MyIndicatorView
+ (void)showIndicatiorViewWith:(NSString *)word inView:(UIView *)containerView
{
   UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 100,[UIScreen mainScreen].bounds.size.width - 100, 40)];
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.5;
    label.text = word;
    label.clipsToBounds = YES;
    label.layer.cornerRadius = 20;
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [window addSubview:label];
//    [window addSubview:label];
    [UIView animateWithDuration:2 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}
@end
