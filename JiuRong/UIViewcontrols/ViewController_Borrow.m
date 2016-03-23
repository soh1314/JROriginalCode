//
//  ViewController_Borrow.m
//  JiuRong
//
//  Created by iMac on 15/9/22.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//
// this is borrowMoney viewcontroller.... --liuyangqing
#import "ViewController_Borrow.h"
#import "Public.h"
#import "LYViewButtons.h"
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "BorrowCertifyInfo.h"
#import "ViewController_BorrowProjectDetail.h"
#import "ViewController_IdentityCard.h"
#import "ViewController_ApplyInfo.h"
#import "ViewController_BorrowDetail.h"
#import "PopViewLikeQQView.h"
#import "ViewController_BorrowApplyForm.h"

@interface ViewController_Borrow () <UITableViewDataSource, UITableViewDelegate, LYViewButtonsDelegate,UIAlertViewDelegate>
{
    UITableView *m_pTableview;
    NSMutableArray *m_pArrItems;
    NSInteger m_iStatus;
    
    NSMutableArray *m_pListViews;
    NSInteger m_CurSelType;
    CertifyBaseInfo *m_pCurInfo;
    
    UIScrollView *m_pScrollviewMain;
    
    LYViewButtons *m_pButtons;
    UILabel * addLabel;//认证资料
    BOOL canBorrow;
}
@property (nonatomic,strong)UIView * backgroundView;
@end

@implementation ViewController_Borrow
- (id)init
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //backgroundView is for popView tapping to disappear;
/*
    self.backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.backgroundView];
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.1;
    self.backgroundView.hidden = YES;
 */
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    m_pArrItems = [[NSMutableArray alloc] init];
    m_pListViews = [[NSMutableArray alloc] init];
    m_iStatus = 0;
    m_CurSelType = 0;
    m_pScrollviewMain = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 160, self.view.bounds.size.width, self.view.bounds.size.height-160)];
    [self.view addSubview:m_pScrollviewMain];

    CGRect rc = self.viewType.frame;
    rc.origin.y += rc.size.height+64;
    rc.size.height = 0;
    m_pTableview = [[UITableView alloc] initWithFrame:rc];
    m_pTableview.backgroundColor = RGBCOLOR(242, 242, 242);
    m_pTableview.delegate = self;
    m_pTableview.dataSource = self;
    m_pTableview.separatorColor = [UIColor lightGrayColor];
    m_pTableview.hidden = YES;
    m_pTableview.backgroundColor = [UIColor whiteColor];
    m_pTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_pTableview];
    _viewType.layer.borderColor = [RGBCOLOR(240, 240, 240) CGColor];
    _viewType.layer.borderWidth = 1.0f;
    _viewType.layer.cornerRadius = 2.0f;
    
    m_pButtons = [LYViewButtons CreateLYViewButtons];
    m_pButtons.frame = CGRectMake(0, 46, self.view.bounds.size.width, 60);
    m_pButtons.delegate = self;
    [m_pButtons.btnProRepayment setImage:[UIImage imageNamed:@"提现.png"] forState:UIControlStateNormal];
    m_pButtons.labelProRepayment.text = @"提现";
    
    m_pButtons.labelBorrower.text =@"立即申请";
    [self.view insertSubview:m_pButtons atIndex:0];
    
    _btnBorrow.layer.cornerRadius = 5.0f;
    _btnDetail.layer.cornerRadius = 5.0f;
    addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    addLabel.text = @"   认证资料";
    addLabel.font = [UIFont systemFontOfSize:12];
    addLabel.backgroundColor = [UIColor whiteColor];
    addLabel.textColor = [UIColor blackColor];
    [m_pScrollviewMain addSubview:addLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    if (_viewStatus == -1)
    {
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
        self.navigationItem.leftBarButtonItem = leftButtonItem;
        
//        self.tabBarController.tabBar.hidden = YES;
    }
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self GetData];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
   if (_viewStatus == -1)
    {
        self.tabBarController.tabBar.hidden = NO;
    }
 
    [super viewDidDisappear:animated];
}

