//
//  ViewController_CertifyInfo.h
//  JiuRong
//
//  Created by iMac on 15/9/23.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_CertifyInfo : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelSubject;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UILabel *labelLimittime;
@property (weak, nonatomic) IBOutlet UILabel *labelScore;
@property (weak, nonatomic) IBOutlet UILabel *labelEndtime;
@property (weak, nonatomic) IBOutlet UILabel *labelApplytime;
@property (weak, nonatomic) IBOutlet UILabel *labelCommittime;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelSuggest;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;

- (IBAction)commitAction:(id)sender;

@property (nonatomic, retain) NSString* mark;
@property (nonatomic ,retain) NSString *subject;
@end
