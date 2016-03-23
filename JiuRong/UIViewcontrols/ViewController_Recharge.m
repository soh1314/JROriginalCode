//
//  ViewController_Recharge.m
//  JiuRong
//
//  Created by iMac on 15/9/16.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Recharge.h"
#import "Public.h"
#import "UserInfo.h"
#import "JiuRongHttp.h"
#import "CollectionViewController_TransferList.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController_Recharge ()
{
    UIWebView *m_pWebviewHuihu;
}
@end

@implementation ViewController_Recharge

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
/*    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetCancelImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnCancel)];
    self.navigationItem.rightBarButtonItem = RightButtonItem;
*/    
    ////
    NSString *url = [JiuRongHttp JRRecharge:[UserInfo GetUserInfo].uid];
    
    UIWebView *webview = [self CreateWebView:url];
    [self.view addSubview: webview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClickBtnLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ClickBtnCancel
{
    if ([m_pWebviewHuihu superview])
    {
        [m_pWebviewHuihu removeFromSuperview];
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

- (IBAction)HideKeyboard:(id)sender {
    [_textfileMoney resignFirstResponder];
    [_textfileAccount resignFirstResponder];
    [_textfileName resignFirstResponder];
}

- (IBAction)ClickBtnCommit:(id)sender {
    
    NSString *url = [JiuRongHttp JRRecharge:[UserInfo GetUserInfo].uid];
    
    UIWebView *webview = [self CreateWebView:url];
    [self.view addSubview: webview];
}

- (UIWebView*)CreateWebView:(NSString*)url
{
    if (m_pWebviewHuihu == nil)
    {
        m_pWebviewHuihu = [[UIWebView alloc] initWithFrame:self.view.bounds];
        m_pWebviewHuihu.delegate = self;
        
        
    }
/*
    [WebViewJavascriptBridge enableLogging];
    m_pBridge = [WebViewJavascriptBridge bridgeForWebView:m_pWebviewHuihu webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        
        responseCallback(@"Response for message from ObjC");
    }];

    [m_pBridge registerHandler:@"DealFinish()" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
    
    [m_pBridge registerHandler:@"Back()" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
*/
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [m_pWebviewHuihu loadRequest:request];
    
    return m_pWebviewHuihu;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //获取请求的绝对路径.
    NSString *requestString = request.URL.absoluteString;
//    NSLog(@"%@",requestString);
    //提交请求时候分割参数的分隔符
    
    NSArray *components = [requestString componentsSeparatedByString:@"#"];
                           
    if ([components count] > 1)
    {
        if ([components[1] isEqualToString:@"1"])
        {
            NSLog(@"successed");
            CollectionViewController_TransferList* pIndentity = (CollectionViewController_TransferList*)[self.storyboard instantiateViewControllerWithIdentifier:@"pushTList"];
            [self.navigationController pushViewController:pIndentity animated:YES];
            
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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
/*    NSString *mystring = [webView stringByEvaluatingJavaScriptFromString:@"window.clickListner.Back()"];
    NSLog(@"%@",mystring);*/
    
    [SVProgressHUD dismiss];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
}
@end
