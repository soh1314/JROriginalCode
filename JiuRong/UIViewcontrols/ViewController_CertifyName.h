//
//  ViewController_CertifyName.h
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_CertifyName : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textfileName;
@property (weak, nonatomic) IBOutlet UITextField *textfileIDCard;
@property (weak, nonatomic) IBOutlet UITextField *textfileAuthcode;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthcode;
- (IBAction)HideKeyboard:(id)sender;
- (IBAction)ClickBtnCommit:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
@end
