//
//  ViewController_LockEmail.h
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_LockEmail : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textfileEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;

- (IBAction)HideKeyboard:(id)sender;
- (IBAction)ClickBtnCommit:(id)sender;
@end
