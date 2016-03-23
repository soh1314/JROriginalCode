//
//  ViewController_Webview.m
//  JiuRong
//
//  Created by iMac on 15/12/10.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Webview.h"
#import "Public.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController_Webview ()<UIWebViewDelegate>

@end

@implementation ViewController_Webview

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self.navigationItem setTitle:_webviewtitle];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    NSLog(@"%@",_url);
    UIWebView *webviewMain = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webviewMain.delegate = self;
    [webviewMain loadRequest:request];
    [self.view addSubview:webviewMain];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
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

@end
