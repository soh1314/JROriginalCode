//
//  ViewController_Login.m
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Login.h"
#import "Public.h"
#import "ViewController_Register.h"
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongConfig.h"
#import <HHAlertView.h>

@interface ViewController_Login ()

@end

@implementation ViewController_Login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _btnLogin.layer.cornerRadius = 5.0f;
    _btnRegister.layer.cornerRadius = 5.0f;
    
    _btnStatus.selected = TRUE;
    _imageStatus.highlighted = YES;
    
    AppInfo *info = [[JiuRongConfig ShareJiuRongConfig] GetAppInfo];
    if ([info.username length] > 0)
    {
        _textfileUser.text = info.username;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_textfileUser resignFirstResponder];
    [_textfilePassword resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClickBtnLeft
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
/*    if ([[segue identifier] isEqualToString:@"pushRegister"])
    {
        ViewController_Register *viewcontrol = (ViewController_Register*)segue.destinationViewController;
        viewcontrol.projectCell = m_pCurSelectedCell;
    }*/
    
}


- (IBAction)ClickBtnLogin:(id)sender {
    
    if ([_textfileUser.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"用户名不能为空" delegate:nil cancelButtonTitle:@"哟,我知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([_textfileUser.text length] < 3)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"用户名格式不对!" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    if ([_textfilePassword.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"请输入密码" delegate:nil cancelButtonTitle:@"哟,我知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([_textfilePassword.text length] < 6)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"密码输入错误!" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }

    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    //登录时应该从后台获得用户名,而不是手机号或者邮箱
    [JiuRongHttp JRLogin:_textfileUser.text pwd:_textfilePassword.text success:^(NSInteger iStatus, NSString *userid, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            [JiuRongHttp JRGetPersonBaseInfo:userid success:^(NSInteger iStatus, UserBaseInfo *info, NSString *strErrorCode) {
                if (iStatus == 1) {
                    [UserInfo GetUserInfo].uid = userid;
                    [UserInfo GetUserInfo].isLogin = YES;
                    [UserInfo GetUserInfo].user = info.name;
                    [UserInfo GetUserInfo].password = _textfilePassword.text;
                    [UserInfo GetUserInfo].logintime = [NSDate date];
                    
                    [[JiuRongConfig ShareJiuRongConfig] SetUserInfo:info.name pwd:_textfilePassword.text type:0 login:_imageStatus.highlighted];
                    [[JiuRongConfig ShareJiuRongConfig] UpdateLoginTime];
                    
                    [self GetCerfityInfo:userid];
                    [_textfilePassword resignFirstResponder];
                    [_textfileUser resignFirstResponder];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                
            } failure:^(NSError *error) {
                
            }];
/*
            [UserInfo GetUserInfo].uid = userid;
            [UserInfo GetUserInfo].isLogin = YES;
            [UserInfo GetUserInfo].user = _textfileUser.text; //此处有问题,有可能是手机或者邮箱
            [UserInfo GetUserInfo].password = _textfilePassword.text;
            [UserInfo GetUserInfo].logintime = [NSDate date];
            
            [[JiuRongConfig ShareJiuRongConfig] SetUserInfo:_textfileUser.text pwd:_textfilePassword.text type:0 login:_imageStatus.highlighted];
            [[JiuRongConfig ShareJiuRongConfig] UpdateLoginTime];
            
            [self GetCerfityInfo:userid];
            [_textfilePassword resignFirstResponder];
            [_textfileUser resignFirstResponder];
 
 
            [self dismissViewControllerAnimated:YES completion:nil];
*/
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"登录成功!" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
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

- (IBAction)ClickBtnRegister:(id)sender
{
    
    [self performSegueWithIdentifier:@"pushRegister" sender:self];
}

- (IBAction)HideKeyboard:(id)sender
{
    [_textfileUser resignFirstResponder];
    [_textfilePassword resignFirstResponder];
}

- (IBAction)ClickBtnAutoLogin:(id)sender {
    
    if (_btnStatus.selected)
    {
        _btnStatus.selected = FALSE;
        _imageStatus.highlighted = NO;
    }
    else
    {
        _btnStatus.selected = TRUE;
        _imageStatus.highlighted = YES;
    }
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
    }
}

@end
