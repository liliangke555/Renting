//
//  LDRFingerprintPermissionCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRFingerprintPermissionCell.h"

@interface LDRFingerprintPermissionCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UISwitch *selectSwitch;

@end

@implementation LDRFingerprintPermissionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    
    [self.titlesLabel setTextColor:LDR_TextBalckColor];
    [self.selectSwitch setThumbTintColor:LDR_MainGreenColor];
    [self.selectSwitch setOnTintColor:[UIColor colorWithHex:0xFFFFFFFF]];
    
    [self.backView.layer setCornerRadius:LDRRadius];
}
- (IBAction)selectSwitchAction:(UISwitch *)sender
{
    if (sender.on) {
        [self.selectSwitch setThumbTintColor:LDR_MainGreenColor];
    } else {
        [self.selectSwitch setThumbTintColor:[UIColor colorWithHex:0x62666488]];
    }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titlesLabel setText:title];
}
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self.headerImageView setImage:[UIImage imageNamed:imageUrl]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
