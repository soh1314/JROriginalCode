//
//  ViewController_TenderDetial.m
//  JiuRong
//
//  Created by iMac on 15/9/10.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_TenderDetial.h"
#import "Public.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"
#import "BorrowInfo.h"
#import <HHAlertView/HHAlertView.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface ViewController_TenderDetial () <UIScrollViewDelegate,UIWebViewDelegate>
{
    NSMutableArray *m_listRecorder;
    NSMutableArray *m_listViews;
    BOOL    m_bShowView;
    UIView *m_pBtnView;
    
    UIWebView *m_pWebviewHuihu;
}
@end

@implementation ViewController_TenderDetial

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    [self.creditLevel sd_setImageWithURL:[NSURL URLWithString:[JiuRongHttp JRGetImagePath:_info.creditRating]] placeholderImage:nil];
    _textfileMoney.delegate = self;
    _textfileMoney.placeholder = @"请输入100的倍数";
    
    [self UpdateInfo];
    
    m_listViews = [[NSMutableArray alloc] init];
    
    m_listRecorder = [[NSMutableArray alloc] init];
    
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

- (void)UpdateUI
{
    CertifyInfo *cerdityinfo = [UserInfo GetUserInfo].certifyinfo;
    if (cerdityinfo.phonestatus == 0 || cerdityinfo.depositstatus == 0 || cerdityinfo.namestatus == 0)
    {
        _viewSafeCertify.hidden = NO;
        CGRect rc = _viewSafeCertify.frame;
        rc.origin.y = [Public GetHeight] - 75 - 64;
        _viewSafeCertify.frame = rc;
    }
    else
    {
        _viewSafeCertify.hidden = YES;
        if (_info.progress >= 100)
        {
            [self.view addSubview:[self CreateViewWithTarget:NO]];
        }
        else
        {
            [self.view addSubview:[self CreateViewWithTarget:YES]];
        }
    }
    
    self.scrollviewMain.frame = CGRectMake(0, 0, self.view.frame.size.width, [Public GetHeight]-90);
}

- (void)InitUIWithText:(NSMutableArray*)list
{
    NSInteger iCount = [list count];
    if (iCount <= 0)
    {
        self.scrollviewMain.contentSize = CGSizeMake([Public GetWidth], self.viewList.frame.origin.y + 64);
        return;
    }
    
    for (NSInteger i = 0; i < iCount; i++)
    {
        MoneyInfo *info = list[i];
        UIView *tmp = [self CreateItem:i+1 info:info rect:CGRectMake(0, i*45, self.viewList.bounds.size.width, 45)];
        [self.viewList addSubview:tmp];
    }
    
    CGRect rc = self.viewList.frame;
    rc.size.height = 45*iCount;
    self.viewList.frame = rc;
    
    self.scrollviewMain.contentSize = CGSizeMake([Public GetWidth], self.viewList.frame.origin.y + self.viewList.frame.size.height + 64);
}

- (UIView*)CreateItem:(NSInteger)index info:(MoneyInfo*)info rect:(CGRect)rc
{
    UIView *tmp = [[UIView alloc] initWithFrame:rc];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 30, 21)];
    label.text = [NSString stringWithFormat:@"%ld",index];
    label.font = [UIFont systemFontOfSize:20.f];
    label.textColor = RGBCOLOR(178, 178, 178);
    label.textAlignment = NSTextAlignmentLeft;
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(50, 1, 150, 21)];
    labelname.text = [Public userNameToAsterisk:info.name];
    labelname.font = [UIFont systemFontOfSize:12.f];
    labelname.textColor = RGBCOLOR(0, 0, 0);
    labelname.textAlignment = NSTextAlignmentLeft;
    
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(50, 23, 150, 21)];
    labeltime.text = info.time;
    labeltime.font = [UIFont systemFontOfSize:12.f];
    labeltime.textColor = RGBCOLOR(178, 178, 178);
    labeltime.textAlignment = NSTextAlignmentLeft;
    
    UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake((rc.size.width - 100), 12, 80, 21)];
    labelmoney.text = [NSString stringWithFormat:@"¥%@",[Public Number2String:info.amount]];
    labelmoney.font = [UIFont systemFontOfSize:20.f];
    labelmoney.textColor = RGBCOLOR(0, 0, 0);
    labelmoney.textAlignment = NSTextAlignmentLeft;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, rc.size.height-1, rc.size.width-20, 1)];
    line.backgroundColor = RGBCOLOR(243, 243, 243);
    
    [tmp addSubview:label];
    [tmp addSubview:labelname];
    [tmp addSubview:labeltime];
    [tmp addSubview:labelmoney];
    [tmp addSubview:line];
    
    return tmp;
}

