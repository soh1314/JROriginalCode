//
//  ViewController_NewAccount.m
//  JiuRong
//
//  Created by iMac on 15/9/23.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_NewAccount.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController_NewAccount ()

@end

@implementation ViewController_NewAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _webviewHuihu.delegate = self;
    [self InitUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClickBtnLeft
{
    if ([[self.navigationController viewControllers] count] == 1)
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)InitUI
{
    if ([UserInfo GetUserInfo].certifyinfo.depositstatus == 1)
    {
        NSString *url = [JiuRongHttp JRGetHFLogin:[UserInfo GetUserInfo].uid];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_webviewHuihu loadRequest:request];
    }
    else
    {
        NSString *url = [JiuRongHttp JRCreateAccount:[UserInfo GetUserInfo].uid];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_webviewHuihu loadRequest:request];
    }

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
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        //       return NO;
    }
    
    return YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
}

@end
