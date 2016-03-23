//
//  JRNetView.m
//  JiuRong
//
//  Created by jingshuihuang on 16/3/3.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRNetView.h"

@implementation JRNetView
+ (JRNetView *)showInView:(UIView *)containerView autoFade:(BOOL) autoDisappear connect:(BOOL)netStatus
{
    JRNetView * netView = [[JRNetView alloc]init];
    netView.alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, containerView.frame.size.height-120, containerView.frame.size.width-100, 50)];
    netView.alertLabel.clipsToBounds = YES;
    netView.alertLabel.layer.cornerRadius = 25;
    netView.alertLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    netView.alertLabel.textColor = [UIColor whiteColor];
    netStatus? (netView.alertLabel.text = @"网络已经连接成功"):(netView.alertLabel.text = @"请检查当前网络状态链接");
    netView.alertLabel.textAlignment = UITextAlignmentCenter;
    [containerView addSubview:netView.alertLabel];
    if (autoDisappear) {
        [UIView animateWithDuration:3 animations:^{
            netView.alertLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [netView.alertLabel removeFromSuperview];
        }];
    }
    return netView;
    
}
@end
