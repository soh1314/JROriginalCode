//
//  ViewController_Home.h
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealReachability.h"
#import "JRNetView.h"
@interface ViewController_Home : UIViewController <UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionviewMain;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UILabel *labelTotaoAccount;
@property (weak, nonatomic) IBOutlet UILabel *labelCatch;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalUsers;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollviewMain;
@end
