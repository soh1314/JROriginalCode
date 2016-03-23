//
//  ViewController_RetPassword.m
//  JiuRong
//
//  Created by iMac on 15/9/9.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_RetPassword.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController_RetPassword ()

@end

@implementation ViewController_RetPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
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
    
    if ([_textfilePassword1.text length] < 6)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"密码长度不能小于6!" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    if ([_textfilePassword1.text length ] >= 21)
    {
        UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"密码长度不能大于21" delegate:self cancelButtonTitle:@"哟,我知道了" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    if ([_textfilePassword1.text isEqualToString:_textfilePassword2.text] == NO)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"两次输入的密码不一致" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRResetPassword:_phone pwd:_textfilePassword1.text authcode:_authcode success:^(NSInteger iStatus, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            UILabel * alertView = [[UILabel alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height-20, self.view.frame.size.width-100, 50)];
            alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
            alertView.layer.masksToBounds = YES;
            alertView.layer.cornerRadius = 25;
            alertView.text = @"修改成功,请记住密码";
            alertView.textAlignment = UITextAlignmentCenter;
            alertView.textColor = [UIColor whiteColor];
            alertView.font = [UIFont systemFontOfSize:12];
            alertView.numberOfLines = 2;
            [self.view.window addSubview:alertView];
            [UIView animateWithDuration:2 animations:^{
                alertView.alpha = 0;
            }];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
        }
    } failure:^(NSError *error)
    {
        [SVProgressHUD dismiss];
    }];
}

- (IBAction)HideKeyboard:(id)sender {
    
    [_textfilePassword1 resignFirstResponder];
    [_textfilePassword2 resignFirstResponder];
}
@end
