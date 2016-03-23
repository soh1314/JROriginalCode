//
//  JRCycleView.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/10.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRCycleView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,copy)NSArray * imageArray;
@property (nonatomic,strong)dispatch_source_t timer;
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

@end
