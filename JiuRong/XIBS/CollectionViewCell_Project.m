//
//  CollectionViewCell_Project.m
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "CollectionViewCell_Project.h"
#import "BorrowInfo.h"
#import "Public.h"


@implementation CollectionViewCell_Project

- (void)awakeFromNib {
            CGRect rc;
            rc.origin.x = self.bounds.size.width - 65;
            rc.size.width = 50;
            rc.origin.y = 15;
            rc.size.height = 50;
            _progressView = [[SDPieLoopProgressView alloc] init];
            [self addSubview:_progressView];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell_Project" owner:self options:nil] lastObject];
    }
    
    _btnCommit.layer.cornerRadius = 5.0f;
    return self;
}

- (IBAction)ClickBtnCommit:(id)sender
{
    if (_delegate)
    {
        [_delegate DidClickBtnCommit:self];
    }
}
//-(void)layoutSubviews
//{
//    
//    
//}
- (void)UpdateInfo:(BorrowInfo *)info
{
    _progressView.hidden = NO;
    _labelTitle.text = info.text;
    _labelRate.text = [NSString stringWithFormat:@"%.2f%%",info.rate];
    _labelAmount.text = [NSString stringWithFormat:@"%ld,%.3ld元",info.amount/1000,info.amount%1000];
    _labelLimit.text = [NSString stringWithFormat:@"%ld个月",info.limit];
    self.progressView.frame = CGRectMake(self.bounds.size.width - 65, 15, 50, 50);
    if (info.progress - 100.00f >= 0.0f)
    {
        _btnCommit.enabled = NO;
        [_btnCommit setTitle:@"已满标" forState:UIControlStateNormal];
        _progressView.hidden = YES;
        _btnCommit.hidden = NO;
    }
    else
    {
        _btnCommit.enabled = YES;
        [_btnCommit setTitle:@"立即投标" forState:UIControlStateNormal];
        _btnCommit.hidden = YES;
        _progressView.hidden = NO;
//        CGRect rc;
//        rc.origin.x = self.bounds.size.width - 65;
//        rc.size.width = 50;
//        rc.origin.y = 15;
//        rc.size.height = 50;
//        
//        SDPieLoopProgressView *progressView = [[SDPieLoopProgressView alloc] initWithFrame:rc];
        _progressView.progress = info.progress/100;
//        [self addSubview:progressView];
    }
/*
    if (info.creditScore >= 5000)
    {
        _imageviewLevel.image = [UIImage imageNamed:@"1.png"];
    }
    else if (info.creditScore >= 3000)
    {
        _imageviewLevel.image = [UIImage imageNamed:@"3.png"];
    }
    else if (info.creditScore >= 2000)
    {
        _imageviewLevel.image = [UIImage imageNamed:@"4.png"];
    }
    else if (info.creditScore >= 1000)
    {
        _imageviewLevel.image = [UIImage imageNamed:@"5.png"];
    }
    else if (info.creditScore >= 500)
    {
        _imageviewLevel.image = [UIImage imageNamed:@"6.png"];
    }
    else if (info.creditScore >= 300)
    {
        _imageviewLevel.image = [UIImage imageNamed:@"7.png"];
    }
    else if (info.creditScore >= 100)
    {
        _imageviewLevel.image = [UIImage imageNamed:@"8.png"];
    }
    else if (info.creditScore >= 50)
    {
        _imageviewLevel.image = [UIImage imageNamed:@"9.png"];
    }
    else
    {
        _imageviewLevel.image = [UIImage imageNamed:@"10.png"];
    }
 */   
    
}
@end
