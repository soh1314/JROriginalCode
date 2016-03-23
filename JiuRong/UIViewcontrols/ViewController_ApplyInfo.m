//
//  ViewController_ApplyInfo.m
//  JiuRong
//
//  Created by iMac on 15/9/23.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_ApplyInfo.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import "UserInfo.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "BorrowCertifyInfo.h"
#import "PopViewLikeQQView.h"

@interface ViewController_ApplyInfo () <UITextFieldDelegate,UIAlertViewDelegate>
{
    NSMutableArray *m_arrayTextfile;
}
@property (nonatomic,strong)UIButton * commitBtn;
@end

@implementation ViewController_ApplyInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    _scrollviewMain.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3.0*1.5);
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    _commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.scrollviewMain.frame)-50, self.view.frame.size.width-40,45)];
    [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    _commitBtn.clipsToBounds = YES;
    _commitBtn.layer.cornerRadius = 10;
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.backgroundColor = [UIColor colorWithRed:94/255.0 green:176/255.0 blue:229/255.0 alpha:1];
    [_commitBtn addTarget:self action:@selector(commitAcition:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];
    m_arrayTextfile = [[NSMutableArray alloc] init];
    [m_arrayTextfile addObject:_textfileMyQQ];
    [m_arrayTextfile addObject:_textfileMyWX];
    [m_arrayTextfile addObject:_textfileMySchool];
    [m_arrayTextfile addObject:_textfileMyCollege];
    [m_arrayTextfile addObject:_textfileMySpecial];
    [m_arrayTextfile addObject:_textfileMyClass];
    [m_arrayTextfile addObject:_textfileMyClassID];
    [m_arrayTextfile addObject:_textfileMyTeacher];
    [m_arrayTextfile addObject:_textfileMyTeacherPhone];
    [m_arrayTextfile addObject:_textfileMyAcademic];
    [m_arrayTextfile addObject:_ttfGrade];
    [m_arrayTextfile addObject:_textfileMyAddress];
    [m_arrayTextfile addObject:_textfileFatherName];
    [m_arrayTextfile addObject:_textfileFatherPhone];
    [m_arrayTextfile addObject:_textfileFatherQQ];
    [m_arrayTextfile addObject:_textfileFatherWX];
    [m_arrayTextfile addObject:_textfileFatherWorkPlace];
    [m_arrayTextfile addObject:_textfileFatherAddress];
    [m_arrayTextfile addObject:_textfileMotherName];
    [m_arrayTextfile addObject:_textfileMotherPhone];
    [m_arrayTextfile addObject:_textfileMotherQQ];
    [m_arrayTextfile addObject:_textfileMotherWX];
    [m_arrayTextfile addObject:_textfileMotherWorkPlace];
    [m_arrayTextfile addObject:_textfileMotherAddress];
    [m_arrayTextfile addObject:_textfileAccount];
    [m_arrayTextfile addObject:_textfilePWD];
    [m_arrayTextfile addObject:_textfileSchoolURL];
    [m_arrayTextfile addObject:_textfileMainAccount];
    [m_arrayTextfile addObject:_textfileMainPWD];
    [m_arrayTextfile addObject:_textfileGetMode];
    [m_arrayTextfile addObject:_textfilePhonePWD];
    [m_arrayTextfile addObject:_textfileGreencardNO];
    [m_arrayTextfile addObject:_textfileSuggest];
   
    
    NSInteger iCount = [m_arrayTextfile count];
    for (NSInteger i = 0; i < iCount; i++)
    {
        UITextField *tmp = m_arrayTextfile[i];
        tmp.delegate = self;
    }
    
    _btnCommit.layer.cornerRadius = 5.0f;
    
    CGRect rc = _btnCommit.frame;
    _scrollviewMain.contentSize = CGSizeMake(self.view.bounds.size.width, rc.origin.y+48 );
    
    if (_info.status == 0)
    {
//        _viewSuggest.hidden = YES;
    }
    else
    {
//        [MyIndicatorView showIndicatiorViewWith:@"正在审核中" inView:self.view];
        _textfileSuggest.enabled = NO;
        _scrollviewMain.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _btnCommit.hidden = YES;
//        [_commitBtn setTitle:@"当前资料正在审核" forState:UIControlStateNormal];
        _commitBtn.hidden = YES;
        _commitBtn.enabled = NO;
        [self GetData];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%@",textField);
//    textfilePhonePWD;
//    textfileGreencardNO
//    textfileSuggest;
    if (textField == _textfilePhonePWD ||
        textField == _textfileGreencardNO ||
        textField == _textfileSuggest) {
        [UIView animateWithDuration:0.5 animations:^{
            _scrollviewMain.contentOffset = CGPointMake(0, _scrollviewMain.contentSize.height -250 );
        }];
       
    }
}
- (void)keyboardFrameChange:(NSNotification *)noti
{
    NSLog(@"%@",noti);
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.returnKeyType == UIReturnKeyNext)
    {
        UITextField *temp = [self GetNextTextFile:textField];
        [temp becomeFirstResponder];
    }
    
    return YES;
}

- (UITextField*)GetNextTextFile:(UITextField*)textfile
{
    NSInteger iCount = [m_arrayTextfile count];
    for (NSInteger i = 0; i < iCount; i++)
    {
        if (m_arrayTextfile[i] == textfile)
        {
            return m_arrayTextfile[i+1];
        }
    }
    
    return nil;
}

- (IBAction)HideKeyboard:(id)sender {
    NSInteger iCount = [m_arrayTextfile count];
    for (NSInteger i = 0; i < iCount; i++)
    {
        UITextField *tmp = m_arrayTextfile[i];
        [tmp resignFirstResponder];
    }
}
- (IBAction)ClickBtnCommit:(id)sender
{
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[UserInfo GetUserInfo].uid forKey:@"id"];
    [parameters setObject:@"173" forKey:@"OPT"];
    [parameters setObject:@"11" forKey:@"auditItemId"];
    [parameters setObject:_textfileMyQQ.text forKey:@"qqNo"];
    [parameters setObject:_textfileMyWX.text forKey:@"wxNo"];
    [parameters setObject:_textfileMySchool.text forKey:@"school"];
    [parameters setObject:_textfileMyCollege.text forKey:@"depart"];
    [parameters setObject:_textfileMySpecial.text forKey:@"professional"];
    [parameters setObject:_textfileMyClass.text forKey:@"className"];
    [parameters setObject:_textfileMyClassID.text forKey:@"no"];
    [parameters setObject:_textfileMyTeacher.text forKey:@"instructor"];
    [parameters setObject:_textfileMyTeacherPhone.text forKey:@"instructorPhone"];
    [parameters setObject:_textfileMyAcademic.text forKey:@"education"];
    [parameters setObject:_textfileMyAddress.text forKey:@"address"];
    
    [parameters setObject:_textfileFatherName.text forKey:@"fName"];
    [parameters setObject:_textfileFatherPhone.text forKey:@"fPhone"];
    [parameters setObject:_textfileFatherQQ.text forKey:@"fQQNo"];
    [parameters setObject:_textfileFatherWX.text forKey:@"fWxNo"];
    [parameters setObject:_textfileFatherWorkPlace.text forKey:@"fWorkName"];
    [parameters setObject:_textfileFatherAddress.text forKey:@"fAddress"];
    [parameters setObject:_textfileMotherName.text forKey:@"mName"];
    [parameters setObject:_textfileMotherPhone.text forKey:@"mPhone"];
    [parameters setObject:_textfileMotherQQ.text forKey:@"mQQNo"];
    [parameters setObject:_textfileMotherWX.text forKey:@"mWxNo"];
    [parameters setObject:_textfileMotherWorkPlace.text forKey:@"mWorkName"];
    [parameters setObject:_textfileMotherAddress.text forKey:@"mAddress"];
    
    [parameters setObject:_textfileAccount.text forKey:@"xxUserNo"];
    [parameters setObject:_textfilePWD.text forKey:@"xxUserPwd"];
    [parameters setObject:_textfileSchoolURL.text forKey:@"schoolWWW"];
    [parameters setObject:_textfileMainAccount.text forKey:@"schoolNetUserNo"];
    [parameters setObject:_textfileMainPWD.text forKey:@"schoolNetUserPwd"];
    [parameters setObject:_textfileGetMode.text forKey:@"accessChannel"];
    
    [parameters setObject:_textfilePhonePWD.text forKey:@"mobile_password"];
    [parameters setObject:_textfileGreencardNO.text forKey:@"card_no"];
    
    [parameters setObject:_textfileSuggest.text forKey:@"suggestion"];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRApplyInfoCommit:parameters success:^(NSInteger iStatus, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"提交完成" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
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

- (void)GetData
{
    NSInteger iCount = [m_arrayTextfile count];
    for (NSInteger i = 0; i < iCount; i++)
    {
        UITextField *tmp = m_arrayTextfile[i];
        tmp.enabled = NO;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetApplyInfo:[UserInfo GetUserInfo].uid auditItemId:[NSString stringWithFormat:@"%ld",_info.uid] mark:_info.mark success:^(NSInteger iStatus, NSMutableDictionary *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            NSMutableDictionary *dicInfo = [info objectForKey:@"loanInfo"];
            _textfileMyQQ.text = [dicInfo objectForKey:@"qqNo"];
            _textfileMyWX.text = [dicInfo objectForKey:@"wxNo"];
            _textfileMySchool.text = [dicInfo objectForKey:@"school"];
            _textfileMyCollege.text = [dicInfo objectForKey:@"depart"];
            _textfileMySpecial.text = [dicInfo objectForKey:@"professional"];
            _textfileMyClass.text = [dicInfo objectForKey:@"className"];
            _textfileMyClassID.text = [dicInfo objectForKey:@"no"];
            _textfileMyTeacher.text = [dicInfo objectForKey:@"instructor"];
            _textfileMyTeacherPhone.text = [dicInfo objectForKey:@"instructorPhone"];
            _textfileMyAcademic.text = [dicInfo objectForKey:@"education"];
            _textfileMyAddress.text = [dicInfo objectForKey:@"address"];
            _ttfGrade.text = [dicInfo objectForKey:@"grade"];
            
            _textfileFatherName.text = [dicInfo objectForKey:@"fName"];
            _textfileFatherPhone.text = [dicInfo objectForKey:@"fPhone"];
            _textfileFatherQQ.text = [dicInfo objectForKey:@"fQQNo"];
            _textfileFatherWX.text = [dicInfo objectForKey:@"fWxNo"];
            _textfileFatherWorkPlace.text = [dicInfo objectForKey:@"fWorkName"];
            _textfileFatherAddress.text = [dicInfo objectForKey:@"fAddress"];
            _textfileMotherName.text = [dicInfo objectForKey:@"mName"];
            _textfileMotherPhone.text = [dicInfo objectForKey:@"mPhone"];
            _textfileMotherQQ.text = [dicInfo objectForKey:@"mQQNo"];
            _textfileMotherWX.text = [dicInfo objectForKey:@"mWxNo"];
            _textfileMotherWorkPlace.text = [dicInfo objectForKey:@"mWorkName"];
            _textfileMotherAddress.text = [dicInfo objectForKey:@"mAddress"];
            
            _textfileAccount.text = [dicInfo objectForKey:@"xxUserNo"];
            _textfilePWD.text = [dicInfo objectForKey:@"xxUserPwd"];
            _textfileSchoolURL.text = [dicInfo objectForKey:@"schoolWWW"];
            _textfileMainAccount.text = [dicInfo objectForKey:@"schoolNetUserNo"];
            _textfileMainPWD.text = [dicInfo objectForKey:@"schoolNetUserPwd"];
            _textfileGetMode.text = [dicInfo objectForKey:@"accessChannel"];
            
            _textfileSuggest.text = [info objectForKey:@"suggestion"];
            
            _textfilePhonePWD.text = [info objectForKey:@"mobile_password"];
            _textfileGreencardNO.text = [info objectForKey:@"card_no"];
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            alter.delegate = self;
            [alter show];
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (void)commitAcition:(id)sender
{
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[UserInfo GetUserInfo].uid forKey:@"id"];
    [parameters setObject:@"173" forKey:@"OPT"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)_info.uid] forKey:@"auditItemId"];
    [parameters setObject:_textfileMyQQ.text forKey:@"qqNo"];
    [parameters setObject:_textfileMyWX.text forKey:@"wxNo"];
    [parameters setObject:_textfileMySchool.text forKey:@"school"];
    [parameters setObject:_textfileMyCollege.text forKey:@"depart"];
    [parameters setObject:_textfileMySpecial.text forKey:@"professional"];
    [parameters setObject:_textfileMyClass.text forKey:@"className"];
    [parameters setObject:_textfileMyClassID.text forKey:@"no"];
    [parameters setObject:_textfileMyTeacher.text forKey:@"instructor"];
    [parameters setObject:_textfileMyTeacherPhone.text forKey:@"instructorPhone"];
    [parameters setObject:_textfileMyAcademic.text forKey:@"education"];
    [parameters setObject:_textfileMyAddress.text forKey:@"address"];
    [parameters setObject:_ttfGrade.text forKey:@"grade"];
    
    [parameters setObject:_textfileFatherName.text forKey:@"fName"];
    [parameters setObject:_textfileFatherPhone.text forKey:@"fPhone"];
    [parameters setObject:_textfileFatherQQ.text forKey:@"fQQNo"];
    [parameters setObject:_textfileFatherWX.text forKey:@"fWxNo"];
    [parameters setObject:_textfileFatherWorkPlace.text forKey:@"fWorkName"];
    [parameters setObject:_textfileFatherAddress.text forKey:@"fAddress"];
    [parameters setObject:_textfileMotherName.text forKey:@"mName"];
    [parameters setObject:_textfileMotherPhone.text forKey:@"mPhone"];
    [parameters setObject:_textfileMotherQQ.text forKey:@"mQQNo"];
    [parameters setObject:_textfileMotherWX.text forKey:@"mWxNo"];
    [parameters setObject:_textfileMotherWorkPlace.text forKey:@"mWorkName"];
    [parameters setObject:_textfileMotherAddress.text forKey:@"mAddress"];
    
    [parameters setObject:_textfileAccount.text forKey:@"xxUserNo"];
    [parameters setObject:_textfilePWD.text forKey:@"xxUserPwd"];
    [parameters setObject:_textfileSchoolURL.text forKey:@"schoolWWW"];
    [parameters setObject:_textfileMainAccount.text forKey:@"schoolNetUserNo"];
    [parameters setObject:_textfileMainPWD.text forKey:@"schoolNetUserPwd"];
    [parameters setObject:_textfileGetMode.text forKey:@"accessChannel"];
    
    [parameters setObject:_textfilePhonePWD.text forKey:@"mobile_password"];
    [parameters setObject:_textfileGreencardNO.text forKey:@"card_no"];
    
    [parameters setObject:_textfileSuggest.text forKey:@"suggestion"];
    NSArray * needTextFile_Array = @[_textfileMyQQ,_textfileMyWX,_textfileMySchool,_textfileMyCollege,_textfileMySpecial,_textfileMyClass,_textfileMyClassID,_textfileMyTeacher,_textfileMyTeacherPhone,_textfileMyAcademic,_ttfGrade,_textfileFatherName,_textfileFatherPhone,_textfileFatherWorkPlace,_textfileFatherAddress,_textfileMotherName,_textfileMotherPhone,_textfileMotherWorkPlace,_textfileMotherAddress,_textfileMotherAddress,_textfilePWD,_textfilePhonePWD,_textfileGreencardNO];
    for (int i = 0 ; i < needTextFile_Array.count; i++) {
        UITextField * ttf = nil;
        ttf = needTextFile_Array[i];
        if (ttf.text.length == 0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"请输入所有的必填项再提交" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            [ttf becomeFirstResponder];
            return;
        }
    }
    if ([Public isValidateMobile:_textfileMyTeacherPhone.text])
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"辅导员手机格式不对" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
        
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRApplyInfoCommit:parameters success:^(NSInteger iStatus, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"提交完成" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            alter.tag = 10000;
            [alter show];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (IBAction)AcademicChoose:(id)sender {
    CGRect rect = self.textfileMyAcademic.bounds;
    CGRect rect3 = [self.textfileMyAcademic convertRect:rect toView:self.view];
    CGRect rect2;
    if (rect3.origin.y > self.view.bounds.size.height/2.0) {
         rect2 = CGRectMake(CGRectGetMinX(rect3), CGRectGetMinY(rect3)-200, rect3.size.width, 200);
    }
    else
    {
         rect2 = CGRectMake(CGRectGetMinX(rect3), CGRectGetMaxY(rect3), rect3.size.width, 200);
    }
   
    NSArray * academicTitle = @[@"小学",@"初中",@"高中",@"专科",@"本科",@"硕士",@"博士"];
    [PopViewLikeQQView configCustomPopViewWithFrame:rect2 imagesArr:nil dataSourceArr:academicTitle anchorPoint:CGPointMake(0, 0) seletedRowForIndex:^(NSInteger index) {
        self.textfileMyAcademic.text = academicTitle[index];
    } animation:YES timeForCome:0.5 timeForGo:0.5];
}

- (IBAction)gradeChoose:(id)sender {
    CGRect rect = self.ttfGrade.bounds;
    CGRect rect3 = [self.ttfGrade convertRect:rect toView:self.view];
    CGRect rect2;
    if (rect3.origin.y > self.view.bounds.size.height/2.0) {
        rect2 = CGRectMake(CGRectGetMinX(rect3), CGRectGetMinY(rect3)-150, rect3.size.width, 150);
    }
    else
    {
        rect2 = CGRectMake(CGRectGetMinX(rect3), CGRectGetMaxY(rect3), rect3.size.width, 150);
    }
    
    NSArray * academicTitle = @[@"大一/研一/博一",@"大二/研二/博二",@"大三/研三/博三",@"大四/研四/博四",@"大五/研五/博五"];
    [PopViewLikeQQView configCustomPopViewWithFrame:rect2 imagesArr:nil dataSourceArr:academicTitle anchorPoint:CGPointMake(0, 0) seletedRowForIndex:^(NSInteger index) {
        self.ttfGrade.text = academicTitle[index];
    } animation:YES timeForCome:0.5 timeForGo:0.5];
}
- (IBAction)getChannelChoose:(id)sender {
   
        CGRect rect = self.textfileGetMode.bounds;
        CGRect rect3 = [self.textfileGetMode convertRect:rect toView:self.view];
        CGRect rect2;
        if (rect3.origin.y > self.view.bounds.size.height/2.0) {
            rect2 = CGRectMake(CGRectGetMinX(rect3), CGRectGetMinY(rect3)-60, rect3.size.width, 60);
        }
        else
        {
            rect2 = CGRectMake(CGRectGetMinX(rect3), CGRectGetMaxY(rect3), rect3.size.width, 60);
        }
        
        NSArray * academicTitle = @[@"久融金融官网",@"其他"];
        [PopViewLikeQQView configCustomPopViewWithFrame:rect2 imagesArr:nil dataSourceArr:academicTitle anchorPoint:CGPointMake(0, 0) seletedRowForIndex:^(NSInteger index) {
            self.textfileGetMode.text = academicTitle[index];
        } animation:YES timeForCome:0.5 timeForGo:0.5];
 }
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
