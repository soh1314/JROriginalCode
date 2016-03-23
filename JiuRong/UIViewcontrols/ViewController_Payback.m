//
//  ViewController_Payback.m
//  JiuRong
//
//  Created by iMac on 15/10/17.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Payback.h"
#import "Public.h"
#import "UserInfo.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"

@interface ViewController_Payback ()

@end

@implementation ViewController_Payback

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _webviewPayback.delegate = self;
    
    NSString *url = [JiuRongHttp JRPayback:[UserInfo GetUserInfo].uid billid:_bID];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webviewPayback loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClickBtnLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //获取请求的绝对路径.
    NSString *requestString = request.URL.absoluteString;
    //提交请求时候分割参数的分隔符
    NSArray *components = [requestString componentsSeparatedByString:@"#"];
    
    if ([components count] > 1)
    {
        if ([components[1] isEqualToString:@"1"])
        {
            NSLog(@"successed");
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else if ([components[1] isEqualToString:@"2"])
        {
            NSLog(@"back");
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        //       return NO;
    }
    
    
    return YES;
    
}

@end
