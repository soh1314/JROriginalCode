//
//  PopViewLikeQQView.h
//  PopViewLikeQQView2
//
//  Created by LiangCe on 16/1/22.
//  Copyright © 2016年 LiangCe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopViewLikeQQView : UIView
@property (nonatomic, copy) void(^action)(NSInteger index);
+ (void)configCustomPopViewWithFrame:(CGRect)frame imagesArr:(NSArray *)imagesArr dataSourceArr:(NSArray *)dataourceArr anchorPoint:(CGPoint)anchorPoint seletedRowForIndex:(void(^)(NSInteger index))action animation:(BOOL)animation timeForCome:(NSTimeInterval)come timeForGo:(NSTimeInterval)go;
+ (void)removed;

@end
