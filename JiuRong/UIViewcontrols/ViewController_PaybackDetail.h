//
//  ViewController_PaybackDetail.h
//  JiuRong
//
//  Created by iMac on 15/10/22.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_PaybackDetail : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelBorrowID;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelRate;
@property (weak, nonatomic) IBOutlet UILabel *labelLimit;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelPaybacked;
@property (weak, nonatomic) IBOutlet UILabel *labelPaybacking;

@property (weak, nonatomic) IBOutlet UILabel *labelCurMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelCurLiXi;
@property (weak, nonatomic) IBOutlet UILabel *labelFaXi;
@property (weak, nonatomic) IBOutlet UILabel *labelCurTotalMoney;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;

- (IBAction)ClickBtnCommit:(id)sender;

@property (nonatomic, retain) NSString* bID;
@property (nonatomic, assign) NSInteger status;
@end
