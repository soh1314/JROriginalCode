//
//  ViewController_Register.m
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Register.h"
#import "Public.h"
#import "UserInfo.h"
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import "JiuRongConfig.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ViewController_NewAccount.h"
#import "ViewController_Protocol.h"
#import <HHAlertView/HHAlertView.h>

@interface ViewController_Register ()
{
    NSArray *m_arrayTextfile;
    NSTimer *m_pTimeShowAuthCode;
    NSInteger m_iCurCount;
    
    UIWebView *m_pWebviewHuihu;
}
@end

@implementation ViewController_Register

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self SetupUI];
    
    /*test*/
/*    _textfileUser.text = @"test0000";
    _textfilePassword1.text = @"123456";
    _textfilePassword2.text = @"123456";
    _textfileEMail.text = @"yulee1019@sina.com";
    _textfilePhone.text = @"13627421581";*/
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

- (void)SetupUI
{
    m_arrayTextfile = [NSArray arrayWithObjects:_textfilePassword1,_textfilePassword2,nil];
    
    _btnLogin.layer.borderColor = [[UIColor whiteColor] CGColor];
    _btnLogin.layer.borderWidth = 1.0f;
    _btnRegister.layer.cornerRadius = 5.0f;
    
    _btnAuthcode.layer.borderColor = [RGBCOLOR(89, 152, 221) CGColor];
    _btnAuthcode.layer.borderWidth = 1.0f;
    _btnAuthcode.layer.cornerRadius = 3.0f;
    
    NSInteger iCount = [m_arrayTextfile count];
    for (NSInteger i = 0; i < iCount; i++)
    {
        UITextField *tmp = m_arrayTextfile[i];
        tmp.delegate = self;
    }
    _textfilePhone.delegate = self;
    _textfileAuthcode.delegate = self;
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetCancelImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnCancel)];
    self.navigationItem.rightBarButtonItem = RightButtonItem;
    
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (void)ClickBtnCancel
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)ClickBtnLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}
//验证码按钮
- (IBAction)ClickBtnAuthcode:(id)sender
{
    if ([m_pTimeShowAuthCode isValid] == NO)
    {
        if (![Public isValidateMobile:_textfilePhone.text])
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"无效的手机号码" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
            return;
        }
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [JiuRongHttp JRGetAuthcode:_textfilePhone.text type:@"reg" success:^(NSInteger iStatus, NSString *strErrorCode) {
            
            [SVProgressHUD dismiss];
            if (iStatus == 1)
            {
                m_iCurCount = 120;
                m_pTimeShowAuthCode = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(ShowAuthCodeText) userInfo:nil repeats:YES];
                _btnAuthcode.enabled = NO;
            }
            else
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
                [alter show];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
        
    }
    
}

- (void)ShowAuthCodeText
{
    NSString *strValue = [NSString stringWithFormat:@"%ld秒",m_iCurCount--];
    _btnAuthcode.titleLabel.text = strValue;
    [_btnAuthcode setTitle:strValue forState:UIControlStateNormal];
    if (m_iCurCount == 0)
    {
        [m_pTimeShowAuthCode invalidate];
        _btnAuthcode.enabled = YES;
        [_btnAuthcode setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
}

- (IBAction)ClickBtnProtocol:(id)sender
{
    ViewController_Protocol* pProtocol = [self.storyboard instantiateViewControllerWithIdentifier:@"pushProtocol"];
    [self.navigationController pushViewController:pProtocol animated:YES];
}

//注册账号
- (IBAction)ClickBtnRegister:(id)sender {
    
//    if ([_textfileUser.text length] < 3)
//    {
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"用户名长度必须大于3!" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
//        [alter show];
//        return;
//    }
    
    if ([_textfilePassword1.text length] < 6)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"密码长度不能小于6!" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    if ([_textfilePassword1.text isEqualToString:_textfilePassword2.text] == NO)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"两次输入的密码不一致" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    if (![Public isValidateMobile:_textfilePhone.text])
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"无效的手机号码" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
  
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRRegister:_textfilePassword1.text authcode:_textfileAuthcode.text phone:_textfilePhone.text recommendUserName:_recommendPerson.text success:^(NSInteger iStatus, NSString *userid, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            [UserInfo GetUserInfo].uid = userid;
            [UserInfo GetUserInfo].isLogin = TRUE;
            [UserInfo GetUserInfo].user = _textfilePhone.text;
            [UserInfo GetUserInfo].password = _textfilePassword1.text;
            [UserInfo GetUserInfo].logintime = [NSDate date];
            [[JiuRongConfig ShareJiuRongConfig] SetUserInfo:_textfilePhone.text pwd:_textfilePassword1.text type:0 login:TRUE];
            [[JiuRongConfig ShareJiuRongConfig] UpdateLoginTime];
            [self GetCerfityInfo:userid];
            
            [[HHAlertView shared] showAlertWithStyle:HHAlertStyleOk inView:self.view Title:@"久融金融" detail:@"注册成功" cancelButton:nil Okbutton:@"跳转到汇付平台!" block:^(HHAlertButton buttonindex) {
                if (buttonindex == HHAlertButtonOk)
                {
                    NSString *url = [JiuRongHttp JRCreateAccount:[UserInfo GetUserInfo].uid];
                    UIWebView *webview = [self CreateWebView:url];
                    [self.view addSubview: webview];
                }
 
            }];
            
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"恭喜您,注册成功!" delegate:self cancelButtonTitle:@"会员认证" otherButtonTitles:nil];
//            [alter show];
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
}

- (IBAction)ClickBtnLogin:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ClickHideKeyboard:(id)sender {
    
    NSInteger iCount = [m_arrayTextfile count];
    for (NSInteger i = 0; i < iCount; i++)
    {
        UITextField *tmp = m_arrayTextfile[i];
        [tmp resignFirstResponder];
    }
    [_recommendPerson resignFirstResponder];
    [_textfilePhone resignFirstResponder];
    [_textfileAuthcode resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.returnKeyType == UIReturnKeyNext)
    {
        UITextField *temp = [self GetNextTextFile:textField];
        [temp becomeFirstResponder];
    }
    
    return YES;
}

- (UITextField*)GetNextTextFile:(UITextField*)textfile
{
    NSInteger iCount = [m_arrayTextfile count];
    for (NSInteger i = 0; i < iCount; i++)
    {
        if (m_arrayTextfile[i] == textfile)
        {
            return m_arrayTextfile[i+1];
        }
    }
    
    return nil;
}

- (UIWebView*)CreateWebView:(NSString*)url
{
    if (m_pWebviewHuihu == nil)
    {
        m_pWebviewHuihu = [[UIWebView alloc] initWithFrame:self.view.bounds];
        m_pWebviewHuihu.delegate = self;
        
    }
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [m_pWebviewHuihu loadRequest:request];
    
    return m_pWebviewHuihu;
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
            [self dismissModalViewControllerAnimated:YES];
        }
        else if ([components[1] isEqualToString:@"2"])
        {
            [self dismissModalViewControllerAnimated:YES];
        }
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

- (void)GetCerfityInfo:(NSString*)uid
{
    [JiuRongHttp JRGetCertifyInfo:uid success:^(NSInteger iStatus, CertifyInfo *info, NSString *strErrorCode) {
        if (iStatus == 1)
        {
            [UserInfo GetUserInfo].certifyinfo = info;
        }
    } failure:^(NSError *error) {
        ;
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        [MyIndicatorView showIndicatiorViewWith:@"登录成功" inView:self.view];
//        UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"CertifyName"];
//        [self.navigationController pushViewController:pRecharge animated:YES];
    }
}
@end
