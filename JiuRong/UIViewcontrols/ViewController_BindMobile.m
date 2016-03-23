//
//  ViewController_BindMobile.m
//  JiuRong
//
//  Created by iMac on 15/9/18.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_BindMobile.h"
#import "Public.h"
#import "UserInfo.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"

@interface ViewController_BindMobile ()
{
    NSTimer *m_pTimeShowAuthCode;
    NSInteger m_iCurCount;
}
@end

@implementation ViewController_BindMobile

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ClickBtnCommit:(id)sender {
    
    if (![Public isValidateMobile:_textfilePhone.text])
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"无效的手机号码" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRBindPhone:[UserInfo GetUserInfo].uid phone:_textfilePhone.text authcode:_textfileAuthcode.text success:^(NSInteger iStatus, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"手机绑定成功" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
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

- (IBAction)HideKeyboard:(id)sender {
    [_textfileAuthcode resignFirstResponder];
    [_textfilePhone resignFirstResponder];
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
        [JiuRongHttp JRGetAuthcode:_textfilePhone.text type:@"mobile" success:^(NSInteger iStatus, NSString *strErrorCode) {
            
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
@end
