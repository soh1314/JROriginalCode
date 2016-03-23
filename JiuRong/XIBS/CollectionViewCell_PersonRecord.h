//
//  CollectionViewCell_PersonRecord.h
//  JiuRong
//
//  Created by iMac on 15/9/23.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell_PersonRecord : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;

- (void)UpdateInfo:(NSString*)title money:(NSInteger)iMoney status:(NSInteger)iStatus;
//K label
- (void)JRUpdateInfo:(NSString *)title money:(NSString *)KMoney status:(NSInteger)iStatus;
@end
