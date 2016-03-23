//
//  ViewController_CertifyMember.h
//  JiuRong
//
//  Created by iMac on 15/9/7.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_CertifyMember : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageviewName;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewPhone;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewTrust;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewBaseInfo;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;
@property (weak, nonatomic) IBOutlet UILabel *labelTrust;
@property (weak, nonatomic) IBOutlet UILabel *labelBaseInfo;
@property (weak, nonatomic) IBOutlet UIImageView *phoneTrustImage;
- (IBAction)ClickToName:(id)sender;
- (IBAction)ClickToPhone:(id)sender;
- (IBAction)ClickToEmail:(id)sender;
- (IBAction)ClickToTrust:(id)sender;
- (IBAction)ClickToBaseInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewNameArrow;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewTrustArrow;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewBaseinfoArrow;
@end
