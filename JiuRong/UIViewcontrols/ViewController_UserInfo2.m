//
//  ViewController_UserInfo2.m
//  JiuRong
//
//  Created by iMac on 15/10/17.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_UserInfo2.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <CJSONDeserializer.h>
#import "ViewController_CertifyName.h"
@interface ViewController_UserInfo2 () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *m_pTableviewAge;
    UITableView *m_pTableviewProvance;
    UITableView *m_pTableviewCity;
    UITableView *m_pTableviewLevel;
    UITableView *m_pTableviewSex;
    UITableView *m_pTableviewMarry;
    UITableView *m_pTableviewCar;
    UITableView *m_pTableviewHouse;
    
    NSInteger m_iCurAge;
    NSInteger m_iCurProvance;
    NSInteger m_iCurCity;
    NSInteger m_iCurLevel;
    NSInteger m_iCurSex;
    NSInteger m_iCurMarry;
    NSInteger m_iCurCar;
    NSInteger m_iCurHouse;
    
    NSMutableArray *m_arrAge;
    NSMutableArray *m_arrProvance;
    NSMutableArray *m_arrCity;
    NSMutableArray *m_arrLevel;
    NSMutableArray *m_arrSex;
    NSMutableArray *m_arrMarry;
    NSMutableArray *m_arrCar;
    NSMutableArray *m_arrHouse;
    
    NSInteger m_iSelLevel;
    NSInteger m_iSelCity;
    NSInteger m_iSelSex;
    NSInteger m_iSelMarry;
    NSInteger m_iSelCar;
    NSInteger m_iSelHouse;
}
@end

