//
//  ViewController_Upgrate.m
//  JiuRong
//
//  Created by iMac on 15/9/9.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Upgrate.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController_Upgrate ()
{
    NSString *m_strUpgrateURL;
    NSMutableArray *m_listDescription;
}
@end

@implementation ViewController_Upgrate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _btnCancel.layer.cornerRadius = 5.0f;
    _btnCommit.layer.cornerRadius = 5.0f;
    
//    m_listDescription = [[NSMutableArray alloc] init];
//    [m_listDescription addObject:@"1、我是一个兵"];
//    [m_listDescription addObject:@"2、你是老百姓"];
//    [m_listDescription addObject:@"3、锄禾日当午"];
//    [m_listDescription addObject:@"4、汗滴禾下土"];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self UpdateLocalVersion];
    
    [self GetInitData];

    [self InitUIWithText:m_listDescription];
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

- (void)InitUIWithText:(NSMutableArray*)list
{
    NSInteger iCount = [list count];
    if (iCount <= 0)
    {
        return;
    }
    
    for (NSInteger i = 0; i < iCount; i++)
    {
        NSString *text = list[i];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 45*(i+1)+12, self.view.bounds.size.width, 21)];
        label.text = text;
        [self.viewIntroduction addSubview:label];
    }
    
}

- (void)GetInitData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetVersionUpgrateInfo:^(NSInteger iStatus, NSString *version, NSString *url, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            _labelNew.text = [NSString stringWithFormat:@"V%@",version];
            m_strUpgrateURL = url;
            NSLog(@"%@",m_strUpgrateURL);
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        _labelNew.text = @"获取失败";
        _btnCommit.enabled = NO;
    }];
    _labelNew.text = @"v1.8";
}

- (void)UpdateLocalVersion
{
    NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    _labelOld.text = [NSString stringWithFormat:@"V%@",localVersion];
}

- (IBAction)ClickBtnUpgrate:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/ying-ba-jin-rong/id1084612253?mt=8"]];
}

- (IBAction)ClickBtnCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
