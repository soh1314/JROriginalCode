//
//  ViewController_RebindEmail.m
//  JiuRong
//
//  Created by iMac on 15/10/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_RebindEmail.h"
#import "Public.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"
#import "UserInfo.h"

@interface ViewController_RebindEmail ()

@end

@implementation ViewController_RebindEmail

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

- (IBAction)HideKeyboard:(id)sender
{
    [_textfileOldEmail resignFirstResponder];
    [_textfileNewEmail resignFirstResponder];
}

- (IBAction)ClickBtnCommit:(id)sender
{
    if (![Public validateEmail:_textfileOldEmail.text])
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"旧邮箱地址有误" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    if (![Public validateEmail:_textfileNewEmail.text])
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"新邮箱地址无效" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRResetBindEmail:[UserInfo GetUserInfo].uid old:_textfileOldEmail.text new:_textfileNewEmail.text success:^(NSInteger iStatus, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"邮箱绑定修改成功" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
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
@end
