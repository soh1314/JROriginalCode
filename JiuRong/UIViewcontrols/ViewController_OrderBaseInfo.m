//
//  ViewController_OrderBaseInfo.m
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_OrderBaseInfo.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserInfo.h"
#import "ViewController_PaybackDetail.h"

@interface ViewController_OrderBaseInfo ()
{
    NSMutableArray *m_pBillList;
}
@end

@implementation ViewController_OrderBaseInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.scrollviewMain.frame = CGRectMake(0, 64, [Public GetWidth], [Public GetHeight]-64);
    
    m_pBillList = [[NSMutableArray alloc] init];
    self.billID = [ NSString stringWithFormat:@"%lu",self.payBackinfo.ID];
    
    [self.view addSubview:[self InitTitleView:CGRectMake(0, _viewMask.frame.origin.y, self.view.bounds.size.width, 45)]];
    
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

- (UIView*)InitTitleView:(CGRect)rc
{
    UIView *titleview = [[UIView alloc] initWithFrame:rc];
    
    UILabel *labelDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, rc.size.width/3, 21)];
    labelDate.text = @"还款日期";
    labelDate.textAlignment = NSTextAlignmentCenter;
    labelDate.font = [UIFont systemFontOfSize:12.0f];
    [titleview addSubview:labelDate];
    
    UILabel *labelMoney = [[UILabel alloc] initWithFrame:CGRectMake(rc.size.width/3, 12, rc.size.width/6, 21)];
    labelMoney.text = @"还款金额";
    labelMoney.textAlignment = NSTextAlignmentCenter;
    labelMoney.font = [UIFont systemFontOfSize:12.0f];
    [titleview addSubview:labelMoney];
    
    UILabel *labelStatus = [[UILabel alloc] initWithFrame:CGRectMake(rc.size.width/2, 12, rc.size.width/6, 21)];
    labelStatus.text = @"状态";
    labelStatus.textAlignment = NSTextAlignmentCenter;
    labelStatus.font = [UIFont systemFontOfSize:12.0f];
    [titleview addSubview:labelStatus];
    
    UILabel *labelmark = [[UILabel alloc] initWithFrame:CGRectMake(rc.size.width/3*2, 12, rc.size.width/6, 21)];
    labelmark.text = @"是否逾期";
    labelmark.textAlignment = NSTextAlignmentCenter;
    labelmark.font = [UIFont systemFontOfSize:12.0f];
    [titleview addSubview:labelmark];
    
    UILabel *labelControl = [[UILabel alloc] initWithFrame:CGRectMake(rc.size.width/6*5, 12, rc.size.width/6, 21)];
    labelControl.text = @"操作";
    labelControl.textAlignment = NSTextAlignmentCenter;
    labelControl.font = [UIFont systemFontOfSize:12.0f];
    [titleview addSubview:labelControl];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, rc.size.height-1, rc.size.width-30, 1)];
    line.backgroundColor = RGBCOLOR(239, 239, 239);
    [titleview addSubview:line];
    
    return titleview;
}

- (UIControl*)CreateRecorder:(NSString*)time money:(CGFloat)money status:(NSInteger)status y:(NSInteger)posY mode:(NSInteger)iMode
{
    CGFloat fWidth = [Public GetWidth];
    NSInteger baseWidth = (fWidth-40)/3;
    
    UIControl *tmpView = [[UIControl alloc] initWithFrame:CGRectMake(0, posY, fWidth, 30)];
    
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, fWidth/3, 15)];
    labeltime.text = time;
    labeltime.textAlignment = NSTextAlignmentCenter;
    labeltime.font = [UIFont systemFontOfSize:10.0f];
    
    UILabel *labelMoney = [[UILabel alloc] initWithFrame:CGRectMake(fWidth/3, 7, fWidth/6, 15)];
    labelMoney.text = [NSString stringWithFormat:@"%.2f元",money];
    labelMoney.font = [UIFont systemFontOfSize:12.0f];
    labelMoney.textAlignment = NSTextAlignmentCenter;
    
    UILabel *labelMode = [[UILabel alloc] initWithFrame:CGRectMake(fWidth/2, 7, fWidth/6, 15)];
    labelMode.text = [NSString stringWithFormat:@"%.2f元",money];
    labelMode.font = [UIFont systemFontOfSize:12.0f];
    labelMode.textAlignment = NSTextAlignmentCenter;
    switch (iMode)
    {
        case 0:
            labelMode.text = @"正常还款";
            break;
        case -1:
            labelMode.text = @"未还款";
            break;
        case -2:
            labelMode.text = @"逾期未还款";
            break;
        case -3:
            labelMode.text = @"本金垫付还款";
            break;
        case -4:
            labelMode.text = @"逾期还款";
            break;
        case -5:
            labelMode.text = @"待还款";
            break;
        case -6:
            labelMode.text = @"逾期待还款";
            break;
        case -7:
            labelMode.text = @"已转让";
            break;
        case 1:
            labelMode.text = @"正常还款";
            break;
        case 2:
            labelMode.text = @"审核中";
            break;
        default:
            labelMode.text = @"未知错误";
            break;
    }
    
    UILabel *labelStatus = [[UILabel alloc] initWithFrame:CGRectMake(fWidth/3*2, 7, fWidth/6, 15)];
    if (status == -3)
    {
        labelStatus.text = @"逾期";
    }
    else
    {
        labelStatus.text = @"未逾期";
    }
    labelStatus.font = [UIFont systemFontOfSize:12.0f];
    labelStatus.textAlignment = NSTextAlignmentCenter;
    
    UILabel *labelControl = [[UILabel alloc] initWithFrame:CGRectMake(fWidth/6*5, 7, fWidth/6, 15)];
    labelControl.text = @"查看";
    labelControl.font = [UIFont systemFontOfSize:12.0f];
    labelControl.textAlignment = NSTextAlignmentCenter;
    
    labeltime.textColor = RGBCOLOR(165, 165, 165);
    labelMoney.textColor = RGBCOLOR(165, 165, 165);
    labelStatus.textColor = RGBCOLOR(74, 170, 228);
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 29, fWidth-30, 1)];
    line.backgroundColor = RGBCOLOR(239, 239, 239);
    
    [tmpView addSubview:labeltime];
    [tmpView addSubview:labelMoney];
    [tmpView addSubview:labelMode];
    [tmpView addSubview:labelStatus];
    [tmpView addSubview:labelControl];
    [tmpView addSubview:line];
    
    return tmpView;
}

