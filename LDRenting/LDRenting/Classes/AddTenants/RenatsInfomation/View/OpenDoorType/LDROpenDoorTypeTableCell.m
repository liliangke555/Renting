//
//  LDROpenDoorTypeTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDROpenDoorTypeTableCell.h"
@interface LDROpenDoorTypeTableCell ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *blueImageView;
@property (weak, nonatomic) IBOutlet UILabel *buleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *selectorSwitch;

@end

@implementation LDROpenDoorTypeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titlesLabel setTextColor:LDR_tableTitleColor];
    
    [self.backView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowBottomColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    [self.backView.layer setCornerRadius:LDRRadius];
    
    [self.buleLabel setTextColor:LDR_TextBalckColor];
    [self.selectorSwitch setThumbTintColor:LDR_MainGreenColor];
    [self.selectorSwitch setOnTintColor:[UIColor colorWithHex:0xEEEEEECC]];
}
- (IBAction)changeSwitch:(UISwitch *)sender
{
    if (sender.on) {
        [self.selectorSwitch setThumbTintColor:LDR_MainGreenColor];
    } else {
        [self.selectorSwitch setThumbTintColor:[UIColor colorWithHex:0x62666488]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
