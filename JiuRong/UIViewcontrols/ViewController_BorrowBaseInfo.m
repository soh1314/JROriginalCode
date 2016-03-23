//
//  ViewController_BorrowBaseInfo.m
//  JiuRong
//
//  Created by iMac on 15/9/6.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_BorrowBaseInfo.h"

@interface ViewController_BorrowBaseInfo () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *m_pTableviewType;
    NSMutableArray *m_listTypes;
    bool m_bShowTypes;
}

@end

@implementation ViewController_BorrowBaseInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self SetupList];
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

- (void)SetupList
{
    m_listTypes = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",nil];
    
    CGRect sz = _viewType.frame;
    sz.origin.y += sz.size.height;
    sz.size.height = 1;
    
    m_pTableviewType = [[UITableView alloc] initWithFrame:sz];
    m_pTableviewType.delegate = self;
    m_pTableviewType.dataSource = self;
    m_pTableviewType.hidden = YES;
    m_pTableviewType.backgroundColor = [UIColor blackColor];
    m_bShowTypes = NO;
    
    [self.view addSubview:m_pTableviewType];
}

- (IBAction)ClickViewType:(id)sender
{
    if (m_bShowTypes)
    {
        [self HideTablbeView:m_pTableviewType height:100];
    }
    else
    {
        [self ShowTableView:m_pTableviewType height:100];
    }
    
}

- (void)ShowTableView:(UITableView*)tableview height:(CGFloat)fHeight
{
    CGRect rc = tableview.frame;
    rc.size.height += fHeight;
    tableview.hidden = NO;
    
    [UIView animateWithDuration:0.5f animations:^{
        tableview.frame = rc;
    } completion:^(BOOL finished) {
        m_bShowTypes = YES;
        [_btnType setTitle:@"收缩" forState:UIControlStateNormal];
    }];
}

- (void)HideTablbeView:(UITableView*)tableview height:(CGFloat)fHeight
{
    CGRect rc = tableview.frame;
    rc.size.height -= fHeight;
    
    [UIView animateWithDuration:0.5f animations:^{
        tableview.frame = rc;
    } completion:^(BOOL finished) {
        tableview.hidden = YES;
        m_bShowTypes = NO;
        [_btnType setTitle:@"弹出" forState:UIControlStateNormal];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_listTypes count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = m_listTypes[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:8.0f];
    cell.accessoryType  = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
@end
