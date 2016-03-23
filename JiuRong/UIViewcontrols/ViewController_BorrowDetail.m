//
//  ViewController_BorrowDetail.m
//  JiuRong
//
//  Created by iMac on 15/9/22.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_BorrowDetail.h"
#import "Public.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"
#import "ViewController_HFB.h"
#import <HHAlertView/HHAlertView.h>
#import "Arith.h"

static const NSString *cellUseType = @"cellUseType";
static const NSString *cellLimit = @"cellLimit";
static const NSString *cellPaybackMode = @"cellPaybackMode";
static const NSString *cellEndLimit = @"cellEndLimit";

@interface ViewController_BorrowDetail () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UITableView *m_pTableviewUseType;
    UITableView *m_pTableviewLimit;
    UITableView *m_pTableviewPaybackMode;
    UITableView *m_pTableviewEndLimit;
    
    NSMutableArray *m_pArrUseType;
    NSMutableArray *m_pArrLimit;
    NSMutableArray *m_pArrPaybackMode;
    NSMutableArray *m_pArrEndLimit;
//
    NSInteger m_iStatusUseType;
    NSInteger m_iStatusLimit;
    NSInteger m_iStatusPaybackMode;
    NSInteger m_iStatusEndLimit;
    
    CGFloat m_fMinRate;
    CGFloat m_fMaxRate;
    
    NSInteger m_iSelPaybackMode;
    NSInteger m_iSelUseType;
    NSInteger m_iSelEndLimit;
}
@end        

@implementation ViewController_BorrowDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _scrollviewMain.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    
    m_pArrUseType = [[NSMutableArray alloc] init];
    m_pArrLimit = [[NSMutableArray alloc] init];
    m_pArrPaybackMode = [[NSMutableArray alloc] init];
    m_pArrEndLimit = [[NSMutableArray alloc] init];
    
    m_pTableviewUseType = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewUseType.frame.origin.y + _viewUseType.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewUseType.dataSource = self;
    m_pTableviewUseType.delegate = self;
    m_pTableviewUseType.backgroundColor = [UIColor blackColor];
    m_pTableviewUseType.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_pTableviewLimit = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewLimit.frame.origin.y + _viewLimit.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewLimit.dataSource = self;
    m_pTableviewLimit.delegate = self;
    m_pTableviewLimit.backgroundColor = [UIColor blackColor];
    m_pTableviewLimit.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_pTableviewPaybackMode = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewPaybackMode.frame.origin.y + _viewPaybackMode.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewPaybackMode.dataSource = self;
    m_pTableviewPaybackMode.delegate = self;
    m_pTableviewPaybackMode.backgroundColor = [UIColor blackColor];
    m_pTableviewPaybackMode.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_pTableviewEndLimit = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewEndLimit.frame.origin.y + _viewEndLimit.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewEndLimit.dataSource = self;
    m_pTableviewEndLimit.delegate = self;
    m_pTableviewEndLimit.backgroundColor = [UIColor blackColor];
    m_pTableviewEndLimit.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_scrollviewMain addSubview:m_pTableviewUseType];
    [_scrollviewMain addSubview:m_pTableviewLimit];
    [_scrollviewMain addSubview:m_pTableviewPaybackMode];
    [_scrollviewMain addSubview:m_pTableviewEndLimit];
    
    m_pTableviewPaybackMode.hidden = YES;
    m_pTableviewUseType.hidden = YES;
    m_pTableviewLimit.hidden = YES;
    m_pTableviewEndLimit.hidden = YES;
    
    m_iStatusUseType = 0;
    m_iStatusPaybackMode = 0;
    m_iStatusLimit = 0;
    m_iSelEndLimit = 0;
    
    _textfileMinMoney.delegate = self;
    _textfileMoney.delegate = self;
    _textfileRate.delegate = self;
    _textfileTitle.delegate = self;
    _textviewDetail.delegate = self;
    _labelMoney.text = @"0.00";
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

