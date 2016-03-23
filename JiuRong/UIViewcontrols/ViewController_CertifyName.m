//
//  ViewController_CertifyName.m
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_CertifyName.h"
#import "Public.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"
#import "UserInfo.h"

@interface ViewController_CertifyName ()<UIAlertViewDelegate>

@end

@implementation ViewController_CertifyName

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _labelAuthcode.text = [Public RandomString:4];
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

- (IBAction)HideKeyboard:(id)sender {
    [_textfileAuthcode resignFirstResponder];
    [_textfileIDCard resignFirstResponder];
    [_textfileName resignFirstResponder];
}

- (IBAction)ClickBtnCommit:(id)sender
{
    
//    if ([_textfileName.text length] < 1)
//    {
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"输入错误" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
//        [alter show];
//        return;
//    }
//    
//    if (![Public validateIdentityCard:_textfileIDCard.text]) {
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"身份证号码不符合规范" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
//        [alter show];
//        return;
//    }
    
    if (![[_labelAuthcode.text uppercaseString] isEqualToString:[_textfileAuthcode.text uppercaseString]]) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"验证码错误" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRCertifyName:[UserInfo GetUserInfo].uid name:_textfileName.text idnum:_textfileIDCard.text success:^(NSInteger iStatus, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"恭喜您,实名验证成功!" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            alter.tag = 1001;
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    if(alertView.tag == 1001)
    {
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"newAccount"];
    [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
