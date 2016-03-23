//
//  LoanInfoCell.h
//  
//
//  Created by jingshuihuang on 16/3/17.
//
//

#import <UIKit/UIKit.h>

@interface LoanInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ApplyInfoTitle;
@property (weak, nonatomic) IBOutlet UILabel *ApplyInfoContent;
@property (weak, nonatomic) IBOutlet UIImageView *menuBtn;

- (void)updateInfoWith:(NSString *)info;

@end
