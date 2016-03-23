//
//  ViewController_WithdrawCash.h
//  JiuRong
//
//  Created by iMac on 15/9/18.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_WithdrawCash : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelRemainMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelUsefulMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelRealMoney;
- (IBAction)ClickBtnCommit:(id)sender;
@end
