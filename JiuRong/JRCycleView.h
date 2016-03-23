//
//  JRCycleView.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/10.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRCycleView : UIView

@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,copy)NSArray * imageArray;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

@end
