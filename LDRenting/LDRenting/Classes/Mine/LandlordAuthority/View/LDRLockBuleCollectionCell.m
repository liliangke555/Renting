//
//  LDRLockBuleCollectionCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLockBuleCollectionCell.h"
@interface LDRLockBuleCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *selectSwitch;
@property (weak, nonatomic) IBOutlet UIView *backView;
@end
@implementation LDRLockBuleCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.selectSwitch setThumbTintColor:LDR_MainGreenColor];
    [self.selectSwitch setOnTintColor:[UIColor colorWithHex:0xEEEEEEFF]];
    
    [self.layer setShadowOffset:CGSizeZero];
    [self.layer setShadowRadius:LDRShadowBottomRaius];
    [self.layer setShadowColor:LDR_shadowBottomColor.CGColor];
    [self.layer setShadowOpacity:1.0f];
    self.layer.masksToBounds =NO;
    
    
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    [self.backView.layer setCornerRadius:LDRRadius];
}
- (IBAction)selectSwitchAction:(UISwitch *)sender {
    if (sender.on) {
        [self.selectSwitch setThumbTintColor:LDR_MainGreenColor];
    } else {
        [self.selectSwitch setThumbTintColor:[UIColor colorWithHex:0x62666488]];
    }
}

@end
