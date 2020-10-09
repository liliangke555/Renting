//
//  LDRLockSettingHeaderView.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLockSettingHeaderView.h"

typedef void(^DidClickBlock)(void);
@interface LDRLockSettingHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *lockRecordButton;
@property (weak, nonatomic) IBOutlet UIView *signalOne;
@property (weak, nonatomic) IBOutlet UIView *signTwo;
@property (weak, nonatomic) IBOutlet UIView *signThree;
@property (weak, nonatomic) IBOutlet UIView *signFour;
@property (weak, nonatomic) IBOutlet UIView *batteryView;
@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;
@property (weak, nonatomic) IBOutlet UILabel *signalLabel;

@property (nonatomic, copy) DidClickBlock clickRecord;
@property (nonatomic, copy) DidClickBlock clickBuleTooth;
@property (nonatomic, copy) DidClickBlock clickPassword;
@end

@implementation LDRLockSettingHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithHex:0xF4F5F6FF];
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.signalLabel setTextColor:LDR_TextGrayColor];
    [self.batteryLabel setTextColor:LDR_TextGrayColor];
    [self.lockRecordButton setTitleColor:LDR_TextGrayColor forState:UIControlStateNormal];
    [self.lockRecordButton setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
}
- (IBAction)lockRecordButtonAction:(id)sender
{
    if (self.clickRecord) {
        self.clickRecord();
    }
}
- (IBAction)blueToothOepnAction:(id)sender
{
    if (self.clickBuleTooth) {
        self.clickBuleTooth();
    }
}
- (IBAction)passwordOpenAction:(id)sender
{
    if (self.clickPassword) {
        self.clickPassword();
    }
}
- (void)didClickRecords:(void (^)(void))clickRecord didClickBuleTooth:(void (^)(void))clickBuleTooth didClickPassword:(void (^)(void))clickPassword
{
    self.clickRecord = clickRecord;
    self.clickBuleTooth = clickBuleTooth;
    self.clickPassword = clickPassword;
}
#pragma mark - Setter
- (void)setSingnal:(CGFloat)singnal
{
    _singnal = singnal;
    [self.signalLabel setText:[NSString stringWithFormat:@"%0.f%%",singnal * 100]];
    if (singnal > 0.75 && singnal < 1) {
        [self.signalOne setBackgroundColor:LDR_MainGreenColor];
        [self.signTwo setBackgroundColor:LDR_MainGreenColor];
        [self.signThree setBackgroundColor:LDR_MainGreenColor];
        [self.signFour setBackgroundColor:LDR_TextLightGrayColor];
    } else if (singnal > 0.5 && singnal <= 0.75) {
        [self.signalOne setBackgroundColor:LDR_MainGreenColor];
        [self.signTwo setBackgroundColor:LDR_MainGreenColor];
        [self.signThree setBackgroundColor:LDR_TextLightGrayColor];
        [self.signFour setBackgroundColor:LDR_TextLightGrayColor];
    } else if (singnal > 0.25 && singnal <= 0.5) {
        [self.signalOne setBackgroundColor:LDR_MainGreenColor];
        [self.signTwo setBackgroundColor:LDR_TextLightGrayColor];
        [self.signThree setBackgroundColor:LDR_TextLightGrayColor];
        [self.signFour setBackgroundColor:LDR_TextLightGrayColor];
    } else {
        [self.signalOne setBackgroundColor:LDR_TextLightGrayColor];
        [self.signTwo setBackgroundColor:LDR_TextLightGrayColor];
        [self.signThree setBackgroundColor:LDR_TextLightGrayColor];
        [self.signFour setBackgroundColor:LDR_TextLightGrayColor];
    }
}
- (void)setElectricity:(CGFloat)electricity
{
    _electricity = electricity;
    if (electricity < 0.2) {
        [self.batteryView setBackgroundColor:[UIColor redColor]];
    } else {
        [self.batteryView setBackgroundColor:LDR_MainGreenColor];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
