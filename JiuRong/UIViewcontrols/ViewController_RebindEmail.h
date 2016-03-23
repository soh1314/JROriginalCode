//
//  ViewController_RebindEmail.h
//  JiuRong
//
//  Created by iMac on 15/10/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_RebindEmail : UIViewController
- (IBAction)HideKeyboard:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textfileOldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textfileNewEmail;
- (IBAction)ClickBtnCommit:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
@end
