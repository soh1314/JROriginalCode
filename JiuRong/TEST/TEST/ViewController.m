//
//  ViewController.m
//  TEST
//
//  Created by jingshuihuang on 16/3/9.
//  Copyright © 2016年 jingshuihuang. All rights reserved.
//

#import "ViewController.h"
#import "NSString+AttributedText.h"
#import "Constant.h"
#import "QRCodeGeneartor.h"
#import "JRCycleView.h"
@interface ViewController ()
{
    NSMutableArray *m_arrayHead;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
//    [self.view addSubview:imageview];
////    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
////    
////    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
////    
////    [filter setDefaults];
////    
////    // 3.将字符串转换成NSdata
////    
////    NSData *data  = [@"我最帅" dataUsingEncoding:NSUTF8StringEncoding];
////    
////    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
////    [filter setValue:data forKey:@"inputMessage"];
////    
////    // 5.生成二维码
////    
////    CIImage *outputImage = [filter outputImage];
////    
////    UIImage *image = [UIImage  imageWithCIImage:outputImage];
//    UIImage * image = [QRCodeGeneartor generateQRImageWith:@"我疯了哦" imageSize:80];
//    imageview.image = image;
    self.automaticallyAdjustsScrollViewInsets = YES;
    m_arrayHead = [[NSMutableArray alloc] init];
    [m_arrayHead addObject:@"首页logo01.png"];
    [m_arrayHead addObject:@"首页logo02.png"];
    [m_arrayHead addObject:@"首页logo03.png"];
    [m_arrayHead addObject:@"首页logo04.png"];
    JRCycleView * cycleView = [[JRCycleView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 200) imageArray:m_arrayHead];
    [self.view addSubview:cycleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
