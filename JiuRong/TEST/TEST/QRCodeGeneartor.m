//
//  QRCodeGeneartor.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/9.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "QRCodeGeneartor.h"

@implementation QRCodeGeneartor
+ (UIImage *)generateQRImageWith:(NSString *)str imageSize:(CGFloat)size
{
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"InputMessage"];
    CIImage * ciImage = [filter outputImage];
    UIImage * QRImage = [self createNonInterpolatedUIImageFormCIImage:ciImage size:size];
    return QRImage;
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight
{
    CGRect extentRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(widthAndHeight / CGRectGetWidth(extentRect), widthAndHeight / CGRectGetHeight(extentRect));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extentRect) * scale;
    size_t height = CGRectGetHeight(extentRect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extentRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extentRect, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    //return [UIImage imageWithCGImage:scaledImage]; // 黑白图片
    UIImage *newImage = [UIImage imageWithCGImage:scaledImage];
    return [self imageBlackToTransparent:newImage withRed:200.0f andGreen:70.0f andBlue:189.0f];
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    
    free((void*)data);
}

+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    
    const int imageWidth = image.size.width;
    
    const int imageHeight = image.size.height;
    
    size_t      bytesPerRow = imageWidth * 4;
    
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    
    int pixelNum = imageWidth * imageHeight;
    
    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
            
        {
            
            // 改成下面的代码，会将图片转成想要的颜色
            
            uint8_t* ptr = (uint8_t*)pCurPtr;
            
            ptr[3] = red; //0~255
            
            ptr[2] = green;
            
            ptr[1] = blue;
            
        }
        
        else
            
        {
            
            uint8_t* ptr = (uint8_t*)pCurPtr;
            
            ptr[0] = 0;
            
        }
        
    }
    
    // 输出图片
    
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        
                                        NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 清理空间
    
    CGImageRelease(imageRef);
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
}
@end