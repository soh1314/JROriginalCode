//
//  ViewController_BorrowProjectDetail.m
//  JiuRong
//
//  Created by iMac on 15/9/22.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_BorrowProjectDetail.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserInfo.h"
#import "ViewController_BorrowDetail.h"

@interface ViewController_BorrowProjectDetail ()

@end

@implementation ViewController_BorrowProjectDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

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

- (void)ClickBtnCommit
{
    if ([UserInfo GetUserInfo].certifyinfo.depositstatus == 0 || [UserInfo GetUserInfo].certifyinfo.namestatus == 0)
    {
        UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"certifyMember"];
        [self.navigationController pushViewController:pRecharge animated:YES];
    }
    else
    {
        [self performSegueWithIdentifier:@"pushBorrowDetail" sender:self];
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"pushBorrowDetail"])
    {
        ViewController_BorrowDetail *viewcontrol = (ViewController_BorrowDetail*)segue.destinationViewController;
        viewcontrol.productID = _pid;
    }
}


- (UIView*)CreateViewWithTitle:(NSString*)title content:(NSString*)content rect:(CGRect)rc
{
    UIView *tmpview = [[UIView alloc] initWithFrame:rc];
    tmpview.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 80, 21)];
    labelTitle.textColor = RGBCOLOR(165, 165, 165);
    labelTitle.text = title;
    [tmpview addSubview:labelTitle];
    

    UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(100, 12, self.view.bounds.size.width-120, rc.size.height-24)];
    labelContent.font = [UIFont systemFontOfSize:12.0f];
    labelContent.text = content;
    labelContent.numberOfLines = 0;
    [tmpview addSubview:labelContent];
    
    return tmpview;
}

