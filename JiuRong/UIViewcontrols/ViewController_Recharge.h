//
//  ViewController_Recharge.h
//  JiuRong
//
//  Created by iMac on 15/9/16.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_Recharge : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfileName;
@property (weak, nonatomic) IBOutlet UITextField *textfileAccount;
@property (weak, nonatomic) IBOutlet UITextField *textfileMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelRealMoney;
- (IBAction)HideKeyboard:(id)sender;

- (IBAction)ClickBtnCommit:(id)sender;
@end
