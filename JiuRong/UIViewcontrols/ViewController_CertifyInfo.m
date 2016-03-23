//
//  ViewController_CertifyInfo.m
//  JiuRong
//
//  Created by iMac on 15/9/23.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_CertifyInfo.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserInfo.h"

@interface ViewController_CertifyInfo ()

@end

@implementation ViewController_CertifyInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _btnCommit.layer.cornerRadius = 5.0f;

    [self GetData];
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

- (void)GetData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetCertifyInfoResult:[UserInfo GetUserInfo].uid mark:_mark success:^(NSInteger iStatus, NSMutableDictionary *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        
        if (iStatus == 1)
        {
            _labelScore.text = [NSString stringWithFormat:@"%ld",[[info objectForKey:@"creditScore"] integerValue]];
            _labelSubject.text = _subject;
            
            NSInteger status  = [[info objectForKey:@"status"] integerValue];
            switch (status)
            {
                case -1:
                    _labelStatus.text = @"未通过审核";
                    break;
                case 0:
                    _labelStatus.text = @"未提交";
                    break;
                case 1:
                    _labelStatus.text = @"审核中";
                    break;
                case 2:
                    _labelStatus.text = @"已通过审核";
                    break;
                case 3:
                    _labelStatus.text = @"过期失效";
                    break;
                case 4:
                    _labelStatus.text = @"上传未付款";
                    break;
                default:
                    _labelStatus.text = @"未知";
                    break;
            }
            
            _labelLimittime.text = [NSString stringWithFormat:@"%ld天",[[info objectForKey:@"period"] integerValue]];
            _labelEndtime.text = [info objectForKey:@"expireTime"];
            _labelApplytime.text = [info objectForKey:@"time"];
            _labelCommittime.text = [info objectForKey:@"auditTime"];
            NSString *suggest = [info objectForKey:@"suggestion"];
            if ((NSNull*)suggest == [NSNull null])
            {
                _labelSuggest.text = @"无";
            }
            else
            {
                _labelSuggest.text = suggest;
            }
            _labelMoney.text = [NSString stringWithFormat:@"%ld",[[info objectForKey:@"auditFee"] integerValue]];;
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];;
        }
        
        
    
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (IBAction)commitAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