- (void)GetData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetProductDetailInfoByID:[UserInfo GetUserInfo].uid pid:_pid success:^(NSInteger iStatus, NSMutableDictionary *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        
        if (iStatus == 1)
        {
            NSInteger iHeight = 0;
            NSString *productFeature = [info objectForKey:@"productFeatures"];
//            productFeature = [productFeature stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
            NSInteger iCount =  [[productFeature componentsSeparatedByString:@"\r\n"] count];
            NSInteger iMax = MAX(45, iCount*21);
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"产品特点" content:productFeature rect:CGRectMake(0, 0, self.view.bounds.size.width, iMax)]];
            iHeight += (iMax+1);
            
            NSString *suitsCrowd = [info objectForKey:@"suitsCrowd"];
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"适合人群" content:suitsCrowd rect:CGRectMake(0, iHeight, self.view.bounds.size.width, 45)]];
            iHeight += 46;
            
            NSString *limitRange = [info objectForKey:@"limitRange"];
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"额度范围" content:limitRange rect:CGRectMake(0, iHeight, self.view.bounds.size.width, 45)]];
            iHeight += 46;
            
            NSString *loanRate = [info objectForKey:@"loanRate"];
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"贷款利率" content:loanRate rect:CGRectMake(0, iHeight, self.view.bounds.size.width, 45)]];
            iHeight += 46;
            
            NSString *limit = [info objectForKey:@"periodDay"];
            limit = [limit stringByAppendingString:@"(天)\r\n"];
            limit = [limit stringByAppendingString:[info objectForKey:@"periodMonth"]];
            limit = [limit stringByAppendingString:@"(月)\r\n"];
            limit = [limit stringByAppendingString:[info objectForKey:@"periodYear"]];
            limit = [limit stringByAppendingString:@"(年)"];
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"贷款期限" content:limit rect:CGRectMake(0, iHeight, self.view.bounds.size.width, 108)]];
            iHeight += 109;
            
            NSString *tenderTime = [info objectForKey:@"tenderTime"];
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"投标时间" content:tenderTime rect:CGRectMake(0, iHeight, self.view.bounds.size.width, 45)]];
            iHeight += 46;
            
            NSInteger iDays = [[info objectForKey:@"uditTime"] integerValue];
            NSString *uditTime = [NSString stringWithFormat:@"%ld天",iDays];
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"审核时间" content:uditTime rect:CGRectMake(0, iHeight, self.view.bounds.size.width, 45)]];
            iHeight += 46;
            
            NSMutableArray *arrPayMode = [info objectForKey:@"repayWay"];
            NSString *payMode = @"";
            iCount = [arrPayMode count];
            iMax = MAX(60, iCount*21);
            for (NSInteger i = 0; i < iCount; i++)
            {
                NSString *name = [arrPayMode[i] objectForKey:@"name"];
                payMode = [payMode stringByAppendingString:name];
                if (i != iCount-1)
                {
                    payMode = [payMode stringByAppendingString:@"\r\n"];
                }
            }
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"还款方式" content:payMode rect:CGRectMake(0, iHeight, self.view.bounds.size.width, iMax)]];
            iHeight += (iMax+1);
            
            NSString *poundage = [info objectForKey:@"poundage"];
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"手续费" content:poundage rect:CGRectMake(0, iHeight, self.view.bounds.size.width, 126)]];
            iHeight += 127;
            
            NSString *applyconditons = [info objectForKey:@"applyconditons"];
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"申请条件" content:applyconditons rect:CGRectMake(0, iHeight, self.view.bounds.size.width, 45)]];
            iHeight += 46;
            
            NSMutableArray *arrMust = [info objectForKey:@"reviewMaterial"];
            NSString *must = @"";
            iCount = [arrMust count];
            iMax = MAX(60, iCount*21);
            for (NSInteger i = 0; i < iCount; i++)
            {
                NSMutableDictionary *dicItem = [arrMust[i] objectForKey:@"auditItem"];
                NSString *name = [dicItem objectForKey:@"name"];
                must = [must stringByAppendingString:name];
                if (i != iCount-1)
                {
                    must = [must stringByAppendingString:@"\r\n"];
                }
                
            }
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"必审资料" content:must rect:CGRectMake(0, iHeight, self.view.bounds.size.width, iMax)]];
            iHeight += (iMax+1);
            
            NSMutableArray *arrNeed = [info objectForKey:@"selectAuditId"];
            NSString *need = @"";
            iCount = [arrNeed count];
            iMax = MAX(60, iCount*21);
            for (NSInteger i = 0; i < iCount; i++)
            {
                NSMutableDictionary *dicNeed = [arrNeed[i] objectForKey:@"auditItem"];
                NSString *name = [dicNeed objectForKey:@"name"];
                need = [need stringByAppendingString:name];
                if (i != iCount-1)
                {
                    need = [need stringByAppendingString:@"\r\n"];
                }
                
            }
            [_scrollviewMain addSubview:[self CreateViewWithTitle:@"选审资料" content:need rect:CGRectMake(0, iHeight, self.view.bounds.size.width, iMax)]];
            iHeight += (iMax+1);
            
            UIButton *btnCommit = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-45, self.view.bounds.size.width, 45)];
            btnCommit.backgroundColor = RGBCOLOR(54, 167, 220);
            if ([UserInfo GetUserInfo].certifyinfo.depositstatus == 0 || [UserInfo GetUserInfo].certifyinfo.namestatus == 0)
            {
                [btnCommit setTitle:@"会员认证" forState:UIControlStateNormal];
            }
            else
            {
                [btnCommit setTitle:@"申请借款" forState:UIControlStateNormal];
            }
            [btnCommit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnCommit addTarget:self action:@selector(ClickBtnCommit) forControlEvents:UIControlEventTouchUpInside];
            btnCommit.layer.cornerRadius = 5.0f;
            [self.view addSubview:btnCommit];
            
            _scrollviewMain.backgroundColor = RGBCOLOR(243, 243, 243);
            _scrollviewMain.contentSize = CGSizeMake(self.view.bounds.size.width, iHeight);
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
