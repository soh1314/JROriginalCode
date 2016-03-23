//
//  ViewController_ForgetPassword.m
//  JiuRong
//
//  Created by iMac on 15/9/9.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_ForgetPassword.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ViewController_RetPassword.h"

@interface ViewController_ForgetPassword ()
{
    NSTimer *m_pTimeShowAuthCode;
    NSInteger m_iCurCount;
}
@end

@implementation ViewController_ForgetPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _btnAuthcode.layer.borderColor = [RGBCOLOR(89, 152, 221) CGColor];
    _btnAuthcode.layer.borderWidth = 1.0f;
    _btnAuthcode.layer.cornerRadius = 3.0f;
    
    _btnCommit.layer.cornerRadius = 5.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClickBtnLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"pushResetPassword"])
    {
        ViewController_RetPassword *viewcontrol = (ViewController_RetPassword*)segue.destinationViewController;
        viewcontrol.phone = _textfilePhone.text;
        viewcontrol.authcode = _textfileAuthcode.text;
    }
}


- (IBAction)ClickBtnNext:(id)sender
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRCertifyAuthcode:_textfilePhone.text authcode:_textfileAuthcode.text success:^(NSInteger iStatus, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            [self performSegueWithIdentifier:@"pushResetPassword" sender:self];
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
}

- (IBAction)ClickBtnAuthcode:(id)sender {
    
    if ([m_pTimeShowAuthCode isValid] == NO)
    {
        if (![Public isValidateMobile:_textfilePhone.text])
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"无效的手机号码" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
            return;
        }
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [JiuRongHttp JRGetAuthcode:_textfilePhone.text type:@"commit" success:^(NSInteger iStatus, NSString *strErrorCode) {
            
            [SVProgressHUD dismiss];
            if (iStatus == 1)
            {
                m_iCurCount = 120;
                m_pTimeShowAuthCode = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(ShowAuthCodeText) userInfo:nil repeats:YES];
                _btnAuthcode.enabled = NO;
            }
            else
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
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

- (IBAction)HideKeyboard:(id)sender {
    
    [_textfilePhone resignFirstResponder];
    [_textfileAuthcode resignFirstResponder];
}
@end
