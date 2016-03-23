//
//  ViewController_PaybackDetail.m
//  JiuRong
//
//  Created by iMac on 15/10/22.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_PaybackDetail.h"
#import "Public.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import "ViewController_Payback.h"

@interface ViewController_PaybackDetail ()

@end

@implementation ViewController_PaybackDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _btnCommit.layer.cornerRadius = 5.0f;
    if (_status == -1)
    {
        ;
    }
    else if (_status == -2)
    {
        [_btnCommit setTitle:@"本金垫付还款" forState:UIControlStateNormal];
        _btnCommit.enabled = NO;
    }
    else if (_status == 0)
    {
        [_btnCommit setTitle:@"正常还款" forState:UIControlStateNormal];
        _btnCommit.enabled = NO;
    }
    else if (_status == -3)
    {
        [_btnCommit setTitle:@"逾期还款" forState:UIControlStateNormal];
        _btnCommit.enabled = NO;
    }
    
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

- (IBAction)ClickBtnCommit:(id)sender
{
    ViewController_Payback* pBorrow = [self.storyboard instantiateViewControllerWithIdentifier:@"payback"];
    pBorrow.bID = _bID;
    [self.navigationController pushViewController:pBorrow animated:YES];
}

- (void)GetData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetPaybackInfo:[UserInfo GetUserInfo].uid billid:_bID success:^(NSInteger iStatus, NSMutableDictionary *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            NSMutableDictionary *dicDetail = [info objectForKey:@"bidInfo"];
            _labelRate.text =  [NSString stringWithFormat:@"%.2f%@",[[dicDetail objectForKey:@"apr"] floatValue],@"%"];
            _labelBorrowID.text =  [NSString stringWithFormat:@"%ld",[[dicDetail objectForKey:@"bid_id"] integerValue]];
            _labelTitle.text =  [dicDetail objectForKey:@"bid_title"];
            _labelMoney.text =  [NSString stringWithFormat:@"%.2f元",[[dicDetail objectForKey:@"loan_amount"] floatValue]];
            _labelTotalMoney.text =  [NSString stringWithFormat:@"%.2f元",[[dicDetail objectForKey:@"repayment_interest_sum"] floatValue]];
            NSInteger iTotalNumber = [[dicDetail objectForKey:@"loan_periods"] integerValue];
            NSInteger iPaybacking = [[dicDetail objectForKey:@"has_payed_periods"] integerValue];;
            _labelPaybacking.text =  [NSString stringWithFormat:@"%ld期",iPaybacking];
            _labelPaybacked.text =  [NSString stringWithFormat:@"%ld期",iTotalNumber-iPaybacking];
            _labelLimit.text = [NSString stringWithFormat:@"%ld期",iTotalNumber];
            
            NSMutableDictionary *dicInfo = [info objectForKey:@"billInfo"];
            CGFloat fMoney = [[dicInfo objectForKey:@"repayment_corpus"] floatValue];
            CGFloat fMoneyLixi = [[dicInfo objectForKey:@"repayment_interest"] floatValue];
            CGFloat fMoneyFaxi = [[dicInfo objectForKey:@"overdue_fine"] floatValue];
            _labelCurMoney.text =  [NSString stringWithFormat:@"%.2f元",fMoney];
            _labelCurLiXi.text =  [NSString stringWithFormat:@"%.2f元",fMoneyLixi];
            _labelFaXi.text =  [NSString stringWithFormat:@"%.2f元",fMoneyFaxi];
            _labelCurTotalMoney.text =  [NSString stringWithFormat:@"%.2f元",fMoney+fMoneyFaxi+fMoneyLixi];
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