//借款用途
- (IBAction)ClickBtnUseType:(id)sender {
    if (m_iStatusUseType == 0)
    {
        
        NSInteger iCount = [m_pArrUseType count];
        CGRect rc = m_pTableviewUseType.frame;
        rc.size.height += (iCount*30);
        
        
        [UIView animateWithDuration:0.25 animations:^{
            m_pTableviewUseType.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusUseType = 1;
            m_pTableviewUseType.hidden = NO;
        }];
    }
    else
    {
        NSInteger iCount = [m_pArrUseType count];
        CGRect rc = m_pTableviewUseType.frame;
        rc.size.height -= (iCount*30);
       
        [UIView animateWithDuration:0.5 animations:^{
            m_pTableviewUseType.frame = rc;
        } completion:^(BOOL finished) {
             m_iStatusUseType = 0;
            m_pTableviewUseType.hidden = YES;
        }];
    }
}
//借款期限
- (IBAction)ClickBtnLimit:(id)sender
{
    if (m_iStatusLimit == 0)
    {
        NSInteger iCount = [m_pArrLimit count];
        iCount = MIN(10, iCount);
        CGRect rc = m_pTableviewLimit.frame;
        rc.size.height += (iCount*30);
        m_pTableviewLimit.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewLimit.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusLimit = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_pArrLimit count];
        iCount = MIN(10, iCount);
        CGRect rc = m_pTableviewLimit.frame;
        rc.size.height -= (iCount*30);
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewLimit.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusLimit = 0;
            m_pTableviewLimit.hidden = YES;
        }];
    }
}
//还款方式
- (IBAction)ClickBtnPaybackMode:(id)sender
{
    if (m_iStatusPaybackMode == 0)
    {
        NSInteger iCount = [m_pArrPaybackMode count];
        CGRect rc = m_pTableviewPaybackMode.frame;
        rc.size.height += (iCount*30);
        m_pTableviewPaybackMode.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewPaybackMode.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusPaybackMode = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_pArrPaybackMode count];
        CGRect rc = m_pTableviewPaybackMode.frame;
        rc.size.height -= (iCount*30);
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewPaybackMode.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusPaybackMode = 0;
            m_pTableviewPaybackMode.hidden = YES;
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == m_pTableviewUseType)
    {
        return [m_pArrUseType count];
    }
    
    if (tableView == m_pTableviewLimit)
    {
        return [m_pArrLimit count];
    }
    
    if (tableView == m_pTableviewPaybackMode)
    {
        return [m_pArrPaybackMode count];
    }
    
    if (tableView == m_pTableviewEndLimit)
    {
        return [m_pArrEndLimit count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == m_pTableviewUseType)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellUseType];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUseType];
        }
        NSMutableDictionary *dicinfo = m_pArrUseType[indexPath.row];
        cell.textLabel.text = [dicinfo objectForKey:@"name"];
        m_iSelUseType = indexPath.row;
    }
    
    if (tableView == m_pTableviewLimit)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellLimit];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellLimit];
        }
        cell.textLabel.text = m_pArrLimit[indexPath.row];
    }
    
    if (tableView == m_pTableviewPaybackMode)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellPaybackMode];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellPaybackMode];
        }
        NSMutableDictionary *dicinfo = m_pArrPaybackMode[indexPath.row];
        cell.textLabel.text = [dicinfo objectForKey:@"name"];
        m_iSelPaybackMode = indexPath.row;
    }
    
    if (tableView == m_pTableviewEndLimit)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellEndLimit];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellEndLimit];
        }
        cell.textLabel.text = m_pArrEndLimit[indexPath.row];
    }
    
    cell.backgroundColor = RGBCOLOR(242, 242, 242);
    cell.textLabel.backgroundColor = RGBCOLOR(242, 242, 242);
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.accessoryType  = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == m_pTableviewUseType)
    {
        NSInteger iCount = [m_pArrUseType count];
        CGRect rc = m_pTableviewUseType.frame;
        rc.size.height -= (iCount*30);
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewUseType.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusUseType = 0;
            m_pTableviewUseType.hidden = YES;
            _labelUseType.text = [m_pArrUseType[indexPath.row] objectForKey:@"name"];
            [self updateInterestValue];
        }];
    }
    
    if (tableView == m_pTableviewLimit)
    {
        NSInteger iCount = [m_pArrLimit count];
        CGRect rc = m_pTableviewLimit.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewLimit.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusLimit = 0;
            m_pTableviewLimit.hidden = YES;
            _labelLimit.text = m_pArrLimit[indexPath.row];
            [self updateInterestValue];
        }];
    }
    
    if (tableView == m_pTableviewPaybackMode)
    {
        NSInteger iCount = [m_pArrPaybackMode count];
        CGRect rc = m_pTableviewPaybackMode.frame;
        rc.size.height -= (iCount*30);
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewPaybackMode.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusPaybackMode = 0;
            m_pTableviewPaybackMode.hidden = YES;
            _labelPaybackMode.text = [m_pArrPaybackMode[indexPath.row] objectForKey:@"name"];
            [self updateInterestValue];
            
        }];
    }
    
    if (tableView == m_pTableviewEndLimit)
    {
        NSInteger iCount = [m_pArrEndLimit count];
        CGRect rc = m_pTableviewEndLimit.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewEndLimit.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusEndLimit = 0;
            m_pTableviewEndLimit.hidden = YES;
            _labelEndLimit.text = m_pArrEndLimit[indexPath.row];
            [self updateInterestValue];
        }];
    }
    
    
}
- (void)updateInterestValue
{
    NSString * borrowLimitValue = [_labelLimit.text substringWithRange:NSMakeRange(0, _labelLimit.text.length-1)];
    int limitValue = [borrowLimitValue intValue];
    NSString * limiteMode = [_labelLimit.text substringFromIndex:(_labelLimit.text.length-1)];
    int unit;
    int repayment;
    if ([limiteMode isEqualToString:@"天"]) {
        unit = 1;
    }
    else if ([limiteMode isEqualToString:@"年"]) {
        unit = -1;
    }
    else {
        unit = 0;
    }
    if ([_labelEndLimit.text isEqualToString:@"按月还款,等额本息"]) {
        repayment = 1;
    }
    else
    {
        repayment = 2;
    }
    
   NSString * interst = [Arith calculateInterestWithAmount:[_textfileMoney.text floatValue] apr:[_textfileRate.text floatValue]  unit:unit period:limitValue repayment:repayment];
    _labelMoney.text = [NSString stringWithFormat:@"%@",interst];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
     [self updateInterestValue];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
    if ([text isEqualToString:@"\n"])
    {
        //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect rc = _scrollviewMain.frame;
    rc.origin.y -= 219;
    _scrollviewMain.frame = rc;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect rc = _scrollviewMain.frame;
    rc.origin.y += 219;
    _scrollviewMain.frame = rc;
}

- (void)GetData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetProductInfoByID:_productID success:^(NSInteger iStatus, NSMutableDictionary *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        NSMutableArray *arrPurpose = [info objectForKey:@"purpose"];
        m_pArrUseType = [NSMutableArray arrayWithArray:arrPurpose];
        _labelUseType.text = [m_pArrUseType[0] objectForKey:@"name"];
        [m_pTableviewUseType reloadData];
        //付款方式
        NSMutableArray *arrRepayWay = [info objectForKey:@"repayWay"];
        m_pArrPaybackMode = [NSMutableArray arrayWithArray:arrRepayWay];
        _labelPaybackMode.text = [m_pArrPaybackMode[0] objectForKey:@"name"];
        [m_pTableviewPaybackMode reloadData];
        //借款期限
        [m_pArrLimit removeAllObjects];
        NSMutableArray *days = [info objectForKey:@"periodDayArray"];
        NSMutableArray *months = [info objectForKey:@"periodMonthArray"];
        NSMutableArray *years = [info objectForKey:@"periodYearArray"];
        for (NSInteger i = 0; i < [days count]; i++)
        {
            [m_pArrLimit addObject:[NSString stringWithFormat:@"%@天",days[i]]];
        }
        for (NSInteger i = 0; i < [months count]; i++)
        {
            [m_pArrLimit addObject:[NSString stringWithFormat:@"%@月",months[i]]];
        }
        for (NSInteger i = 0; i < [years count]; i++)
        {
            [m_pArrLimit addObject:[NSString stringWithFormat:@"%@年",years[i]]];
        }
        _labelLimit.text = m_pArrLimit[0];
        [m_pTableviewLimit reloadData];
        
        m_fMinRate = [[info objectForKey:@"minInterestRate"] floatValue];
        m_fMaxRate = [[info objectForKey:@"maxInterestRate"] floatValue];
        if (m_fMaxRate - m_fMinRate <= 0.0f)
        {
            _textfileRate.text = [NSString stringWithFormat:@"%.2f",m_fMaxRate];
            _textfileRate.enabled = NO;
        }
        else
        {
            _textfileRate.placeholder = [NSString stringWithFormat:@"%f-%f",m_fMinRate,m_fMaxRate];
        }
        //满标期限
        NSMutableArray *arrTmp = [info objectForKey:@"investPeriodArray"];
        m_pArrEndLimit = [NSMutableArray arrayWithArray:arrTmp];
        _labelEndLimit.text = m_pArrEndLimit[0];
        [m_pTableviewEndLimit reloadData];
//        [self updateInterestValue];
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (IBAction)ClickBtnUpdate:(id)sender {
    
    if ([_textfileMoney.text length] <= 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"借款金额无效" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    if ([_textfileRate.text length] <= 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"贷款利率无效" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    if ([_textfileMinMoney.text length] <= 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"请输入最低投标金额" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    //利率计算重写
    [JiuRongHttp JRGetInterest:[_textfileMoney.text integerValue]  rate:_textfileRate.text unit:1 period:[_labelEndLimit.text integerValue] paybackmode:[m_pArrPaybackMode[m_iSelPaybackMode] objectForKey:@"id"] success:^(NSInteger iStatus, CGFloat fMoney, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            _labelMoney.text = [NSString stringWithFormat:@"%f",fMoney];
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
- (void)interstGetWith:(double)lendMoney APR:(double)apr unit:(int)unit period:(int)period repaymentMode:(NSInteger)repayment
{
    
}
- (IBAction)ClickBtnCommit:(id)sender {
    
    if ([_textfileTitle.text length] <= 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"借款标题不能为空" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    if ([_textfileTitle.text length] > 28)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"请输入少于14个字的借款标题" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    if ([_textfileMoney.text length] <= 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"借款金额无效" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    if ([_textfileMoney.text floatValue] > 50000||[_textfileMoney.text floatValue] < 100) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"借款金额有误" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    if (!_textfileMoney.text)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"请输入借款金额" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    if ([_textfileRate.text length] <= 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"利率不能为空" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    if (_textviewDetail.text.length == 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"借款详情不能为空" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    if (_textviewDetail.text.length > 301)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"请输入少于150字的借款详情描述" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    CGFloat fRate = [_textfileRate.text floatValue];
    if (fRate < m_fMinRate || fRate > m_fMaxRate)
    {
        NSString *alterstring = [NSString stringWithFormat:@"利率范围在%f-%f有效",m_fMinRate,m_fMaxRate];
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:alterstring delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    if ([_textfileMinMoney.text length] <= 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"请输入最低投标金额" delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[UserInfo GetUserInfo].uid forKey:@"userId"];
    [parameters setObject:_productID forKey:@"productId"];
    [parameters setObject:@"21" forKey:@"OPT"];
    [parameters setObject:[m_pArrUseType[m_iSelUseType] objectForKey:@"id"] forKey:@"purposeId"];
    [parameters setObject:_textfileTitle.text forKey:@"title"];
    
    if ([_labelLimit.text containsString:@"天"])
    {
        [parameters setObject:@"1" forKey:@"periodUnit"];
    }
    else if ([_labelLimit.text containsString:@"月"])
    {
        [parameters setObject:@"0" forKey:@"periodUnit"];
    }
    else
    {
        [parameters setObject:@"-1" forKey:@"periodUnit"];
    }
    NSInteger iValue = [_labelLimit.text integerValue];
    [parameters setObject:[NSString stringWithFormat:@"%ld",iValue] forKey:@"period"];

    
    [parameters setObject:[m_pArrPaybackMode[m_iSelPaybackMode] objectForKey:@"id"] forKey:@"repaymentId"];
    [parameters setObject:_labelEndLimit.text forKey:@"investPeriod"];
    [parameters setObject:[NSString stringWithFormat:@"%f",m_fMinRate] forKey:@"apr"];
    [parameters setObject:_textviewDetail.text forKey:@"description"];
    [parameters setObject:_textfileMoney.text forKey:@"amount"];
    [parameters setObject:_textfileMinMoney.text forKey:@"minInvestAmount"];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRBorrowInfoCommit:parameters success:^(NSInteger iStatus, NSString *bid, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"借款成功" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            alter.tag = 10000;
            [alter show];
/*
        ViewController_HFB* pIndentity = (ViewController_HFB*)[self.storyboard instantiateViewControllerWithIdentifier:@"pushHFB"];
            pIndentity.bID = bid;
            [self.navigationController pushViewController:pIndentity animated:YES];
 */
//           [[HHAlertView shared] showAlertWithStyle:HHAlertStyleOk inView:self.view Title:@"久融金融" detail:@"发布借款成功" cancelButton:nil Okbutton:@"呦,我知道了!" block:^(HHAlertButton buttonindex) {
//                if (buttonindex == HHAlertButtonOk)
//                {
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                    self.tabBarController.selectedIndex = 0;
//                }
//            }];

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
- (IBAction)HideKeyboard:(id)sender {
    [_textfileRate resignFirstResponder];
    [_textfileMinMoney resignFirstResponder];
    [_textfileMoney resignFirstResponder];
    [_textfileTitle resignFirstResponder];
    [_textviewDetail resignFirstResponder];
}
//满标期限
- (IBAction)ClickBtnEndLimit:(id)sender {
    
    if (m_iStatusEndLimit == 0)
    {
        NSInteger iCount = [m_pArrEndLimit count];
        CGRect rc = m_pTableviewEndLimit.frame;
        rc.size.height += (iCount*30);
        m_pTableviewEndLimit.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewEndLimit.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusEndLimit = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_pArrEndLimit count];
        CGRect rc = m_pTableviewEndLimit.frame;
        rc.size.height -= (iCount*30);
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewEndLimit.frame = rc;
        } completion:^(BOOL finished) {
            m_iStatusEndLimit = 0;
            m_pTableviewEndLimit.hidden = YES;
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag == 10000)
    {
        
        [self.navigationController popViewControllerAnimated:YES];
//        self.tabBarController.selectedIndex = 0;
    
        
        
        
    }
}

@end
