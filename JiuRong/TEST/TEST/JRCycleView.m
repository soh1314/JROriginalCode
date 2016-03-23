//
//  JRCycleView.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/10.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRCycleView.h"
#define CWidth self.bounds.size.width
#define CHeight self.bounds.size.height
@implementation JRCycleView
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        self.imageArray = imageArray;
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor redColor];
    if (self.imageArray.count) {
        NSInteger totalPage = self.imageArray.count;
        _scrollView.contentSize = CGSizeMake((totalPage+2)*CWidth,CHeight);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentOffset = CGPointMake(CWidth, 0);
        _scrollView.delegate = self;
        for (int i = 0; i < self.imageArray.count+2; i++) {
        
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*CWidth, 0, CWidth, CHeight)];
            [_scrollView addSubview:imageView];
            if (i == 0) {
                imageView.image = [UIImage imageNamed:self.imageArray[totalPage-1]];
            }
            else if (i == totalPage+1)
            {
                imageView.image = [UIImage imageNamed:self.imageArray[0]];
            }
            else
            {
            imageView.image = [UIImage imageNamed:self.imageArray[i-1]];
            }
        }
    }
    [self startGcdTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/CWidth;
    if (page == self.imageArray.count+1) {
        self.scrollView.contentOffset = CGPointMake(CWidth, 0);
    }
    if (page == 0) {
        self.scrollView.contentOffset = CGPointMake(self.imageArray.count*CWidth, 0);
    }
}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    dispatch_suspend(self.timer);
//}
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    dispatch_resume(self.timer);
//}
- (void)startGcdTimer
{
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(3.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        int page = self.scrollView.contentOffset.x/CWidth;
        if (page == self.imageArray.count+1)
        {
            self.scrollView.contentOffset = CGPointMake(CWidth, 0);
            page = 0;
        }
        else
        {
            page++;
            self.scrollView.contentOffset = CGPointMake(page*CWidth, 0);
        }
        }
    );
    
    // 启动定时器
    dispatch_resume(self.timer);
}
- (NSArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSArray array];
    }
    return _imageArray;
}
@end
