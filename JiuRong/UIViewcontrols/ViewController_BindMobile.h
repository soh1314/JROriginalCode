//
//  ViewController_BindMobile.h
//  JiuRong
//
//  Created by iMac on 15/9/18.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_BindMobile : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textfilePhone;
@property (weak, nonatomic) IBOutlet UITextField *textfileAuthcode;
@property (weak, nonatomic) IBOutlet UIButton *btnAuthcode;

- (IBAction)ClickBtnCommit:(id)sender;
- (IBAction)HideKeyboard:(id)sender;
- (IBAction)ClickBtnAuthcode:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
@end
