//
//  ViewController_Account.h
//  JiuRong
//
//  Created by iMac on 15/9/7.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_Account : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionviewMain;
@property (weak, nonatomic) IBOutlet UILabel *labelLastdayIn;
@property (weak, nonatomic) IBOutlet UILabel *labelAllMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalIn;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalOut;
@property (weak, nonatomic) IBOutlet UILabel *labelAccount;

@end
