//
//  LDRLockManageTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLockManageTableCell.h"

@interface LDRLockManageTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bigBackView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *lockNameLabel;
@property (weak, nonatomic) IBOutlet UIView *signalOne;
@property (weak, nonatomic) IBOutlet UIView *signTwo;
@property (weak, nonatomic) IBOutlet UIView *signThree;
@property (weak, nonatomic) IBOutlet UIView *signFour;
@property (weak, nonatomic) IBOutlet UILabel *signalLabel;
@property (weak, nonatomic) IBOutlet UIView *batteryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *batteryWidth;
@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;

@end

@implementation LDRLockManageTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.backView.layer setCornerRadius:4.0f];
    
    [self.lockNameLabel setTextColor:LDR_TextBalckColor];
    [self.signalLabel setTextColor:LDR_TextGrayColor];
    [self.batteryLabel setTextColor:LDR_TextGrayColor];
    
    [self.bigBackView.layer setCornerRadius:LDRRadius];
    [self.bigBackView.layer setShadowOffset:CGSizeZero];
    [self.bigBackView.layer setShadowRadius:LDRShadowRadius];
    [self.bigBackView.layer setShadowColor:LDR_GrayColor.CGColor];
    [self.bigBackView.layer setShadowOpacity:1.0f];
}

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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
