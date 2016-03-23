//
//  ViewController_Register.h
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_Register : UIViewController <UITextFieldDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *recommendPersonName;

@property (weak, nonatomic) IBOutlet UITextField *textfileUser;
@property (weak, nonatomic) IBOutlet UITextField *textfilePassword1;
@property (weak, nonatomic) IBOutlet UITextField *textfilePassword2;
@property (weak, nonatomic) IBOutlet UITextField *textfileEMail;
@property (weak, nonatomic) IBOutlet UITextField *textfilePhone;
@property (weak, nonatomic) IBOutlet UITextField *textfileAuthcode;
@property (weak, nonatomic) IBOutlet UIButton *btnAuthcode;
@property (weak, nonatomic) IBOutlet UIButton *btnProtocol;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UITextField *recommendPerson;

- (IBAction)ClickBtnAuthcode:(id)sender;
- (IBAction)ClickBtnProtocol:(id)sender;
- (IBAction)ClickBtnRegister:(id)sender;
- (IBAction)ClickBtnLogin:(id)sender;
- (IBAction)ClickHideKeyboard:(id)sender;
@end
