//
//  ViewController_LockEmail.m
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_LockEmail.h"
#import "Public.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"
#import "UserInfo.h"

@interface ViewController_LockEmail ()

@end

@implementation ViewController_LockEmail

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

- (IBAction)HideKeyboard:(id)sender {
    [_textfileEmail resignFirstResponder];
}

- (IBAction)ClickBtnCommit:(id)sender {
    
    if (![Public validateEmail:_textfileEmail.text])
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"无效邮箱地址" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRBindEmail:[UserInfo GetUserInfo].uid email:_textfileEmail.text success:^(NSInteger iStatus, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"邮箱绑定成功" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
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
