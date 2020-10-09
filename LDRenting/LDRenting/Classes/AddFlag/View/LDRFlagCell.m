//
//  LDRFlagCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRFlagCell.h"

@interface LDRFlagCell ()
@property (weak, nonatomic) IBOutlet UILabel *flagTitleLabel;

@end

@implementation LDRFlagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.flagTitleLabel.layer setCornerRadius:2.0f];
    [self.flagTitleLabel.layer setBorderWidth:1.0f];
    [self.flagTitleLabel.layer setBorderColor:LDR_GrayColor.CGColor];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.flagTitleLabel setText:title];
}
- (void)setFlagType:(LDRFlagType)flagType
{
    _flagType = flagType;
    if (flagType == LDRFlagTypeGood) {
        [self.flagTitleLabel setTextColor:LDR_MainGreenColor];
    } else if (flagType == LDRFlagTypeWarning) {
        [self.flagTitleLabel setTextColor:[UIColor colorWithHex:0xFD9515FF]];
    } else {
        [self.flagTitleLabel setTextColor:[UIColor colorWithHex:0xF25441FF]];
    }
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self.flagTitleLabel.layer setBorderColor:LDR_MainGreenColor.CGColor];
    } else {
        [self.flagTitleLabel.layer setBorderColor:LDR_GrayColor.CGColor];
    }
}
@end