- (void)ClickBtnLeft
{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     
     if ([[segue identifier] isEqualToString:@"pushProductDetail"])
     {
         ViewController_BorrowProjectDetail *viewcontrol = (ViewController_BorrowProjectDetail*)segue.destinationViewController;
         BorrowCertifyInfo *info = m_pArrItems[m_CurSelType];
         viewcontrol.pid = info.uid;
     }
     
     if ([[segue identifier] isEqualToString:@"pushApplyInfo"])
     {
         ViewController_ApplyInfo *viewcontrol = (ViewController_ApplyInfo*)segue.destinationViewController;
         viewcontrol.info = m_pCurInfo;
     }
}


- (IBAction)UpdateStatus:(id)sender {
    
    if (m_iStatus == 0)
    {
        [self ShowTableview];
    }
    else
    {
        [self HideTableview];
    }
    
}


- (IBAction)ClickBtnDetail:(id)sender {
    [self performSegueWithIdentifier:@"pushProductDetail" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_pArrItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellCombox"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellCombox"];
    }
    
    CertifyBaseInfo *info = m_pArrItems[indexPath.row];
    
//    cell.backgroundColor = RGBCOLOR(242, 242, 242);
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor whiteColor];
//    cell.textLabel.backgroundColor = RGBCOLOR(242, 242, 242);
    cell.textLabel.text = info.name;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.accessoryType  = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.backgroundView.hidden = YES;
    BorrowCertifyInfo *info = m_pArrItems[indexPath.row];
    _labelType.text = info.name;
    [self HideTableview];
    
    m_CurSelType = indexPath.row;
    [self UpdateInfo:indexPath.row];
}

- (void)ShowTableview
{
//    NSInteger iCount = [m_pArrItems count];
//    CGRect rc = m_pTableview.frame;
//    rc.size.height += (iCount*45);
//    m_pTableview.hidden = NO;
//    
//    [UIView animateWithDuration:0.5f animations:^{
//        m_pTableview.frame = rc;
////        m_pTableview.alpha = 0.5f;
//    } completion:^(BOOL finished) {
//        m_iStatus = 1;
//        [m_pTableview reloadData];
//    }];
//
//    self.backgroundView.hidden = NO;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHideTableView:)];
//    [self.backgroundView addGestureRecognizer:tap];
    
//show popView  ------- creat by iOS_liu
    NSArray * titleArray = @[@"大学贷",@"创业贷",@"救急贷",@"校草贷",@"校花贷"];
    [PopViewLikeQQView configCustomPopViewWithFrame:CGRectMake(CGRectGetMinX(self.viewType.frame), CGRectGetMaxY(self.viewType.frame), self.viewType.frame.size.width, 200) imagesArr:nil dataSourceArr:titleArray anchorPoint:CGPointMake(0.25, 0.5) seletedRowForIndex:^(NSInteger index) {
        BorrowCertifyInfo *info = m_pArrItems[index];
        _labelType.text = info.name;
        [self HideTableview];
        m_CurSelType = index;
        [self UpdateInfo:index];
    } animation:YES timeForCome:0.5 timeForGo:0.5];
    
    
}
- (void)tapHideTableView:(UIGestureRecognizer *)tap
{
    if (self.backgroundView) {
        self.backgroundView.hidden = YES;
    }
    if (!m_pTableview.hidden) {
        [self HideTableview];
    }

}
- (void)HideTableview
{
    NSInteger iCount = [m_pArrItems count];
    CGRect rc = m_pTableview.frame;
    rc.size.height -= (iCount*45);
    
    [UIView animateWithDuration:0.5f animations:^{
        m_pTableview.frame = rc;
//        m_pTableview.alpha = 1.0f;
    } completion:^(BOOL finished) {
        m_iStatus = 0;
        m_pTableview.hidden = YES;
    }];
}

