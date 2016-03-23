//
//  ViewController_TenderDetial.h
//  JiuRong
//
//  Created by iMac on 15/9/10.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BorrowInfo.h"

@interface ViewController_TenderDetial : UIViewController <UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate>
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
@property (weak, nonatomic) IBOutlet UILabel *labelCriditScore;
@property (weak, nonatomic) IBOutlet UIView *viewCriditLevel;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelSex;
@property (weak, nonatomic) IBOutlet UILabel *labelAge;
@property (weak, nonatomic) IBOutlet UILabel *labelIDNum;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelEdution;
@property (weak, nonatomic) IBOutlet UILabel *labelMarry;
@property (weak, nonatomic) IBOutlet UILabel *labelHouse;
@property (weak, nonatomic) IBOutlet UILabel *labelCar;
@property (weak, nonatomic) IBOutlet UILabel *labelPurse;
@property (weak, nonatomic) IBOutlet UILabel *labelReview;
@property (weak, nonatomic) IBOutlet UILabel *labelRecord1;
@property (weak, nonatomic) IBOutlet UILabel *labelRecord2;
@property (weak, nonatomic) IBOutlet UILabel *labelRecord3;
@property (weak, nonatomic) IBOutlet UILabel *labelRecord4;
@property (weak, nonatomic) IBOutlet UILabel *labelRegisterTime;
@property (weak, nonatomic) IBOutlet UILabel *labelTime1;
@property (weak, nonatomic) IBOutlet UILabel *labelTime2;
@property (weak, nonatomic) IBOutlet UILabel *labelTime3;
@property (weak, nonatomic) IBOutlet UILabel *labelTime4;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney1;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney2;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney3;
- (IBAction)HideKeyboard:(id)sender;
- (IBAction)HideView:(id)sender;
- (IBAction)ClickBtnSure:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *creditLevel;

@end
