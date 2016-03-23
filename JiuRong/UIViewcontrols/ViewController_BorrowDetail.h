//
//  ViewController_BorrowDetail.h
//  JiuRong
//
//  Created by iMac on 15/9/22.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_BorrowDetail : UIViewController <UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollviewMain;
@property (weak, nonatomic) IBOutlet UIButton *btnUseType;
@property (weak, nonatomic) IBOutlet UIButton *btnLimit;
@property (weak, nonatomic) IBOutlet UIButton *btnPaybackMode;
@property (weak, nonatomic) IBOutlet UIView *viewUseType;
@property (weak, nonatomic) IBOutlet UIView *viewLimit;
@property (weak, nonatomic) IBOutlet UIView *viewPaybackMode;
- (IBAction)ClickBtnUseType:(id)sender;
- (IBAction)ClickBtnLimit:(id)sender;
- (IBAction)ClickBtnPaybackMode:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textfileTitle;
@property (weak, nonatomic) IBOutlet UITextField *textfileMoney;
@property (weak, nonatomic) IBOutlet UITextView *textviewDetail;

@property (nonatomic, retain) NSString* productID;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
- (IBAction)ClickBtnUpdate:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelUseType;
@property (weak, nonatomic) IBOutlet UILabel *labelLimit;
@property (weak, nonatomic) IBOutlet UILabel *labelPaybackMode;
- (IBAction)ClickBtnCommit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textfileMinMoney;
@property (weak, nonatomic) IBOutlet UITextField *textfileRate;
- (IBAction)HideKeyboard:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelEndLimit;
@property (weak, nonatomic) IBOutlet UIControl *viewEndLimit;

- (IBAction)ClickBtnEndLimit:(id)sender;

@end
