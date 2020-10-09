//
//  LDRMyBillTotalView.m
//  LDRenting
//
//  Created by MAC on 2020/7/28.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMyBillTotalView.h"

@interface LDRMyBillTotalView ()
@property (weak, nonatomic) IBOutlet UIButton *timeSelectorButton;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LDRMyBillTotalView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.timeSelectorButton.layer setCornerRadius:11];
    [self.timeSelectorButton setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    [self.timeSelectorButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    
    [self.titleLabel setTextColor:LDR_TextGrayColor];
}
- (IBAction)timeSelectorAction:(UIButton *)sender
{
    if (self.didClickTimeAction) {
        self.didClickTimeAction(sender);
    }
}
#pragma mark - Setter
- (void)setTimeString:(NSString *)timeString
{
    _timeString = timeString;
    NSRange range = [timeString rangeOfString:@"-"];
    NSString *time = timeString;
    if (range.location != NSNotFound) {
        time = [timeString stringByReplacingOccurrencesOfString:@"-" withString:@"年"];
        time = [time stringByAppendingString:@"月"];
    }
    [self.timeSelectorButton setTitle:time forState:UIControlStateNormal];
}
- (void)setTotalMony:(NSString *)totalMony
{
    _totalMony = totalMony;
    [self.totalLabel setText:totalMony];
}
- (void)setNumberString:(NSString *)numberString
{
    _numberString = numberString;
    [self.numberLabel setText:[NSString stringWithFormat:@"收款数：%@ 笔",numberString]];
}
- (void)setDidClickTimeAction:(void (^)(UIButton * _Nonnull))didClickTimeAction
{
    _didClickTimeAction = didClickTimeAction;
}

@end
