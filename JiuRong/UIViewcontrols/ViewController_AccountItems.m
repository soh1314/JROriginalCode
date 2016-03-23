//
//  ViewController_AccountItems.m
//  JiuRong
//
//  Created by iMac on 15/12/11.
//  Copyright © 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_AccountItems.h"
#import "CollectionViewCell_AccountItem.h"
#import "Public.h"
#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import "ViewController_TenderDetial.h"

@interface ViewController_AccountItems () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIView *m_pEmptyView;
    NSMutableArray *m_listPersonBorrowInfo;
    NSInteger m_iCurPage;
}
@end

@implementation ViewController_AccountItems

static NSString * const reuseIdentifier = @"cellAccountitem";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //cellAccountitem
    CGRect colframe = self.collectionviewMain.frame;
    colframe.size.width = self.view.frame.size.width;
    self.collectionviewMain.frame = colframe ;
    [self.collectionviewMain registerClass:[CollectionViewCell_AccountItem class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionviewMain.backgroundColor = [UIColor whiteColor];
    self.collectionviewMain.delegate = self;
    self.collectionviewMain.dataSource = self;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    _btnDetail.clipsToBounds = YES;
    _btnDetail.layer.cornerRadius = 5;
    [self InitInfo];
    
    [self setupRefresh];
    
    m_iCurPage = 1;
    
    m_listPersonBorrowInfo = [[NSMutableArray alloc] init];
    
    [self GetData:m_iCurPage];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width, 30);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClickBtnLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)InitInfo
{
    [self.navigationItem setTitle:@"理财账单"];
    
    _labelNO.text = self.payBackBaseInfo.no;
    _labelTitle.text = self.payBackBaseInfo.title;
    switch (self.payBackBaseInfo.status)
    {
        case 0:
            _labelStatus.text = @"审核中";
            break;
        case -1:
            _labelStatus.text = @"审核不通过";
            break;
        case -2:
            _labelStatus.text = @"借款不通过";
            break;
        case -3:
            _labelStatus.text = @"放款不通过";
            break;
        case -4:
            _labelStatus.text = @"流标";
            break;
        case -100:
            _labelStatus.text = @"审核中";
            break;
        case -5:
            _labelStatus.text = @"撤销";
            break;
        case 3:
            _labelStatus.text = @"待放款";
            break;
        case 4:
            _labelStatus.text = @"还款中";
            break;
        case 5:
            _labelStatus.text = @"已还款";
            break;
        case 1:
            _labelStatus.text = @"提前借款";
            break;
        case 2:
            _labelStatus.text = @"筹款中";
            break;
        default:
            _labelStatus.text = @"未知错误";
            break;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ClickBtnDetail:(id)sender {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRProjectDetial:self.payBackBaseInfo.ID success:^(NSInteger iStatus, BorrowInfo *info, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            ViewController_TenderDetial* pTender = [self.storyboard instantiateViewControllerWithIdentifier:@"pushBorrowNormal"];
            pTender.info = info;
            [self.navigationController pushViewController:pTender animated:YES];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    
    NSInteger iCount = [m_listPersonBorrowInfo count];
    if (iCount == 0)
    {
        [self ShowEmptyView:YES];
    }
    else
    {
        [self ShowEmptyView:NO];
    }
    [self ShowEmptyView:NO];
    return iCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell_AccountItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    NSMutableDictionary *info = [m_listPersonBorrowInfo objectAtIndex:indexPath.row];
    //
//    [cell UpdateInfo:info.title money:info.money status:info.status];
    NSString *time1 = [info objectForKey:@"repayment_time"];
    NSString *time2 = [info objectForKey:@"real_repayment_time"];
    NSInteger iMoney = [[info objectForKey:@"income_amounts"] integerValue];
    NSString * KMoney = [info objectForKey:@"income_amounts"];
    NSInteger iStatus = [[info objectForKey:@"status"] integerValue];
    NSString *mark;
    if (iStatus == -2 || iStatus == -3 || iStatus == -4 || iStatus == -6) {
        mark = @"逾期";
    }
    else
    {
        mark = @"未逾期";
    }
    
//    [cell UpdateInfo:time1 money:iMoney status:iStatus mark:mark timereally:time2];
    [cell JRUpdateInfo:time1 money:KMoney status:iStatus mark:mark timereally:time2];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cellAccountHead" forIndexPath:indexPath];
        
        reusableview = headerView;
    }
    
    return reusableview;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)GetData:(NSInteger)iPageIndex
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetAccountItems:[UserInfo GetUserInfo].uid bid:[NSString stringWithFormat:@"%lu",self.payBackBaseInfo.ID] curpage:iPageIndex pagesize:18 success:^(NSInteger iStatus, NSMutableArray *arrItems, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        
        if (iStatus == 1)
        {
            if ([arrItems count] > 0)
            {
                [m_listPersonBorrowInfo addObjectsFromArray:arrItems];
            }
            [self.collectionviewMain reloadData];
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

//开始刷新自定义方法
- (void)setupRefresh
{
    self.collectionviewMain.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        
        [self.collectionviewMain.header endRefreshing];
    }];
    
    // 上拉刷新
    self.collectionviewMain.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        m_iCurPage++;
        [self GetData:m_iCurPage];
        
        [self.collectionviewMain.footer endRefreshing];
    }];
    
}

- (void)ShowEmptyView:(BOOL)bShow
{
    if (bShow)
    {
        if (!m_pEmptyView)
        {
            m_pEmptyView = [[UIView alloc] initWithFrame:self.collectionviewMain.bounds];
            m_pEmptyView.backgroundColor = RGBCOLOR(243, 243, 243);
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.collectionviewMain.bounds];
            imageview.image = [UIImage imageNamed:@"无记录.png"];
            imageview.contentMode = UIViewContentModeCenter;
            
            [m_pEmptyView addSubview:imageview];
        }
        
        [self.collectionviewMain addSubview:m_pEmptyView];
    }
    else
    {
        if (m_pEmptyView)
        {
            [m_pEmptyView removeFromSuperview];
        }
    }
}

@end
