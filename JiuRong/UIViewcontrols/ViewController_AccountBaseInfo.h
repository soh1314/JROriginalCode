//
//  ViewController_AccountBaseInfo.h
//  JiuRong
//
//  Created by iMac on 15/9/7.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_AccountBaseInfo : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIView *viewCreditLevel;
@property (weak, nonatomic) IBOutlet UILabel *labelCreditScore;
@property (weak, nonatomic) IBOutlet UILabel *labelRegisterTime;
@property (weak, nonatomic) IBOutlet UILabel *labelScore;
@property (weak, nonatomic) IBOutlet UILabel *labelCreditValue;
@property (weak, nonatomic) IBOutlet UIImageView *imageCreditLevel;

@property (weak, nonatomic) IBOutlet UILabel *labelSend;
@property (weak, nonatomic) IBOutlet UILabel *labelRecv;
@property (weak, nonatomic) IBOutlet UILabel *labelTrans;
- (IBAction)ClickBtnLoginOut:(id)sender;
- (IBAction)HideKeyboard:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLoginout;
@end
