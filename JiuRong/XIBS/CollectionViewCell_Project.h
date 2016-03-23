//
//  CollectionViewCell_Project.h
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPieLoopProgressView.h"
@protocol CollectionCell_Project_delegate <NSObject>

- (void)DidClickBtnCommit:(id)sender;

@end

@class BorrowInfo;
@interface CollectionViewCell_Project : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelRate;
@property (weak, nonatomic) IBOutlet UILabel *labelAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelLimit;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewLevel;
@property (nonatomic,strong) SDPieLoopProgressView *progressView;
@property (nonatomic) id<CollectionCell_Project_delegate> delegate;
- (IBAction)ClickBtnCommit:(id)sender;

- (void)UpdateInfo:(BorrowInfo*)info;

@end
