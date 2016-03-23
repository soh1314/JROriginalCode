//
//  ViewController_UserInfo2.h
//  JiuRong
//
//  Created by iMac on 15/10/17.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_UserInfo2 : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelIndetifyCard;
@property (weak, nonatomic) IBOutlet UIButton *btnSex;
@property (weak, nonatomic) IBOutlet UIButton *btnAge;
@property (weak, nonatomic) IBOutlet UIButton *btnProvance;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UIButton *btnLevel;
@property (weak, nonatomic) IBOutlet UIButton *btnMarryStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnCarStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnHouseStatus;
@property (weak, nonatomic) IBOutlet UITextField *Ttf_Age;


@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
- (IBAction)ClickBtnCommit:(id)sender;
- (IBAction)ClickBtnSex:(id)sender;
- (IBAction)ClickBtnAge:(id)sender;
- (IBAction)ClickBtnProvance:(id)sender;
- (IBAction)ClickBtnCity:(id)sender;
- (IBAction)ClickBtnLevel:(id)sender;
- (IBAction)ClickBtnMarry:(id)sender;
- (IBAction)ClickBtnCar:(id)sender;
- (IBAction)ClickBtnHouse:(id)sender;
@property (weak, nonatomic) IBOutlet UIControl *viewAge;
@property (weak, nonatomic) IBOutlet UIControl *viewAddress;
@property (weak, nonatomic) IBOutlet UIControl *viewLevel;
@property (weak, nonatomic) IBOutlet UIControl *viewSex;
@property (weak, nonatomic) IBOutlet UIControl *viewMarry;
@property (weak, nonatomic) IBOutlet UIControl *viewCar;
@property (weak, nonatomic) IBOutlet UIControl *viewHouse;

@end
