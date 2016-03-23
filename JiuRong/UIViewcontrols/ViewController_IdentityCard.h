//
//  ViewController_IdentityCard.h
//  JiuRong
//
//  Created by iMac on 15/9/23.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@class CertifyBaseInfo;
@interface ViewController_IdentityCard : UIViewController <UIImagePickerControllerDelegate,UIAlertViewDelegate>
- (IBAction)ClickBtnSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
- (IBAction)ClickBtnCommit:(id)sender;
- (IBAction)ClickBtnCheck:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSelected;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *Description;
@property (weak, nonatomic) IBOutlet UITextView *info_additional;

@property (nonatomic, retain) CertifyBaseInfo *info;
@end
