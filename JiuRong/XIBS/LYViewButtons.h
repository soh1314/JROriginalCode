//
//  LYViewButtons.h
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYViewButtonsDelegate <NSObject>

- (void)DidSelectedButton:(NSInteger)iOldIndex newIndex:(NSInteger)iNewIndex;

@end

@interface LYViewButtons : UIView
{
    NSInteger m_iCurSelButton;
    UIColor *m_colorNormal;
    UIColor *m_colorSelected;
}

+ (id)CreateLYViewButtons;

@property (nonatomic) id<LYViewButtonsDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *btnBorrower;
@property (weak, nonatomic) IBOutlet UIButton *btnRepayment;
@property (weak, nonatomic) IBOutlet UIButton *btnRecharge;
@property (weak, nonatomic) IBOutlet UIButton *btnProRepayment;
@property (weak, nonatomic) IBOutlet UILabel *labelBorrower;
@property (weak, nonatomic) IBOutlet UILabel *labelRepayment;
@property (weak, nonatomic) IBOutlet UILabel *labelRecharge;
@property (weak, nonatomic) IBOutlet UILabel *labelProRepayment;
- (IBAction)ClickBtnBorrower:(id)sender;
- (IBAction)ClickBtnRepayment:(id)sender;
- (IBAction)ClickBtnRecharge:(id)sender;
- (IBAction)ClickBtnProRepayment:(id)sender;
@end

