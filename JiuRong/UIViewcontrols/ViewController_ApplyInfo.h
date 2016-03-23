//
//  ViewController_ApplyInfo.h
//  JiuRong
//
//  Created by iMac on 15/9/23.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CertifyBaseInfo;
@interface ViewController_ApplyInfo : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textfileMyQQ;
@property (weak, nonatomic) IBOutlet UITextField *textfileMyWX;
@property (weak, nonatomic) IBOutlet UITextField *textfileMySchool;
@property (weak, nonatomic) IBOutlet UITextField *textfileMyCollege;
@property (weak, nonatomic) IBOutlet UITextField *textfileMySpecial;
@property (weak, nonatomic) IBOutlet UITextField *textfileMyClass;
@property (weak, nonatomic) IBOutlet UITextField *textfileMyClassID;
@property (weak, nonatomic) IBOutlet UITextField *textfileMyTeacher;
@property (weak, nonatomic) IBOutlet UITextField *textfileMyTeacherPhone;
@property (weak, nonatomic) IBOutlet UITextField *textfileMyAcademic;
@property (weak, nonatomic) IBOutlet UITextField *textfileMyAddress;
@property (weak, nonatomic) IBOutlet UITextField *textfileFatherName;
@property (weak, nonatomic) IBOutlet UITextField *textfileFatherPhone;
@property (weak, nonatomic) IBOutlet UITextField *textfileFatherQQ;
@property (weak, nonatomic) IBOutlet UITextField *textfileFatherWX;
@property (weak, nonatomic) IBOutlet UITextField *textfileFatherWorkPlace;
@property (weak, nonatomic) IBOutlet UITextField *textfileFatherAddress;
@property (weak, nonatomic) IBOutlet UITextField *textfileMotherName;
@property (weak, nonatomic) IBOutlet UITextField *textfileMotherPhone;
@property (weak, nonatomic) IBOutlet UITextField *textfileMotherQQ;
@property (weak, nonatomic) IBOutlet UITextField *textfileMotherWX;
@property (weak, nonatomic) IBOutlet UITextField *textfileMotherWorkPlace;
@property (weak, nonatomic) IBOutlet UITextField *textfileMotherAddress;
@property (weak, nonatomic) IBOutlet UITextField *textfileAccount;
@property (weak, nonatomic) IBOutlet UITextField *textfilePWD;
@property (weak, nonatomic) IBOutlet UITextField *textfileSchoolURL;
@property (weak, nonatomic) IBOutlet UITextField *textfileMainAccount;
@property (weak, nonatomic) IBOutlet UITextField *textfileMainPWD;
@property (weak, nonatomic) IBOutlet UITextField *textfileGetMode;
- (IBAction)HideKeyboard:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
- (IBAction)ClickBtnCommit:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollviewMain;
@property (weak, nonatomic) IBOutlet UIView *viewSuggest;
@property (weak, nonatomic) IBOutlet UILabel *labelSuggest;

@property (weak, nonatomic) IBOutlet UITextField *textfilePhonePWD;
@property (weak, nonatomic) IBOutlet UITextField *textfileGreencardNO;
@property (weak, nonatomic) IBOutlet UITextField *textfileSuggest;
- (IBAction)AcademicChoose:(id)sender;
- (IBAction)gradeChoose:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getChannelChoose;
- (IBAction)getChannelChoose:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *gradeChoose;

@property (weak, nonatomic) IBOutlet UITextField *ttfGrade;

@property (nonatomic, retain) CertifyBaseInfo *info;
@end