@implementation ViewController_UserInfo2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![UserInfo GetUserInfo].certifyinfo.name ) {
//        ViewController_CertifyName * certyfyName = [self.storyboard instantiateViewControllerWithIdentifier:@"CertifyName"];
//        [self.navigationController pushViewController:certyfyName animated:YES];
//        return;
    }
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _btnAge.layer.borderColor = [RGBCOLOR(249, 249, 249) CGColor];
    _btnAge.layer.borderWidth = 1.0f;
    _btnCarStatus.layer.borderColor = [RGBCOLOR(249, 249, 249) CGColor];
    _btnCarStatus.layer.borderWidth = 1.0f;
    _btnCity.layer.borderColor = [RGBCOLOR(249, 249, 249) CGColor];
    _btnCity.layer.borderWidth = 1.0f;
    _btnCommit.layer.borderColor = [RGBCOLOR(249, 249, 249) CGColor];
    _btnCommit.layer.borderWidth = 1.0f;
    _btnCommit.layer.cornerRadius = 5.0f;
    _btnHouseStatus.layer.borderColor = [RGBCOLOR(249, 249, 249) CGColor];
    _btnHouseStatus.layer.borderWidth = 1.0f;
    _btnLevel.layer.borderColor = [RGBCOLOR(249, 249, 249) CGColor];
    _btnLevel.layer.borderWidth = 1.0f;
    _btnMarryStatus.layer.borderColor = [RGBCOLOR(249, 249, 249) CGColor];
    _btnMarryStatus.layer.borderWidth = 1.0f;
    _btnProvance.layer.borderColor = [RGBCOLOR(249, 249, 249) CGColor];
    _btnProvance.layer.borderWidth = 1.0f;
    _btnSex.layer.borderColor = [RGBCOLOR(249, 249, 249) CGColor];
    _btnSex.layer.borderWidth = 1.0f;
    
    m_pTableviewAge = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewAge.frame.origin.y + _viewAge.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewAge.dataSource = self;
    m_pTableviewAge.delegate = self;
    m_pTableviewAge.backgroundColor = [UIColor blackColor];
    m_pTableviewAge.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_pTableviewProvance = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewAddress.frame.origin.y + _viewAddress.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewProvance.dataSource = self;
    m_pTableviewProvance.delegate = self;
    m_pTableviewProvance.backgroundColor = [UIColor blackColor];
    m_pTableviewProvance.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_pTableviewCity = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewAddress.frame.origin.y + _viewAddress.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewCity.dataSource = self;
    m_pTableviewCity.delegate = self;
    m_pTableviewCity.backgroundColor = [UIColor blackColor];
    m_pTableviewCity.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_pTableviewLevel = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewLevel.frame.origin.y + _viewLevel.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewLevel.dataSource = self;
    m_pTableviewLevel.delegate = self;
    m_pTableviewLevel.backgroundColor = [UIColor blackColor];
    m_pTableviewLevel.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_pTableviewSex = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewSex.frame.origin.y + _viewSex.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewSex.dataSource = self;
    m_pTableviewSex.delegate = self;
    m_pTableviewSex.backgroundColor = [UIColor blackColor];
    m_pTableviewSex.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_pTableviewMarry = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewMarry.frame.origin.y + _viewMarry.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewMarry.dataSource = self;
    m_pTableviewMarry.delegate = self;
    m_pTableviewMarry.backgroundColor = [UIColor blackColor];
    m_pTableviewMarry.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_pTableviewCar = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewCar.frame.origin.y + _viewCar.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewCar.dataSource = self;
    m_pTableviewCar.delegate = self;
    m_pTableviewCar.backgroundColor = [UIColor blackColor];
    m_pTableviewCar.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_pTableviewHouse = [[UITableView alloc] initWithFrame:CGRectMake(0, _viewHouse.frame.origin.y + _viewHouse.frame.size.height, self.view.bounds.size.width, 0)];
    m_pTableviewHouse.dataSource = self;
    m_pTableviewHouse.delegate = self;
    m_pTableviewHouse.backgroundColor = [UIColor blackColor];
    m_pTableviewHouse.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    m_arrAge = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i < 100; i++)
    {
        [m_arrAge addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    [_btnAge setTitle:@"请您输入年龄" forState:UIControlStateNormal];
    
    m_arrLevel = [[NSMutableArray alloc] init];
    [m_arrLevel addObject:@"小学"];
    [m_arrLevel addObject:@"初中"];
    [m_arrLevel addObject:@"高中"];
    [m_arrLevel addObject:@"专科"];
    [m_arrLevel addObject:@"本科"];
    [_btnLevel setTitle:@"小学" forState:UIControlStateNormal];
    
    m_arrProvance = [[NSMutableArray alloc] init];
    m_arrCity = [[NSMutableArray alloc] init];
    
    m_arrSex = [[NSMutableArray alloc] init];
    [m_arrSex addObject:@"男"];
    [m_arrSex addObject:@"女"];
    [_btnSex setTitle:@"男" forState:UIControlStateNormal];
    
    m_arrMarry = [[NSMutableArray alloc] init];
    [m_arrMarry addObject:@"未婚"];
    [m_arrMarry addObject:@"已婚未育"];
    [m_arrMarry addObject:@"已婚已育"];
    [m_arrMarry addObject:@"离异"];
    [_btnMarryStatus setTitle:@"未婚" forState:UIControlStateNormal];
    
    m_arrCar = [[NSMutableArray alloc] init];
    [m_arrCar addObject:@"无车"];
    [m_arrCar addObject:@"按揭购车"];
    [m_arrCar addObject:@"全款购车"];
    [_btnCarStatus setTitle:@"无车" forState:UIControlStateNormal];
    
    m_arrHouse = [[NSMutableArray alloc] init];
    [m_arrHouse addObject:@"无房"];
    [m_arrHouse addObject:@"按揭购房"];
    [m_arrHouse addObject:@"全款购房"];
    [_btnHouseStatus setTitle:@"无房" forState:UIControlStateNormal];
    
    _labelName.text = [Public userNameToAsterisk:[UserInfo GetUserInfo].certifyinfo.name];
    _labelIndetifyCard.text = [Public idCardToAsterisk:[UserInfo GetUserInfo].certifyinfo.idcard];
    
    [self.view addSubview:m_pTableviewAge];
    [self.view addSubview:m_pTableviewLevel];
    [self.view addSubview:m_pTableviewProvance];
    [self.view addSubview:m_pTableviewCity];
    [self.view addSubview:m_pTableviewSex];
    [self.view addSubview:m_pTableviewMarry];
    [self.view addSubview:m_pTableviewCar];
    [self.view addSubview:m_pTableviewHouse];
    
    [self GetCitys];
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

- (IBAction)ClickBtnCommit:(id)sender
{
//    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
//    [parameters setObject:[UserInfo GetUserInfo].uid forKey:@"id"];
//    if (m_iSelSex == 0)
//    {
//        [parameters setObject:@"1" forKey:@"sex"];
//    }
//    else
//    {
//        [parameters setObject:@"2" forKey:@"sex"];
//    }
//    NSInteger iValue = [[[_btnAge titleLabel] text] integerValue];
//    NSInteger age = [_Ttf_Age.text integerValue];
//    [parameters setObject:[NSString stringWithFormat:@"%ld",age] forKey:@"age"];
    
    [self debugDictionaryRequest];
//    [parameters setObject:[m_arrCity[m_iSelCity] objectForKey:@"id"] forKey:@"registedPlaceCity"];
//    [parameters setObject:[m_arrCity[m_iSelCity] objectForKey:@"province_id"] forKey:@"registedPlacePro"];
//    [parameters setObject:[NSString stringWithFormat:@"%ld",m_iSelLevel] forKey:@"higtestEdu"];
  /*
    if (m_iSelMarry == 0)
    {
        [parameters setObject:@"1" forKey:@"maritalStatus"];
    }
    else if (m_iSelMarry == 1)
    {
        [parameters setObject:@"2" forKey:@"maritalStatus"];
    }
    else if (m_iSelMarry == 2)
    {
        [parameters setObject:@"3" forKey:@"maritalStatus"];
    }
    else
    {
        [parameters setObject:@"4" forKey:@"maritalStatus"];
    }
   */
 /*
    if (m_iSelHouse == 0)
    {
        [parameters setObject:@"1" forKey:@"housrseStatus"];
    }
    else if (m_iSelHouse == 1)
    {
        [parameters setObject:@"2" forKey:@"housrseStatus"];
    }
    else
    {
        [parameters setObject:@"3" forKey:@"housrseStatus"];
    }
  */
 /*
    if (m_iSelCar == 0)
    {
        [parameters setObject:@"1" forKey:@"CarStatus"];
    }
    else if (m_iSelCar == 1)
    {
        [parameters setObject:@"2" forKey:@"CarStatus"];
    }
    else
    {
        [parameters setObject:@"3" forKey:@"CarStatus"];
    }
    */
    
//    [parameters setObject:@"24" forKey:@"OPT"];
//    NSLog(@"%@",parameters);
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
//    [JiuRongHttp JRCertifyUserInfo:parameters success:^(NSInteger iStatus, NSString *strErrorCode) {
//        [SVProgressHUD dismiss];
//        if (iStatus == 1)
//        {
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"提交成功" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
//            [alter show];
//            _btnCommit.enabled = NO;
//        }
//        else
//        {
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
//            [alter show];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
//    }];
}
- (void)debugDictionaryRequest
{
    if ([_Ttf_Age.text isEqualToString:@""]
        || !_Ttf_Age.text) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"请输入您的年龄" delegate:nil cancelButtonTitle:@"哟,我知道了" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else
    {
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[UserInfo GetUserInfo].uid forKey:@"id"];
    if (m_iSelSex == 0)
    {
        [parameters setObject:@"1" forKey:@"sex"];
    }
    else
    {
        [parameters setObject:@"2" forKey:@"sex"];
    }
    NSInteger iValue = [[[_btnAge titleLabel] text] integerValue];
    NSInteger age = [_Ttf_Age.text integerValue];
    [parameters setObject:[NSString stringWithFormat:@"%ld",age] forKey:@"age"];
        [parameters setObject:@"220100" forKey:@"registedPlaceCity"];
        [parameters setObject:@"220000" forKey:@"registedPlacePro"];
        [parameters setObject:@"1" forKey:@"higtestEdu"];
        parameters[@"maritalStatus"]=@"1";
        parameters[@"housrseStatus"]=@"1";
        parameters[@"CarStatus"]=@"1";
        parameters[@"age"]=@"15";
  
    [parameters setObject:@"24" forKey:@"OPT"];
    NSLog(@"%@",parameters);
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRCertifyUserInfo:parameters success:^(NSInteger iStatus, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"提交成功" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
            _btnCommit.enabled = NO;
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
}
- (IBAction)ClickBtnSex:(id)sender {
    if (m_iCurSex == 0)
    {
        NSInteger iCount = [m_arrSex count];
        iCount = MIN(10, iCount);
        CGRect rc = m_pTableviewSex.frame;
        rc.size.height += (iCount*30);
        m_pTableviewSex.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewSex.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurSex = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_arrSex count];
        CGRect rc = m_pTableviewSex.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewSex.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurSex = 0;
            m_pTableviewSex.hidden = YES;
        }];
    }
}

