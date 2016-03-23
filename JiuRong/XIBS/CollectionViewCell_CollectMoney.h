//
//  CollectionViewCell_CollectMoney.h
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDBallProgressView.h"
#import "SDPieLoopProgressView.h"

@class BorrowInfo;
@interface CollectionViewCell_CollectMoney : UICollectionViewCell

+ (id)CreateCollectMoneyCell;
- (void)UpdateInfo:(BorrowInfo*)info;

@property (weak, nonatomic) IBOutlet UIImageView *imageviewType;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelRate;
@property (weak, nonatomic) IBOutlet UILabel *labelAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelLimit;
@property (weak, nonatomic) IBOutlet SDPieLoopProgressView *progressValue;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewFull;

@end
