//
//  LYViewButtons.m
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "LYViewButtons.h"
#import "Public.h"


@implementation LYViewButtons

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)CreateLYViewButtons
{
    LYViewButtons *view = [[[NSBundle mainBundle] loadNibNamed:@"LYViewButtons" owner:self options:nil] lastObject];
    return [view init];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self SetupUI];
    }
    
    return self;
}

- (void)SetupUI
{
    m_iCurSelButton = -1;
    _delegate = nil;
    
    m_colorNormal = RGBCOLOR(155, 0, 155);
    m_colorSelected = RGBCOLOR(255, 0, 255);
  
}

- (IBAction)ClickBtnBorrower:(id)sender
{
    [self ActionButton:0];
}

- (IBAction)ClickBtnRepayment:(id)sender
{
    [self ActionButton:1];
}

- (IBAction)ClickBtnRecharge:(id)sender
{
    [self ActionButton:2];
}

- (IBAction)ClickBtnProRepayment:(id)sender
{
    [self ActionButton:3];
}

- (void)ActionButton:(NSInteger)iIndex
{
 //   if (m_iCurSelButton != iIndex)
    {
        if (_delegate)
        {
            [_delegate DidSelectedButton:m_iCurSelButton newIndex:iIndex];
        }
        m_iCurSelButton = iIndex;
    }
/*
    _btnBorrower.selected = iIndex==0?YES:NO;
    _btnRepayment.selected = iIndex==1?YES:NO;
    _btnRecharge.selected = iIndex==2?YES:NO;
    _btnProRepayment.selected = iIndex==3?YES:NO;
    
    _labelBorrower.textColor = iIndex==0?m_colorNormal:m_colorSelected;
    _labelRepayment.textColor = iIndex==1?m_colorNormal:m_colorSelected;
    _labelRecharge.textColor = iIndex==2?m_colorNormal:m_colorSelected;
    _labelProRepayment.textColor = iIndex==3?m_colorNormal:m_colorSelected;
 */
}
@end
