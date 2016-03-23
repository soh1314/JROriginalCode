//
//  JRSaoYiSao.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/11.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRSaoYiSao.h"
#import "UIImage+Qmethod.h"
 #import <AVFoundation/AVFoundation.h>
@interface JRSaoYiSao ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,strong)AVCaptureDevice * device;
@property (nonatomic,strong)AVCaptureInput * input;
@property (nonatomic,strong)AVCaptureMetadataOutput * output;
@property (nonatomic,strong)AVCaptureSession * session;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,strong)UIImageView * sceneBorderView;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,assign)NSInteger lineMoveDistance;
@end

@implementation JRSaoYiSao
- (id)init
{
    if (self = [super init]) {
        _lineMoveDistance = 5;
        self.title = @"扫一扫";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sceneBorderView];
    [self.view addSubview:self.lineView];
    [self setNavBar];
    [self setCamera];
}
- (void)setCamera
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        // Device
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Input
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
        // Output
        _output = [[AVCaptureMetadataOutput alloc]init];
        //    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // Session
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input])
        {
            [_session addInput:self.input];
        }
        
        if ([_session canAddOutput:self.output])
        {
            [_session addOutput:self.output];
        }
        
        // 条码类型 AVMetadataObjectTypeQRCode
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            // Preview
            _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
            _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
                _preview.frame =CGRectMake(20,110,280,280);
            _preview.frame = self.view.bounds;
            [self.view.layer insertSublayer:self.preview atIndex:0];
            // Start
            [_session startRunning];
        });
    });
}


-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [super viewWillAppear:animated];
    if (_session && ![_session isRunning]) {
        [_session startRunning];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(lineMove) userInfo:nil repeats:YES];
}
- (void)lineMove
{
    CGRect line = self.lineView.frame;
    if (line.origin.y + _lineMoveDistance> CGRectGetMaxY(self.sceneBorderView.frame)) {
        _lineMoveDistance *= -1;
        NSLog(@"%lu",_lineMoveDistance);
    }
    if (line.origin.y + _lineMoveDistance < CGRectGetMinY(self.sceneBorderView.frame)) {
        _lineMoveDistance *= -1;
    }
    line.origin.y += _lineMoveDistance;
    self.lineView.frame = line;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [_timer invalidate];
}
- (void)setNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage OriginalImageNamed:@"backnav@2x.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
}
- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [_timer invalidate];
    NSLog(@"%@",stringValue);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.9rjr.com"]];
   
}
- (UIImageView *)sceneBorderView
{
    if (!_sceneBorderView) {
        _sceneBorderView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, KScreenW-100,KScreenW-100)];
        _sceneBorderView.image = [UIImage OriginalImageNamed:@"scan_code@2x.png"];
    }
    return _sceneBorderView;
}
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(50, 102, KScreenW-100, 1)];
        _lineView.backgroundColor = [UIColor greenColor];
    }
    return _lineView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
