//
//  UIImage+Qmethod.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/9.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Qmethod)
//原始图片
+ (UIImage *)OriginalImageNamed:(NSString *)name;
//图片拉伸
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
//根据颜色和大小获取图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
// 根据图片和颜色返回一张加深颜色以后的图片
+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;
//- (UIImage *)boxblurImageWithBlur:(CGFloat)blur;
//图片大小改变
- (UIImage *)cropImageWithSize:(CGSize)size;
//合并图片
+ (UIImage *)combine:(UIImage *)image1 andImage:(UIImage *)image2;
//截取图片
- (UIImage *)captureImage:(UIImage *)image toSize:(CGRect)rect;
@end