- (void)DidSelectedButton:(NSInteger)iOldIndex newIndex:(NSInteger)iNewIndex
{
    NSLog(@"%ld --> %ld",iOldIndex, iNewIndex);
    
    if ([UserInfo GetUserInfo].isLogin == NO)
    {
        UIViewController* pRoot = [self.storyboard instantiateViewControllerWithIdentifier:@"loginroot"];
        [self presentModalViewController:pRoot animated:YES];
    }
    else
    {
        if (iNewIndex == 0)
        {
            if ([UserInfo GetUserInfo].certifyinfo.depositstatus == 0 || [UserInfo GetUserInfo].certifyinfo.namestatus == 0)
            {
                UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"certifyMember"];
                [self.navigationController pushViewController:pRecharge animated:YES];
            }
            else
            {
                if ([m_pArrItems count] == 0)
                {
                    return;
                }
                
                ViewController_BorrowDetail* pBorrow = [self.storyboard instantiateViewControllerWithIdentifier:@"borrowDetail"];
                BorrowCertifyInfo *info = m_pArrItems[m_CurSelType];
                pBorrow.productID = info.uid;
                [self.navigationController pushViewController:pBorrow animated:YES];
            }
            
        }
        else if (iNewIndex == 1)
        {
            
            UIViewController* pBorrow = [self.storyboard instantiateViewControllerWithIdentifier:@"accountBorrow"];
            [self.navigationController pushViewController:pBorrow animated:YES];
        }
        else if (iNewIndex == 2)
        {
            if ([UserInfo GetUserInfo].certifyinfo.depositstatus == 0 || [UserInfo GetUserInfo].certifyinfo.namestatus == 0)
            {
                UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"certifyMember"];
                [self.navigationController pushViewController:pRecharge animated:YES];
            }
            else
            {
                UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"recharge"];
                [self.navigationController pushViewController:pRecharge animated:YES];
            }
            
        }
        else if (iNewIndex == 3)
        {
            if ([UserInfo GetUserInfo].certifyinfo.depositstatus == 0 || [UserInfo GetUserInfo].certifyinfo.namestatus == 0)
            {
                UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"certifyMember"];
                [self.navigationController pushViewController:pRecharge animated:YES];
            }
            else
            {
                UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"withdrawCash"];
                [self.navigationController pushViewController:pRecharge animated:YES];
            }
            
        }
    }
}
//后期改为tableview
- (UIControl*)CreateViewWithTitle:(NSString*)title flag:(BOOL)bCerfity status:(NSInteger)iStatus rect:(CGRect)rc
{
    UIControl *tmpview = [[UIControl alloc] initWithFrame:rc];
    tmpview.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageHead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 14, 14)];
//    imageHead.contentMode = UIViewContentModeCenter;
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 100, 21)];
    labelTitle.text = title;
    labelTitle.font = [UIFont systemFontOfSize:14.0f];
    labelTitle.textColor = RGBCOLOR(156, 156, 156);
    
    UILabel *labelNeed = [[UILabel alloc] initWithFrame:CGRectMake(130, 12, 70, 21)];
    if (bCerfity)
    {
        labelNeed.text = @"必审项";
    }
    else
    {
        labelNeed.text = @"非必审项";
    }
    labelNeed.font = [UIFont systemFontOfSize:14.0f];
    labelNeed.textColor = RGBCOLOR(156, 156, 156);
    
    UILabel *labelStatus = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, 12, 80, 21)];
    labelStatus.font = [UIFont systemFontOfSize:14.0f];
    labelStatus.textColor = RGBCOLOR(156, 156, 156);
    switch (iStatus)
    {
        case 0:
            imageHead.image = [UIImage OriginalImageNamed:@"未提交.png"];
            labelStatus.text = @"未提交";
            break;
        case 1:
            imageHead.image = [UIImage OriginalImageNamed:@"审核中.png"];
            labelStatus.text = @"审核中";
            break;
        case 2:
            imageHead.image = [UIImage OriginalImageNamed:@"审核通过.png"];
            labelStatus.text = @"审核通过";
            break;
        case 3:
            imageHead.image = [UIImage OriginalImageNamed:@"审核失败.png"];
            labelStatus.text = @"过期失效";
            break;
        case 4:
            imageHead.image = [UIImage OriginalImageNamed:@"审核中.png"];
            labelStatus.text = @"审核中";
            break;
        case -1:
            imageHead.image = [UIImage OriginalImageNamed:@"审核失败.png"];
            labelStatus.text = @"未通过审核";
            break;
        default:
            imageHead.image = [UIImage OriginalImageNamed:@"审核失败.png"];
            labelStatus.text = @"未知";
            break;
    }
    
    UIImageView *imageviewArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 20, 18, 15, 15)];
//    imageviewArrow.contentMode = UIViewContentModeCenter;
    imageviewArrow.image = [UIImage OriginalImageNamed:KTableArrow];
    
    [tmpview addSubview:imageHead];
    [tmpview addSubview:labelTitle];
    [tmpview addSubview:labelNeed];
    [tmpview addSubview:labelStatus];
    [tmpview addSubview:imageviewArrow];
    
    return tmpview;
}

