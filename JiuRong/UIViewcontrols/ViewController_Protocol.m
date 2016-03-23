//
//  ViewController_Protocol.m
//  JiuRong
//
//  Created by iMac on 15/10/26.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Protocol.h"
#import "Public.h"
#import "JiuRongHttp.h"

@interface ViewController_Protocol () <UIWebViewDelegate>

@end

@implementation ViewController_Protocol

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"用户协议"];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _webviewMain.delegate = self;
    NSString *url = [JiuRongHttp JRGetProtocolPath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webviewMain loadRequest:request];
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

@end