- (void)GetData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetPaybackSchedule:[UserInfo GetUserInfo].uid borrowid:_billID success:^(NSInteger iStatus, NSMutableDictionary *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            NSMutableDictionary *dicDetail = [info objectForKey:@"billDetail"];
            NSMutableDictionary * newestBill = [info objectForKey:@"billList"][0];
            _labelRate.text =  [NSString stringWithFormat:@"%.2f%@",[[dicDetail objectForKey:@"apr"] floatValue],@"%"];
            _labelBorrowID.text =  [NSString stringWithFormat:@"%@",self.payBackinfo.bidno];
            _labelTitle.text =  [dicDetail objectForKey:@"bid_title"];
            _labelMoney.text =  [NSString stringWithFormat:@"%.2f元",[[dicDetail objectForKey:@"loan_amount"] floatValue]];
            _labelTotalMoney.text =  [NSString stringWithFormat:@"%.2f元",[[dicDetail objectForKey:@"repayment_interest_sum"] floatValue] +[[dicDetail objectForKey:@"loan_amount"] floatValue]];
            NSInteger iTotalNumber = [[dicDetail objectForKey:@"loan_periods"] integerValue];
            NSString * iTotalString = [dicDetail objectForKey:@"loan_periods"];
            NSInteger iPaybacking = [[dicDetail objectForKey:@"has_payed_periods"] integerValue];;
            NSString * iPaybackString = [dicDetail objectForKey:@"has_payed_periods"];
            _labelPaybacking.text =  [NSString stringWithFormat:@"%ld期",iTotalNumber-iPaybacking];
            _labelPaybacked.text = [NSString stringWithFormat:@"%ld期",iPaybacking] ;
//            _labelPaybacking.text = iPaybackString;
            
            _labelLimit.text = [NSString stringWithFormat:@"%ld期",iTotalNumber];
//            _labelLimit.text = iTotalString;
            _paybackTimelimitLabel.text = [NSString stringWithFormat:@"%@",[newestBill objectForKey:@"repayment_time"]];
            m_pBillList = [info objectForKey:@"billList"];
            [self UpdateList:m_pBillList];
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
//这块竟然用这种方式创建还款历史信息,真TM 的有才;
- (void)UpdateList:(NSMutableArray*)arrList
{
    NSInteger iCount = [arrList count];
    CGFloat fPosY = _viewMask.frame.origin.y + 45;
    for (NSInteger i = 0; i < iCount; i++)
    {
        //-1未还款-2 本金垫付还款-3 逾期还款0 正常还款
        NSString *time = [arrList[i] objectForKey:@"repayment_time"];
        NSInteger iID = [[arrList[i] objectForKey:@"id"] integerValue];
        NSInteger iStatus = [[arrList[i] objectForKey:@"overdue_mark"] integerValue];
        CGFloat fMoney = [[arrList[i] objectForKey:@"repayment_interest"] floatValue];
        NSInteger iMode = [[arrList[i] objectForKey:@"status"] integerValue];
        UIControl *tmpview = [self CreateRecorder:time money:fMoney status:iStatus y:(fPosY+10+i*30) mode:iMode];
        tmpview.tag = i;
        [tmpview addTarget:self action:@selector(ClickBtnItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollviewMain addSubview:tmpview];
    }
    
    self.scrollviewMain.contentSize = CGSizeMake([Public GetWidth], fPosY+20+30*iCount);
}

- (void)ClickBtnItem:(id)sender
{
    NSInteger iID = ((UIControl*)sender).tag;
    NSLog(@"%ld",iID);
    
    ViewController_PaybackDetail* pBorrow = [self.storyboard instantiateViewControllerWithIdentifier:@"paybackDetail"];
    pBorrow.status = [[m_pBillList[iID] objectForKey:@"status"] integerValue];
    pBorrow.bID = [NSString stringWithFormat:@"%ld",[[m_pBillList[iID] objectForKey:@"id"] integerValue]];
    [self.navigationController pushViewController:pBorrow animated:YES];
}
@end
