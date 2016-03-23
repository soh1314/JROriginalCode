//
//  CollectionViewCell_Borrow2.h
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonBorrowInfoDelegate <NSObject>

- (void)DidClickBtnPaybackMoney:(id)sender;

@end

@class PaybackBaseInfo;
@interface CollectionViewCell_Borrow2 : UICollectionViewCell


- (void)UpdateInfo:(PaybackBaseInfo*)info;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelApplyTime;
@property (weak, nonatomic) IBOutlet UILabel *labelApplyMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UILabel *labelCommitTime;
@property (weak, nonatomic) IBOutlet UILabel *labelCommitMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelEndtime;
@property (weak, nonatomic) IBOutlet UILabel *labelEndMoney;

@property (nonatomic) id<PersonBorrowInfoDelegate> delegate;

@end
