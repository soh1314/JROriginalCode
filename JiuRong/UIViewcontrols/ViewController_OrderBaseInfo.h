//
//  ViewController_OrderBaseInfo.h
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaybackInfo.h"
@interface ViewController_OrderBaseInfo : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollviewMain;

@property (weak, nonatomic) IBOutlet UIView *viewMask;
@property (weak, nonatomic) IBOutlet UILabel *paybackTimeLimit;
@property (weak, nonatomic) IBOutlet UILabel *paybackTimelimitLabel;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelBorrowID;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelRate;
@property (weak, nonatomic) IBOutlet UILabel *labelLimit;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelPaybacked;
@property (weak, nonatomic) IBOutlet UILabel *labelPaybacking;
@property (nonatomic,strong) PaybackBaseInfo * payBackinfo;
@property (nonatomic, retain) NSString* billID;
@end
