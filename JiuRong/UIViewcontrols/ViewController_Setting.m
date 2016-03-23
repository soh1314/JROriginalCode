//
//  ViewController_Setting.m
//  JiuRong
//
//  Created by iMac on 15/10/20.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Setting.h"
#import "ViewController_Webview.h"

@interface ViewController_Setting ()

@end

@implementation ViewController_Setting

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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

- (IBAction)ClickBtnAbout:(id)sender
{
    [self performSegueWithIdentifier:@"pushAbout" sender:self];
}

- (IBAction)ClickBtnPhone:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"拨打400-002-0149" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打",nil];
    [alter show];
}

- (IBAction)ClickBtnUpgrate:(id)sender {
    [self performSegueWithIdentifier:@"pushUpgrate" sender:self];
}

- (IBAction)ClickBtnCompany:(id)sender {
    
    ViewController_Webview *webviewMain = [[ViewController_Webview alloc] init];
    webviewMain.webviewtitle = @"公司介绍";
    webviewMain.url = @"http://www.9rjr.com/front/home/aboutUs?id=-1004";
    [self.navigationController pushViewController:webviewMain animated:YES];
}

- (IBAction)ClickBtnSafeInfo:(id)sender {
    ViewController_Webview *webviewMain = [[ViewController_Webview alloc] init];
    webviewMain.webviewtitle = @"安全保障";
    webviewMain.url = @"http://www.9rjr.com/front/principal/principalGuaranteeHome";
    [self.navigationController pushViewController:webviewMain animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString *strPhoneURL = [NSString stringWithFormat:@"tel://%@",@"4000020149"];
        BOOL bOK = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strPhoneURL]];
        NSLog(@"%d",bOK);
    }
    
}

@end
