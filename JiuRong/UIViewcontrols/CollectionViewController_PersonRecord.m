//
//  CollectionViewController_PersonRecord.m
//  JiuRong
//
//  Created by iMac on 15/9/23.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "CollectionViewController_PersonRecord.h"
#import "CollectionViewCell_PersonRecord.h"
#import "Public.h"
#import "PaybackInfo.h"
#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import "ViewController_AccountItems.h"
#import "MyIndicatorView.h"
@interface CollectionViewController_PersonRecord ()
{
    UIView *m_pEmptyView;
    NSMutableArray *m_listPersonBorrowInfo;
    NSInteger m_iCurPage;
    PaybackBaseInfo *m_pCurInfo;
}
@end

@implementation CollectionViewController_PersonRecord

static NSString * const reuseIdentifier = @"cellRecord";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionViewCell_PersonRecord class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self setupRefresh];
    
    m_iCurPage = 1;
    
    m_listPersonBorrowInfo = [[NSMutableArray alloc] init];
    
    [self GetData:m_iCurPage];
    
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
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"accountitem"])
//    {
//        ViewController_AccountItems *viewcontrol = (ViewController_AccountItems*)segue.destinationViewController;
//        viewcontrol.bid = [NSString stringWithFormat:@"%ld",m_pCurInfo.ID];
//        viewcontrol.mytitle = m_pCurInfo.title;
//        viewcontrol.status = m_pCurInfo.status;
//    }
//}


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
    
    return iCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell_PersonRecord *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    PaybackBaseInfo *info = [m_listPersonBorrowInfo objectAtIndex:indexPath.row];
    //
//    [cell UpdateInfo:info.title money:info.money status:info.status];
    [cell JRUpdateInfo:info.title money:info.Kmoney status:info.status];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cellHead" forIndexPath:indexPath];
        
        reusableview = headerView;
    }
    
    return reusableview;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PaybackBaseInfo *info = [m_listPersonBorrowInfo objectAtIndex:indexPath.row];
    m_pCurInfo = info;
    ViewController_AccountItems * accountItems = (ViewController_AccountItems *)[self.storyboard instantiateViewControllerWithIdentifier:@"AccountItems"];
    accountItems.payBackBaseInfo = info;
    [self.navigationController pushViewController:accountItems animated:YES];
//    [self performSegueWithIdentifier:@"accountitem" sender:self];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void)ShowEmptyView:(BOOL)bShow
{
    if (bShow)
    {
        if (!m_pEmptyView)
        {
            m_pEmptyView = [[UIView alloc] initWithFrame:self.view.bounds];
            m_pEmptyView.backgroundColor = RGBCOLOR(243, 243, 243);
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
            imageview.image = [UIImage imageNamed:@"无记录.png"];
            imageview.contentMode = UIViewContentModeCenter;
            
            [m_pEmptyView addSubview:imageview];
        }
        
        [self.view addSubview:m_pEmptyView];
    }
    else
    {
        if (m_pEmptyView)
        {
            [m_pEmptyView removeFromSuperview];
        }
    }
    
    
    
}

//开始刷新自定义方法
- (void)setupRefresh
{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        
        [self.collectionView.header endRefreshing];
    }];
    
    // 上拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        m_iCurPage++;
        [self GetData:m_iCurPage];
        
        [self.collectionView.footer endRefreshing];
    }];
    
}

- (void)GetData:(NSInteger)iPageIndex
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetPersonMoneyList:[UserInfo GetUserInfo].uid curpage:iPageIndex pagesize:18 success:^(NSInteger iStatus, PaybackInfo *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            [self UpdateInfo];
            [self.collectionView reloadData];
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

- (void)UpdateInfo
{
    [m_listPersonBorrowInfo removeAllObjects];
    
    PaybackInfo *info = [PaybackInfo GetPaybackInfo];
    NSInteger iCount = [info.dicPaybackGroup count];
    for (NSInteger i = 1; i <= iCount; i++)
    {
        PaybackGroup *group = [info.dicPaybackGroup objectForKey:[NSString stringWithFormat:@"%ld",i]];
        NSInteger iSize = [group.arrPaybackInfo count];
        for (NSInteger j = 0; j < iSize; j++)
        {
            PaybackBaseInfo *baseinfo = group.arrPaybackInfo[j];
            [m_listPersonBorrowInfo addObject:baseinfo];
        }
    }
}

@end
