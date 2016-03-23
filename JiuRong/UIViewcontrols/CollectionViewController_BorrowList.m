//
//  CollectionViewController_BorrowList.m
//  JiuRong
//
//  Created by iMac on 15/9/7.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "CollectionViewController_BorrowList.h"
#import "Public.h"
#import "CollectionViewCell_Borrow2.h"
#import "PaybackInfo.h"
#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import "ViewController_OrderBaseInfo.h"
#import "MyIndicatorView.h"
@interface CollectionViewController_BorrowList () <PersonBorrowInfoDelegate>
{
    NSMutableArray *m_listPersonBorrowInfo;
    NSInteger m_iCurPage;
    
    PaybackBaseInfo *m_pCurBaseInfo;
    
    UIView *m_pEmptyView;
}
@end

@implementation CollectionViewController_BorrowList

static NSString * const reuseIdentifier2 = @"colltecionBorrow2";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes

    [self.collectionView registerClass:[CollectionViewCell_Borrow2 class] forCellWithReuseIdentifier:reuseIdentifier2];
    
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"pushPaybackSchedule"])
    {
        ViewController_OrderBaseInfo *viewcontrol = (ViewController_OrderBaseInfo*)segue.destinationViewController;
        viewcontrol.billID = [NSString stringWithFormat:@"%ld",m_pCurBaseInfo.ID];
    }
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
    return iCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PaybackBaseInfo *info = [m_listPersonBorrowInfo objectAtIndex:indexPath.row];
    
    CollectionViewCell_Borrow2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2 forIndexPath:indexPath];
    [cell UpdateInfo:info];
    
    return cell;
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.bounds.size.width, 90);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 0, 0);
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
    [JiuRongHttp JRGetPaybackList:[UserInfo GetUserInfo].uid curpage:iPageIndex pagesize:18 success:^(NSInteger iStatus, PaybackInfo *info, NSString *strErrorCode) {
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PaybackBaseInfo *info = [m_listPersonBorrowInfo objectAtIndex:indexPath.row];
    if (info.status == 2 || info.status == 4 || info.status == 5)
    {
        m_pCurBaseInfo = info;
        ViewController_OrderBaseInfo * baseInfo = (ViewController_OrderBaseInfo *)[self.storyboard instantiateViewControllerWithIdentifier:@"OrderBaseInfo"];
        baseInfo.payBackinfo = m_pCurBaseInfo;
        [self.navigationController pushViewController:baseInfo animated:YES];
//        [self performSegueWithIdentifier:@"pushPaybackSchedule" sender:self];
    }
}

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
@end