- (void)UpdateInfo
{
    
    _labelTitle.text = [NSString stringWithFormat:@"%@  %@",_info.no,_info.text];
    _labelBorrowAmont.text = [NSString stringWithFormat:@"%ld,%.3ld元",_info.amount/1000,_info.amount%1000];
//    _labelBorrowAmont.text = _info.KborrowingAmount;
    _labelRate.text = [NSString stringWithFormat:@"%.2f%%",_info.rate];
    _labelLimit.text = [NSString stringWithFormat:@"%ld个月",_info.limit];
    if (_info.paymentMode == 0)
    {
        _labelPaybackMode.text = @"按月还款,等本等息";
    }
    else if (_info.paymentMode == 1)
    {
        _labelPaybackMode.text = @"按月还款,等本等息";
    }
    else
    {
        _labelPaybackMode.text = @"按月还款,等本等息";
    }
    
    [_progressCollect setProgress:_info.progress/100];
    _labelCollect.text = [NSString stringWithFormat:@"%.0f%%",_info.progress];
    
    _labelCriditScore.text = [NSString stringWithFormat:@"%ld分",_info.creditScore];
    
    _labelName.text = _info.realityName;
    _labelName.text = [Public userNameToAsterisk:_info.realityName];
    _labelSex.text = _info.sex;
    _labelAge.text = [NSString stringWithFormat:@"%ld",_info.age];
    _labelIDNum.text = [Public idCardToAsterisk:_info.idNumber];
//    _labelAddress.text = _info.familyAddress;
    _labelEdution.text = _info.educationName;
    _labelMarry.text = _info.maritalName;
    _labelHouse.text = _info.houseName;
    _labelCar.text = _info.carName;
    _labelPurse.text = _info.purpose;
    
    _labelReview.text = _info.auditSuggest;
    _labelRecord1.text = [NSString stringWithFormat:@"%ld",_info.borrowSuccessNum];
    _labelRecord2.text = [NSString stringWithFormat:@"%ld",_info.borrowFailureNum];
    _labelRecord3.text = [NSString stringWithFormat:@"%ld",_info.repaymentNormalNum];
    _labelRecord4.text = [NSString stringWithFormat:@"%ld",_info.repaymentOverdueNum];
    
    _labelTime1.text = [NSString stringWithFormat:@"%ld",_info.borrowSuccessNum];
    _labelTime2.text = [NSString stringWithFormat:@"%ld",_info.repaymentNormalNum];
    _labelTime3.text = [NSString stringWithFormat:@"%ld",_info.repaymentOverdueNum];
    _labelTime4.text = [NSString stringWithFormat:@"%ld",_info.financialBidNum];
    
    _labelMoney1.text = [NSString stringWithFormat:@"%ld元",_info.borrowingAmount];
    _labelMoney1.text = _info.KborrowingAmount;
    _labelMoney2.text = _info.KreimbursementAmount;
    _labelMoney3.text = [NSString stringWithFormat:@"%ld元",_info.paymentAmount];
    _labelMoney3.text = _info.KpaymentAmount;
    _labelAddress.text = _info.familyAddress;
    _labelRegisterTime.text = _info.registrationTime;
    _labelBorrowDescrips.text = _info.borrowDetails;
    _labelRemainTime.text = _info.investExpireTime;
    
    switch (_info.status)
    {
        case 0:
            _labelBorrowStatus.text = @"审核中";
            break;
        case 1:
            _labelBorrowStatus.text = @"筹款中";
            break;
        case 2:
            _labelBorrowStatus.text = @"还款中";
            break;
        case 3:
            _labelBorrowStatus.text = @"已还款";
            break;
        case -1:
            _labelBorrowStatus.text = @"审核不通过";
            break;
        case -2:
            _labelBorrowStatus.text = @"流标";
            break;
        default:
            break;
    }
    
    
    _labelMinMoney.text = [NSString stringWithFormat:@"%ld元",_info.minTenderedSum];
    
    m_bShowView = FALSE;
    _textfileMoney.delegate = self;
}