- (UIView*)CreateInfoViewWithFrame:(CGRect)rc
{
    UIView *tmpview = [[UIView alloc] initWithFrame:rc];
    tmpview.backgroundColor = RGBCOLOR(255, 251, 211);
    
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, self.view.bounds.size.width - 20, 12)];
    labelOne.text = @"温馨提示:";
    labelOne.textColor = RGBCOLOR(156, 156, 156);
    labelOne.font = [UIFont systemFontOfSize:12.0f];
    
    UILabel *labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, self.view.bounds.size.width - 20, 12)];
    labelTwo.text = @"非必审项资料填写可以提高放贷速度以及个人信用积分";
    labelTwo.textColor = RGBCOLOR(156, 156, 156);
    labelTwo.font = [UIFont systemFontOfSize:12.0f];
    
    UILabel *labelThree = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, self.view.bounds.size.width - 20, 12)];
    labelThree.text = @"必审项,请您务必按要求填写完整提交,否则将借款失败";
    labelThree.textColor = RGBCOLOR(156, 156, 156);
    labelThree.font = [UIFont systemFontOfSize:12.0f];
    
    [tmpview addSubview:labelOne];
    [tmpview addSubview:labelTwo];
    [tmpview addSubview:labelThree];
    
    return tmpview;
}

