//
//  ViewController_Login.h
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_Login : UIViewController <UIAlertViewDelegate>
- (IBAction)ClickBtnLogin:(id)sender;

- (IBAction)ClickBtnRegister:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UITextField *textfileUser;
@property (weak, nonatomic) IBOutlet UITextField *textfilePassword;
- (IBAction)HideKeyboard:(id)sender;
- (IBAction)ClickBtnAutoLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@end
