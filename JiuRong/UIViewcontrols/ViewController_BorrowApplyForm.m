//
//  ViewController_BorrowApplyForm.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/17.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "ViewController_BorrowApplyForm.h"
#import "JiuRongHttp.h"
#import "LoanInfo.h"
#import "LoanInfoCell.h"
@interface ViewController_BorrowApplyForm ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * applyTable;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,copy)NSArray *  personInfoTitle;
@property (nonatomic,copy)NSArray *  studyInfoTitle;
@property (nonatomic,copy)NSArray *  familyInfoTitle;
@property (nonatomic,copy)NSArray *  loanInfoGroup;
@property (nonatomic,strong)LoanInfo * personLoanInfo;
@end

@implementation ViewController_BorrowApplyForm
- (id)init
{
    if (self = [super init]) {
        _personInfoTitle = @[@"QQ",@"微信",@"学校",@"院校",@"专业",@"班级",@"学号",@"辅导员",@"辅导员手机",@"学历",@"年级",@"现住地址"];
        _familyInfoTitle = @[@"父亲姓名",@"父亲手机",@"父亲QQ",@"父亲微信",@"父亲工作单位",@"父亲现住地址",@"母亲姓名",@"母亲手机",@"母亲QQ",@"母亲微信",@"母亲工作地址"];
        _studyInfoTitle = @[@"学信网用户名",@"学信网密码",@"学校官方网址",@"官网用户名",@"官网密码",@"获取渠道",@"手机服务密码",@"推荐人编号",@"备注"];

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self getApplyFormData];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)getApplyFormData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetApplyInfo:[UserInfo GetUserInfo].uid auditItemId:[NSString stringWithFormat:@"%ld",_info.uid] mark:_info.mark success:^(NSInteger iStatus, NSMutableDictionary *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            _personLoanInfo = [LoanInfo creatLoanInfoWith:info[@"loanInfo"]];
            
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
- (UITableView *)applyTable
{
    if (!_applyTable) {
        _applyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW,KScreenH-50 ) style:UITableViewStyleGrouped];
        _applyTable.delegate = self;
        _applyTable.dataSource = self;
        [_applyTable registerNib:[UINib nibWithNibName:@"LoanInfoCell" bundle:nil] forCellReuseIdentifier:@"loanInfoCell"];
    }
    return _applyTable;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.personInfoTitle.count;
    }
    else if (section == 1)
    {
        return self.familyInfoTitle.count;
    }
    else
    {
        return self.studyInfoTitle.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanInfoCell * infoCell = [tableView dequeueReusableCellWithIdentifier:@"loanInfoCell" forIndexPath:indexPath];
    
    return infoCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
