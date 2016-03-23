//
//  ViewController_CertifyMember.m
//  JiuRong
//
//  Created by iMac on 15/9/7.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_CertifyMember.h"
#import "Public.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import "CollectionViewController_TransferList.h"

@interface ViewController_CertifyMember ()
{
    UIImage *m_pImageFail;
    UIImage *m_pImageSuccess;
}
@end

@implementation ViewController_CertifyMember

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    m_pImageFail = [UIImage imageNamed:@"认证失败@2x.png"];
    m_pImageSuccess = [UIImage imageNamed:@"认证成功@2x.png"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self UpdateInfo];
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

- (IBAction)ClickToName:(id)sender
{
//    if ([UserInfo GetUserInfo].certifyinfo.namestatus == 0)
//    {
//        [self performSegueWithIdentifier:@"pushCertifyName" sender:self];
//    }
    
}

- (IBAction)ClickToPhone:(id)sender
{
    if ([UserInfo GetUserInfo].certifyinfo.phonestatus == 1)
    {
//        [self performSegueWithIdentifier:@"pushRebindPhone" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"pushBindPhone" sender:self];
    }
}

- (IBAction)ClickToEmail:(id)sender
{
//    if ([UserInfo GetUserInfo].certifyinfo.emailstatus == 0)
//    {
//        [self performSegueWithIdentifier:@"pushLockEmail" sender:self];
//    }
//    else
//    {
//        [self performSegueWithIdentifier:@"pushRebindEmail" sender:self];
//    }
    
}

- (IBAction)ClickToTrust:(id)sender
{
    if ([UserInfo GetUserInfo].certifyinfo.depositstatus == 0)
    {
        CollectionViewController_TransferList* pIndentity = (CollectionViewController_TransferList*)[self.storyboard instantiateViewControllerWithIdentifier:@"newAccount"];
        [self.navigationController pushViewController:pIndentity animated:YES];
        
    }
}

- (IBAction)ClickToBaseInfo:(id)sender {
    
    if ([UserInfo GetUserInfo].certifyinfo.baseinfostatis == 0 && [UserInfo GetUserInfo].certifyinfo.depositstatus )
    {
//        if ([UserInfo GetUserInfo].certifyinfo.namestatus == 0) {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"请先进行实名认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else
//        {
            [self performSegueWithIdentifier:@"pushUserinfo2" sender:self];
//        }
        
    }
}

- (void)UpdateInfo
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetCertifyInfo:[UserInfo GetUserInfo].uid success:^(NSInteger iStatus, CertifyInfo *info, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            [UserInfo GetUserInfo].certifyinfo = info;
//            if (info.namestatus == 0)
//            {
//                _imageviewName.image = m_pImageFail;
//                _labelName.text = @"未认证";
//            }
//            else
//            {
//                _imageviewName.image = m_pImageSuccess;
//                _labelName.text = [NSString stringWithFormat:@"%@ %@",info.name, [Public idCardToAsterisk:info.idcard]];
//                _imageviewNameArrow.hidden = YES;
//            }
            
            if (info.emailstatus == 0)
            {
                _imageviewEmail.image = m_pImageFail;
                _labelEmail.text = @"未认证";
            }
            else
            {
                _imageviewEmail.image = m_pImageSuccess;
                _labelEmail.text = info.email;
            }
            
            if (info.phonestatus == 0)
            {
                _imageviewPhone.image = m_pImageFail;
                _labelPhone.text = @"未认证";
            }
            else
            {
                _imageviewPhone.image = m_pImageSuccess;
                _labelPhone.text = [Public phoneNumToAsterisk:info.phone];
                self.phoneTrustImage.hidden = YES;
            }
            
            if (info.depositstatus == 0)
            {
                _imageviewTrust.image = m_pImageFail;
                _labelTrust.text = @"未认证";
            }
            else
            {
                _imageviewTrust.image = m_pImageSuccess;
                _labelTrust.text = [Public acctNoToAsterisk:info.deposit];
                _imageviewTrustArrow.hidden = YES;
            }
            
            if (info.baseinfostatis == 0)
            {
                _imageviewBaseInfo.image = m_pImageFail;
                _labelBaseInfo.text = @"未认证";
            }
            else
            {
                _imageviewBaseInfo.image = m_pImageSuccess;
                _labelBaseInfo.text = @"已认证";
                _imageviewBaseinfoArrow.hidden = YES;
            }
        }
        else
        {
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
//            [alter show];
        }
    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
    }];
}
@end
