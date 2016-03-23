//
//  JRNetView.h
//  JiuRong
//
//  Created by jingshuihuang on 16/3/3.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRNetView : NSObject
@property (nonatomic,strong)UILabel * alertLabel;
+ (JRNetView *)showInView:(UIView *)containerView autoFade:(BOOL) autoDisappear connect:(BOOL)netStatus;
@end
