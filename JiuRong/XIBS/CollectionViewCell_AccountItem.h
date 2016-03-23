//
//  CollectionViewCell_AccountItem.h
//  JiuRong
//
//  Created by iMac on 15/12/11.
//  Copyright © 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell_AccountItem : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTimeEnd;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UILabel *labelMark;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeReally;

- (void)UpdateInfo:(NSString*)TimeEnd money:(NSInteger)iMoney status:(NSInteger)iStatus mark:(NSString*)mark timereally:(NSString*)TimeReally;

- (void)JRUpdateInfo:(NSString *)TimeEnd money:(NSString *)iMoney status:(NSInteger)iStatus mark:(NSString *)mark timereally:(NSString *)TimeReally;
@end
