//
//  ViewController_RebindMobile.h
//  JiuRong
//
//  Created by iMac on 15/9/18.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_RebindMobile : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textfileOldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textfileNewPhone;
@property (weak, nonatomic) IBOutlet UITextField *textfileAuthcode;
@property (weak, nonatomic) IBOutlet UIButton *btnAuthcode;

@property (weak, nonatomic) IBOutlet UITextField *textfileCode;
@property (weak, nonatomic) IBOutlet UILabel *labelCode;
- (IBAction)ClickBtnCommit:(id)sender;
- (IBAction)HideKeyboard:(id)sender;
- (IBAction)ClickBtnAuthcode:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
@end
