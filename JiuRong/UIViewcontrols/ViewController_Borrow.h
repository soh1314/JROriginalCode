//
//  ViewController_Borrow.h
//  JiuRong
//
//  Created by iMac on 15/9/22.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_Borrow : UIViewController
- (IBAction)UpdateStatus:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelType;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewArrow;
@property (weak, nonatomic) IBOutlet UIControl *viewType;
@property (weak, nonatomic) IBOutlet UILabel *verifyLabel;
@property (weak, nonatomic) IBOutlet UIView *verifyLabelView;

- (IBAction)ClickBtnDetail:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBorrow;
- (IBAction)ClickBtnBorrow:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;

@property (nonatomic, assign) NSInteger viewStatus;
@end
