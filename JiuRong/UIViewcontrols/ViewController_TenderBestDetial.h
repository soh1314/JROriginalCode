//
//  ViewController_TenderBestDetial.h
//  JiuRong
//
//  Created by iMac on 15/9/11.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "BorrowInfo.h"

@interface ViewController_TenderBestDetial : UIViewController <UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollviewMain;

@property (weak, nonatomic) IBOutlet UIView *viewList;
@property (weak, nonatomic) IBOutlet UIView *viewSafeCertify;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;

@property (nonatomic, retain) BorrowInfo *info;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelBorrowAmont;
@property (weak, nonatomic) IBOutlet UILabel *labelRate;
@property (weak, nonatomic) IBOutlet UILabel *labelLimit;
@property (weak, nonatomic) IBOutlet UILabel *labelPaybackMode;
@property (weak, nonatomic) IBOutlet UILabel *labelBorrowDescrips;
@property (weak, nonatomic) IBOutlet UILabel *labelRemainTime;
@property (weak, nonatomic) IBOutlet UILabel *labelBorrowStatus;
@property (weak, nonatomic) IBOutlet UILabel *labelMinMoney;
@property (weak, nonatomic) IBOutlet UITextField *textfileMoney;
@property (weak, nonatomic) IBOutlet UIProgressView *progressCollect;
@property (weak, nonatomic) IBOutlet UILabel *labelCollect;
- (IBAction)HideKeyboard:(id)sender;
- (IBAction)HideView:(id)sender;
- (IBAction)ClickBtnSure:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelRemainTime2;
@property (weak, nonatomic) IBOutlet UILabel *labelRemainTime3;

@end