- (IBAction)ClickBtnAge:(id)sender {
    
    if (m_iCurAge == 0)
    {
        NSInteger iCount = [m_arrAge count];
        iCount = MIN(10, iCount);
        CGRect rc = m_pTableviewAge.frame;
        rc.size.height += (iCount*30);
        m_pTableviewAge.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewAge.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurAge = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_arrAge count];
        CGRect rc = m_pTableviewAge.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewAge.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurAge = 0;
            m_pTableviewAge.hidden = YES;
        }];
    }
}

- (IBAction)ClickBtnProvance:(id)sender {
    
    if (m_iCurProvance == 0)
    {
        NSInteger iCount = [m_arrProvance count];
        iCount = MIN(10, iCount);
        CGRect rc = m_pTableviewProvance.frame;
        rc.size.height += (iCount*30);
        m_pTableviewProvance.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewProvance.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurProvance = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_arrProvance count];
        CGRect rc = m_pTableviewProvance.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewProvance.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurProvance = 0;
            m_pTableviewProvance.hidden = YES;
        }];
    }
}

- (IBAction)ClickBtnCity:(id)sender {
    
    if (m_iCurCity == 0)
    {
        NSInteger iCount = [m_arrCity count];
        iCount = MIN(10, iCount);
        CGRect rc = m_pTableviewCity.frame;
        rc.size.height += (iCount*30);
        m_pTableviewCity.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewCity.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurCity = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_arrCity count];
        CGRect rc = m_pTableviewCity.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewCity.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurCity = 0;
            m_pTableviewCity.hidden = YES;
        }];
    }
}