- (void)GetData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetBorrowCertifyInfo:[UserInfo GetUserInfo].uid success:^(NSInteger iStatus, NSMutableArray *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        
        if (iStatus == 1)
        {
            [m_pArrItems removeAllObjects];
            
            NSInteger iCount = [info count];
            for (NSInteger i = 0; i < iCount; i++)
            {
                BorrowCertifyInfo *tmpInfo = [[BorrowCertifyInfo alloc] init];
                
                tmpInfo.uid = [info[i] objectForKey:@"productId"];
                tmpInfo.name = [info[i] objectForKey:@"productName"];
                
                NSMutableArray *arrItems = [info[i] objectForKey:@"auditItems"];
                NSInteger iSize = [arrItems count];
                for (NSInteger j = 0; j < iSize; j++)
                {
                    CertifyBaseInfo *baseinfo = [[CertifyBaseInfo alloc] init];
                    
                    baseinfo.uid = [[arrItems[j] objectForKey:@"auditId"] integerValue];
                    baseinfo.name = [arrItems[j] objectForKey:@"auditName"];
                    baseinfo.status = [[arrItems[j] objectForKey:@"auditStatus"] integerValue];
                    baseinfo.type = [[arrItems[j] objectForKey:@"type"] integerValue];
                    baseinfo.Description = [arrItems[j] objectForKey:@"description"];
                    baseinfo.mark = [arrItems[j] objectForKey:@"mark"];
                    baseinfo.imageURL = [arrItems[j] objectForKey:@"imgUrl"];
                    baseinfo.iNeed = [[arrItems[j] objectForKey:@"need"] integerValue];
                        
                    [tmpInfo.arrItems addObject:baseinfo];
                }
                
                [m_pArrItems addObject:tmpInfo];
            }
            
            [self UpdateInfo:0];
            
            if (([UserInfo GetUserInfo].certifyinfo.depositstatus == 0)
                || ([UserInfo GetUserInfo].certifyinfo.baseinfostatis == 0))
            {
                [_btnBorrow setTitle:@"会员认证" forState:UIControlStateNormal];
            }
            else
            {
                [_btnBorrow setTitle:@"申请借款" forState:UIControlStateNormal];
            }
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

- (void)UpdateInfo:(NSInteger)iIndex
{
    [self RemoveAllView];
    
    NSInteger iCount = [m_pArrItems count];
    if (iCount <= iIndex)
    {
        _btnBorrow.enabled = NO;
        _btnDetail.enabled = NO;
        return;
    }
    
    BorrowCertifyInfo *info = m_pArrItems[iIndex];
    NSInteger iSize = [info.arrItems count];
    canBorrow = YES;
    for (NSInteger i = 0; i < iSize; i++)
    {
        CertifyBaseInfo *baseinfo = info.arrItems[i];
        
        UIControl *myview = [self CreateViewWithTitle:baseinfo.name flag:baseinfo.iNeed==0?NO:YES status:baseinfo.status rect:CGRectMake(0, 30+46*i, self.view.bounds.size.width, 45)];
        myview.tag = i;
        [myview addTarget:self action:@selector(ClickBtnItem:) forControlEvents:UIControlEventTouchUpInside];
        [m_pListViews addObject:myview];
        [m_pScrollviewMain insertSubview:myview atIndex:0];

    }
    
    if (iSize > 0)
    {
        UIView *bottomView = [self CreateInfoViewWithFrame:CGRectMake(0, 30+46*iSize, self.view.bounds.size.width, 65)];
        [m_pListViews addObject:bottomView];
        [m_pScrollviewMain addSubview:bottomView];
        
        m_pScrollviewMain.contentSize = CGSizeMake(self.view.bounds.size.width, 46*iSize+65+121);
    }
    else
    {
        m_pScrollviewMain.contentSize = CGSizeMake(self.view.bounds.size.width, 0);
    }
    
    m_CurSelType = iIndex;
    if ([m_pArrItems count] > 0)
    {
        BorrowCertifyInfo *info = m_pArrItems[iIndex];
        _labelType.text = info.name;
    }
    
    [m_pTableview reloadData];
}

- (void)RemoveAllView
{
    NSInteger iCount = [m_pListViews count];
    for (NSInteger i = 0; i < iCount; i++)
    {
        [m_pListViews[i] removeFromSuperview];
    }
}

- (void)ClickBtnItem:(id)sender
{
    UIControl *myview = (UIControl*)sender;
    NSInteger iIndex = myview.tag;
    BorrowCertifyInfo *info = m_pArrItems[m_CurSelType];
    CertifyBaseInfo *baseinfo = info.arrItems[iIndex];
    
    if (baseinfo.type == 6)
    {
        m_pCurInfo = baseinfo;
        ViewController_ApplyInfo * applyInfo = (ViewController_ApplyInfo *)[self.storyboard instantiateViewControllerWithIdentifier:@"ApplyInfo"];
        applyInfo.info = baseinfo;
        [self.navigationController pushViewController:applyInfo animated:YES];
//        ViewController_BorrowApplyForm * applyForm = [[ViewController_BorrowApplyForm alloc]init];
//        applyForm.info = baseinfo;
//        [self.navigationController pushViewController:applyForm animated:YES];
    }
/*    else if (baseinfo.uid == 0)
    {
        ViewController_BorrowDetail* pBorrow = (ViewController_BorrowDetail*)[self.storyboard instantiateViewControllerWithIdentifier:@"borrowDetail"];
        pBorrow.productID = info.uid;
        [self.navigationController pushViewController:pBorrow animated:YES];
    }*/
    else
    {
        ViewController_IdentityCard* pIndentity = (ViewController_IdentityCard*)[self.storyboard instantiateViewControllerWithIdentifier:@"pushIndentity"];
        pIndentity.info = baseinfo;
        [self.navigationController pushViewController:pIndentity animated:YES];
    }
}
- (IBAction)ClickBtnBorrow:(id)sender {
    
    if ([UserInfo GetUserInfo].certifyinfo.depositstatus == 0 || [UserInfo GetUserInfo].certifyinfo.namestatus == 0)
    {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"请先完成会员认证" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.delegate = self;
        [alertView show];
        UIViewController* pRecharge = [self.storyboard    instantiateViewControllerWithIdentifier:@"certifyMember"];
        [self.navigationController pushViewController:pRecharge animated:YES];

    }
    else if (![UserInfo GetUserInfo].certifyinfo.baseinfostatis)
    {
        UIViewController * userInfo_PersonCertify = [self.storyboard instantiateViewControllerWithIdentifier:@"User_Info_More"];
        [self.navigationController pushViewController:userInfo_PersonCertify animated:YES];
    }
    else
    {
        if (canBorrow) {
            ViewController_BorrowDetail* pBorrow = [self.storyboard instantiateViewControllerWithIdentifier:@"borrowDetail"];
            BorrowCertifyInfo *info = m_pArrItems[m_CurSelType];
            pBorrow.productID = info.uid;
            [self.navigationController pushViewController:pBorrow animated:YES];
        }
        else
        {
            [MyIndicatorView showIndicatiorViewWith:@"请先确认申请认证的审核状态" inView:self.view];
            
        }

    }
    
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
//{
//    UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"certifyMember"];
//    [self.navigationController pushViewController:pRecharge animated:YES];
//}
@end
