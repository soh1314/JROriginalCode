//
//  QRCodeGeneartor.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/9.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRCodeGeneartor : NSObject
+ (UIImage *)generateQRImageWith:(NSString *)str imageSize:(CGFloat)size;
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight;
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;
@end
