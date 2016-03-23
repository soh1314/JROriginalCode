//
//  ViewController_AccountItems.h
//  JiuRong
//
//  Created by iMac on 15/12/11.
//  Copyright © 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaybackInfo.h"
@interface ViewController_AccountItems : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelNO;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;
- (IBAction)ClickBtnDetail:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionviewMain;
@property (nonatomic,strong) PaybackBaseInfo * payBackBaseInfo;
//@property (nonatomic, retain) NSString *bid;
//@property (nonatomic, retain) NSString *mytitle;
//@property (nonatomic, assign) NSInteger status;

@end