- (void)GetData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetDetialMoneyList:_info.ID index:1 size:10 success:^(NSInteger iStatus, NSMutableArray *moneys, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        
        if (iStatus == 1)
        {
            m_listRecorder = moneys;
            [self InitUIWithText:m_listRecorder];
            [self UpdateUI];
        }
        else
        {
            ;
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
    }];
}
- (IBAction)HideKeyboard:(id)sender {
    [_textfileMoney resignFirstResponder];
}

- (IBAction)HideView:(id)sender {
    
    [_textfileMoney resignFirstResponder];
    if (m_bShowView)
    {
        CGRect rc = _viewBottom.frame;
        rc.origin.y = self.view.bounds.size.height;
        
        [UIView animateWithDuration:1.0f animations:^{
            _viewBottom.frame = rc;
        } completion:^(BOOL finished) {
            m_bShowView = FALSE;
            m_pBtnView.hidden = NO;
        }];
    }
}

- (UIView*)CreateViewWithTarget:(BOOL)bTarget
{
    m_pBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, [Public GetHeight]-60-64, self.view.frame.size.width, 60)];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 7, self.view.bounds.size.width-20, 45)];
    if (bTarget)
    {
        [btn setTitle:@"立即投标" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(ClickBtnCommit) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [btn setTitle:@"已满标" forState:UIControlStateNormal];
    }
    btn.layer.cornerRadius = 3.0f;
    btn.backgroundColor = RGBCOLOR(56, 169, 224);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [m_pBtnView addSubview:btn];
    
    m_pBtnView.backgroundColor = [UIColor whiteColor];
    
    return m_pBtnView;
}

- (void)ClickBtnCommit
{
    if (!m_bShowView)
    {
        m_pBtnView.hidden = YES;
        CGRect rc = _viewBottom.frame;
        rc.origin.y = self.view.bounds.size.height;
        _viewBottom.frame = rc;
        
        CGRect rcNew = _viewBottom.frame;
        rcNew.origin.y -= 200;
        
        [UIView animateWithDuration:1.0f animations:^{
            _viewBottom.frame = rcNew;
        } completion:^(BOOL finished) {
            m_bShowView = TRUE;
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)ClickBtnSure:(id)sender {
    
    NSInteger iMoney = [_textfileMoney.text integerValue];
    if (iMoney < 100 || iMoney%100 != 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"您输入的金额不符合规定" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRInvest:[UserInfo GetUserInfo].uid borrowid:_info.ID amount:[_textfileMoney.text integerValue] pwd:@"123456" success:^(NSInteger iStatus, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
/*            [[HHAlertView shared] showAlertWithStyle:HHAlertStyleOk inView:self.view Title:@"久融金融" detail:@"投标成功" cancelButton:nil Okbutton:@"呦,我知道了!" block:^(HHAlertButton buttonindex) {
                if (buttonindex == HHAlertButtonOk)
                {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    self.tabBarController.selectedIndex = 0;
                }
            }];*/
            
            NSString *url = [JiuRongHttp JRGetInvest:[UserInfo GetUserInfo].uid borrowid:[NSString stringWithFormat:@"%ld",_info.ID] amount:[_textfileMoney.text integerValue] pwd:@"123456"];
            UIWebView *webview = [self CreateWebView:url];
            [self.view addSubview: webview];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIWebView*)CreateWebView:(NSString*)url
{
    if (m_pWebviewHuihu == nil)
    {
        m_pWebviewHuihu = [[UIWebView alloc] initWithFrame:self.view.bounds];
        m_pWebviewHuihu.delegate = self;
        
    }
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [m_pWebviewHuihu loadRequest:request];
    
    return m_pWebviewHuihu;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //获取请求的绝对路径.
    NSString *requestString = request.URL.absoluteString;
    //提交请求时候分割参数的分隔符
    NSArray *components = [requestString componentsSeparatedByString:@"#"];
    
    if ([components count] > 1)
    {
        if ([components[1] isEqualToString:@"1"])
        {
            NSLog(@"successed");
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else if ([components[1] isEqualToString:@"2"])
        {
            NSLog(@"back");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
    return YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _textfileMoney)
    {
        CGRect rc = _viewBottom.frame;
        rc.origin.y -= 219;
        _viewBottom.frame = rc;
    }
    
    return TRUE;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _textfileMoney)
    {
        CGRect rc = _viewBottom.frame;
        rc.origin.y += 219;
        _viewBottom.frame = rc;
    }
}
@end
