//
//  CollectionViewController_TransferList.m
//  JiuRong
//
//  Created by iMac on 15/9/7.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "CollectionViewController_TransferList.h"
#import "CollectionViewCell_Transfer.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import "TransInfo.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJRefresh/MJRefresh.h>
#import "MyIndicatorView.h"
@interface CollectionViewController_TransferList ()
{
    UIView *m_pEmptyView;
    NSMutableArray *m_pTransInfo;
    NSInteger m_iCurPage;
}
@end

@implementation CollectionViewController_TransferList

static NSString * const reuseIdentifier = @"colltecionTransfer";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionViewCell_Transfer class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self setupRefresh];
    
    m_pTransInfo = [[NSMutableArray alloc] init];
    
    m_iCurPage = 1;
    
    [self GetData:1];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    
    NSInteger iCount = [m_pTransInfo count];
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
    CollectionViewCell_Transfer *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    TransBaseInfo* info = m_pTransInfo[indexPath.row];
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

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.bounds.size.width, 45);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 0, 0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cellTrans" forIndexPath:indexPath];
        
        reusableview = headerView;
    }
    
    return reusableview;
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

- (void)GetData:(NSInteger)iPageIndex
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetTransList:[UserInfo GetUserInfo].uid curpage:iPageIndex pagesize:18 type:0 success:^(NSInteger iStatus, TransInfo *info, NSString *strErrorCode) {
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
    [m_pTransInfo removeAllObjects];
    
    TransInfo *info = [TransInfo GetTransInfo];
    NSInteger iCount = [info.dicTransGroup count];
    for (NSInteger i = 1; i <= iCount; i++)
    {
        TransGroup *group = [info.dicTransGroup objectForKey:[NSString stringWithFormat:@"%ld",i]];
        NSInteger iSize = [group.arrBaseInfo count];
        for (NSInteger j = 0; j < iSize; j++)
        {
            TransBaseInfo *baseinfo = group.arrBaseInfo[j];
            [m_pTransInfo addObject:baseinfo];
        }
    }
    if ([m_pTransInfo count] == 0)
    {
        [MyIndicatorView showIndicatiorViewWith:@"无交易记录" inView:self.view];
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

@end