- (IBAction)ClickBtnLevel:(id)sender {
    
    if (m_iCurLevel == 0)
    {
        NSInteger iCount = [m_arrLevel count];
        iCount = MIN(10, iCount);
        CGRect rc = m_pTableviewLevel.frame;
        rc.size.height += (iCount*30);
        m_pTableviewLevel.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewLevel.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurLevel = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_arrLevel count];
        CGRect rc = m_pTableviewLevel.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewLevel.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurLevel = 0;
            m_pTableviewLevel.hidden = YES;
        }];
    }
}

- (IBAction)ClickBtnMarry:(id)sender {
    if (m_iCurMarry == 0)
    {
        NSInteger iCount = [m_arrMarry count];
        iCount = MIN(10, iCount);
        CGRect rc = m_pTableviewMarry.frame;
        rc.size.height += (iCount*30);
        m_pTableviewMarry.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewMarry.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurMarry = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_arrMarry count];
        CGRect rc = m_pTableviewMarry.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewMarry.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurMarry = 0;
            m_pTableviewMarry.hidden = YES;
        }];
    }
}

- (IBAction)ClickBtnCar:(id)sender {
    if (m_iCurCar == 0)
    {
        NSInteger iCount = [m_arrCar count];
        iCount = MIN(10, iCount);
        CGRect rc = m_pTableviewCar.frame;
        rc.size.height += (iCount*30);
        m_pTableviewCar.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewCar.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurCar = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_arrCar count];
        CGRect rc = m_pTableviewCar.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewCar.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurCar = 0;
            m_pTableviewCar.hidden = YES;
        }];
    }
}

