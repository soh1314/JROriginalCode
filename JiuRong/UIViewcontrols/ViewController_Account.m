//
//  ViewController_Account.m
//  JiuRong
//
//  Created by iMac on 15/9/7.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Account.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserInfo.h"
#import <AFNetworking/AFNetworking.h>
#import <CJSONDeserializer.h>
#import "NSString+AttributedText.h"

@interface ViewController_Account ()
{
    CGFloat m_fCellWidth;
    CGFloat m_fCellHeight;
    CGFloat m_fMarginRow;
    CGFloat m_fMarginCol;
}
@end

@implementation ViewController_Account

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetMenuImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnMenu)];
//    self.navigationItem.rightBarButtonItem = RightButtonItem;
    
/*    UIBarButtonItem *LeftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBaseInfoImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnBaseInfo)];
    self.navigationItem.leftBarButtonItem = LeftButtonItem;
*/
    [self SetupNavigation];
    m_fCellWidth =  (_collectionviewMain.bounds.size.width-4)/3;
    m_fCellHeight = (_collectionviewMain.bounds.size.height-64-49-4)/3;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([UserInfo GetUserInfo].isLogin)
    {
//        [self getUserDataWith:[UserInfo GetUserInfo].uid] ;
        [self GetData];
    }
    else
    {
        UIViewController* pRoot = [self.storyboard instantiateViewControllerWithIdentifier:@"loginroot"];
        [self presentModalViewController:pRoot animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClickBtnMenu
{
    
}

- (void)ClickBtnBaseInfo
{
    [self performSegueWithIdentifier:@"pushBaseInfo" sender:self];
}

- (void)SetupNavigation
{
    UIControl *leftbarView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:leftbarView.bounds];
    imageview.image = [UIImage imageNamed:@"用户@2x.png"];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [leftbarView addSubview:imageview];
    [leftbarView addTarget:self action:@selector(ClickBtnBaseInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbarView];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * CellIdentifier = [NSString stringWithFormat:@"GradientCell%ld",indexPath.row];
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(m_fCellWidth, m_fCellHeight);
}
/*
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}*/
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor purpleColor];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 0)
    {
        if ([UserInfo GetUserInfo].certifyinfo.depositstatus == 0 || [UserInfo GetUserInfo].certifyinfo.namestatus == 0)
        {
            UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"certifyMember"];
            [self.navigationController pushViewController:pRecharge animated:YES];
            return NO;
        }
    }
    return YES;
}
- (void)getUserDataWith:(NSString *)uid
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:uid forKey:@"userId"];
    [parameters setObject:@"162" forKey:@"OPT"];
    [parameters setObject:@"ios" forKey:@"dataSource"];
    
    [manager POST:SERVE_PATH parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *html = operation.responseString;
         NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
         
         NSMutableDictionary *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
         NSLog(@"%@",responseObject);
         NSInteger iStatus = [[pData objectForKey:@"error"] integerValue];
         
         if (iStatus == -1)
         {
             NSInteger remainMoney = [[pData objectForKey:@"availableBalance"] integerValue];
             NSInteger otherMoney = [[pData objectForKey:@"repaymentAmount"] integerValue];
             NSInteger sumRecvMoney = [[pData objectForKey:@"sumReceiveAmount"] integerValue];
             NSInteger lastdayRecvMoney = [[pData objectForKey:@"receiveAmount"] integerValue];
             NSLog(@"%@",[responseObject objectForKey:@"msg"]);
         }
         else
         {
             NSString *strerror = [pData objectForKey:@"msg"];

         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
       
     }];

}
- (void)GetData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetPersonData:[UserInfo GetUserInfo].uid success:^(NSInteger iStatus, NSInteger money1, NSString * money2, NSString * money3, NSString * money4, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            _labelLastdayIn.text = [Public Number2String:money1];
            _labelAllMoney.text = [NSString stringWithFormat:@"%@",money2];
            _labelTotalIn.text = [NSString stringWithFormat:@"%@",money3];
            _labelTotalOut.text = [NSString stringWithFormat:@"%@",money4];
            _labelAccount.text = [NSString stringWithFormat:@"尊敬的用户:%@",[UserInfo GetUserInfo].user];
            NSString * str = [NSString stringWithFormat:@"尊敬的用户:%@",[UserInfo GetUserInfo].user];
            UIColor * golden = [UIColor colorWithRed:220.0/255.0f green:122.0/255.0f blue:58.0/255.0f alpha:1];
            _labelAccount.attributedText = [NSString QstringWith:golden Font:[UIFont fontWithName:@"FZLanTingHeiS-R-GB" size:20] range:NSMakeRange(6,str.length-6) originalString:str];
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
