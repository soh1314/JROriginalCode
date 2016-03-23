//
//  ViewController_RetPassword.h
//  JiuRong
//
//  Created by iMac on 15/9/9.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_RetPassword : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textfilePassword1;
@property (weak, nonatomic) IBOutlet UITextField *textfilePassword2;

@property (nonatomic ,retain) NSString *phone;
@property (nonatomic ,retain) NSString *authcode;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;

- (IBAction)ClickBtnCommit:(id)sender;
- (IBAction)HideKeyboard:(id)sender;
@end
