//
//  CollectionViewCell_Transfer.h
//  JiuRong
//
//  Created by iMac on 15/9/7.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransInfo.h"

@interface CollectionViewCell_Transfer : UICollectionViewCell

- (void)UpdateInfo:(TransBaseInfo*)info;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelOut;
@property (weak, nonatomic) IBOutlet UILabel *labelIn;
@property (weak, nonatomic) IBOutlet UILabel *labelRemainMoney;

@end


