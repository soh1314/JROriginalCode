//
//  ViewController_BindBankCard.m
//  JiuRong
//
//  Created by iMac on 15/10/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_BindBankCard.h"
#import "Public.h"
#import "UserInfo.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController_BindBankCard ()

@end

@implementation ViewController_BindBankCard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _webviewMain.delegate = self;
    [self ShowUrl];
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

- (void)ShowUrl
{
    NSString *url = [JiuRongHttp JRBindBankCard:[UserInfo GetUserInfo].uid];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webviewMain loadRequest:request];
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