- (IBAction)ClickBtnHouse:(id)sender {
    if (m_iCurHouse == 0)
    {
        NSInteger iCount = [m_arrHouse count];
        iCount = MIN(10, iCount);
        CGRect rc = m_pTableviewHouse.frame;
        rc.size.height += (iCount*30);
        m_pTableviewHouse.hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewHouse.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurHouse = 1;
        }];
    }
    else
    {
        NSInteger iCount = [m_arrHouse count];
        CGRect rc = m_pTableviewHouse.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewHouse.frame = rc;
        } completion:^(BOOL finished) {
            m_iCurHouse = 0;
            m_pTableviewHouse.hidden = YES;
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == m_pTableviewAge)
    {
        return [m_arrAge count];
    }
    
    if (tableView == m_pTableviewLevel)
    {
        return [m_arrLevel count];
    }
    
    if (tableView == m_pTableviewProvance)
    {
        return [m_arrProvance count];
    }
    
    if (tableView == m_pTableviewCity)
    {
        return [m_arrCity count];
    }
    
    if (tableView == m_pTableviewSex)
    {
        return [m_arrSex count];
    }
    
    if (tableView == m_pTableviewMarry)
    {
        return [m_arrMarry count];
    }
    
    if (tableView == m_pTableviewCar)
    {
        return [m_arrCar count];
    }
    
    if (tableView == m_pTableviewHouse)
    {
        return [m_arrHouse count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == m_pTableviewAge)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellAge"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellAge"];
        }
        cell.textLabel.text = m_arrAge[indexPath.row];
    }
    
    if (tableView == m_pTableviewLevel)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellLevel"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellLevel"];
        }
        cell.textLabel.text = m_arrLevel[indexPath.row];
    }
    
    if (tableView == m_pTableviewProvance)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellProvance"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellProvance"];
        }
        cell.textLabel.text = [m_arrProvance[indexPath.row] objectForKey:@"name"];
    }
    
    if (tableView == m_pTableviewCity)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellCity"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellCity"];
        }
        cell.textLabel.text = [m_arrCity[indexPath.row] objectForKey:@"name"];
    }
    
    if (tableView == m_pTableviewSex)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellSex"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellSex"];
        }
        cell.textLabel.text = m_arrSex[indexPath.row];
    }
    
    if (tableView == m_pTableviewMarry)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellMarry"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellMarry"];
        }
        cell.textLabel.text = m_arrMarry[indexPath.row];
    }
    
    if (tableView == m_pTableviewCar)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellCar"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellCar"];
        }
        cell.textLabel.text = m_arrCar[indexPath.row];
    }
    
    if (tableView == m_pTableviewHouse)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellHouse"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellHouse"];
        }
        cell.textLabel.text = m_arrHouse[indexPath.row];
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
    if (tableView == m_pTableviewAge)
    {
        NSInteger iCount = [m_arrAge count];
        CGRect rc = m_pTableviewAge.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewAge.frame = rc;
        } completion:^(BOOL finished) {
            m_pTableviewAge.hidden = YES;
            [_btnAge setTitle:m_arrAge[indexPath.row] forState:UIControlStateNormal];
        }];
    }
    
    if (tableView == m_pTableviewLevel)
    {
        NSInteger iCount = [m_arrLevel count];
        CGRect rc = m_pTableviewLevel.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewLevel.frame = rc;
        } completion:^(BOOL finished) {
            m_iSelLevel = indexPath.row;
            m_pTableviewLevel.hidden = YES;
            [_btnLevel setTitle:m_arrLevel[indexPath.row] forState:UIControlStateNormal];
        }];
    }
    
    if (tableView == m_pTableviewProvance)
    {
        NSInteger iCount = [m_arrProvance count];
        CGRect rc = m_pTableviewProvance.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewProvance.frame = rc;
        } completion:^(BOOL finished) {
            m_pTableviewProvance.hidden = YES;
            [_btnProvance setTitle:[m_arrProvance[indexPath.row] objectForKey:@"name"] forState:UIControlStateNormal];
            m_arrCity = [m_arrProvance[indexPath.row] objectForKey:@"citys"];
            [_btnCity setTitle:[m_arrCity[0] objectForKey:@"name"] forState:UIControlStateNormal];
            m_iSelCity = 0;
            [m_pTableviewCity reloadData];
        }];
    }
    
    if (tableView == m_pTableviewCity)
    {
        NSInteger iCount = [m_arrCity count];
        CGRect rc = m_pTableviewCity.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewCity.frame = rc;
        } completion:^(BOOL finished) {
            m_iSelCity = indexPath.row;
            m_pTableviewCity.hidden = YES;
            [_btnCity setTitle:[m_arrCity[indexPath.row] objectForKey:@"name"] forState:UIControlStateNormal];
            m_iCurCity = indexPath.row;
        }];
    }
    
    if (tableView == m_pTableviewSex)
    {
        NSInteger iCount = [m_arrSex count];
        CGRect rc = m_pTableviewSex.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewSex.frame = rc;
        } completion:^(BOOL finished) {
            m_iSelSex = indexPath.row;
            m_pTableviewSex.hidden = YES;
            [_btnSex setTitle:m_arrSex[indexPath.row] forState:UIControlStateNormal];
        }];
    }
    
    if (tableView == m_pTableviewMarry)
    {
        NSInteger iCount = [m_arrMarry count];
        CGRect rc = m_pTableviewMarry.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewMarry.frame = rc;
        } completion:^(BOOL finished) {
            m_iSelMarry = indexPath.row;
            m_pTableviewMarry.hidden = YES;
            [_btnMarryStatus setTitle:m_arrMarry[indexPath.row] forState:UIControlStateNormal];
        }];
    }
    
    if (tableView == m_pTableviewCar)
    {
        NSInteger iCount = [m_arrCar count];
        CGRect rc = m_pTableviewCar.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewCar.frame = rc;
        } completion:^(BOOL finished) {
            m_iSelCar = indexPath.row;
            m_pTableviewCar.hidden = YES;
            [_btnCarStatus setTitle:m_arrCar[indexPath.row] forState:UIControlStateNormal];
        }];
    }
    
    if (tableView == m_pTableviewHouse)
    {
        NSInteger iCount = [m_arrHouse count];
        CGRect rc = m_pTableviewHouse.frame;
        rc.size.height = 0;
        
        [UIView animateWithDuration:0.5f animations:^{
            m_pTableviewHouse.frame = rc;
        } completion:^(BOOL finished) {
            m_iSelHouse = indexPath.row;
            m_pTableviewHouse.hidden = YES;
            [_btnHouseStatus setTitle:m_arrHouse[indexPath.row] forState:UIControlStateNormal];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}

- (void)GetCitys
{
    NSString *strfile = [[NSBundle mainBundle] pathForResource:@"citys.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:strfile];
    NSMutableArray *pData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
    
    m_arrProvance = [[NSMutableArray alloc] initWithArray:pData];
    
    [_btnProvance setTitle:[m_arrProvance[0] objectForKey:@"name"] forState:UIControlStateNormal];
    m_arrCity = [m_arrProvance[0] objectForKey:@"citys"];
    [_btnCity setTitle:[m_arrCity[0] objectForKey:@"name"] forState:UIControlStateNormal];
    m_iSelCity = 0;
}

@end
