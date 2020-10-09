//
//  LDRLockSettingTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLockSettingTableCell.h"

@interface LDRLockSettingTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabal;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UISwitch *selectorSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end

@implementation LDRLockSettingTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.detailLabal setTextColor:LDR_TextGrayColor];
    
    [self.backView.layer setCornerRadius:LDRRadius];
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_GrayColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    
    [self.selectorSwitch setThumbTintColor:LDR_MainGreenColor];
    [self.selectorSwitch setOnTintColor:[UIColor colorWithHex:0xEEEEEECC]];
    
    
}
- (IBAction)switchAction:(UISwitch *)sender
{
    if (sender.on) {
        [sender setThumbTintColor:LDR_MainGreenColor];
    } else {
        [sender setThumbTintColor:[UIColor colorWithHex:0x62666488]];
    }
}
#pragma mark - Setter
- (void)setOpen:(BOOL)open
{
    _open = open;
    if (open) {
        self.selectorSwitch.hidden = NO;
        self.rightImageView.hidden = YES;
    } else {
        self.selectorSwitch.hidden = YES;
        self.rightImageView.hidden = NO;
    }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titleLabel setText:title];
}
- (void)setDetail:(NSString *)detail
{
    _detail = detail;
    [self.detailLabal setText:detail];
}
- (void)setImageString:(NSString *)imageString
{
    _imageString = imageString;
    [self.headerImageView setImage:[UIImage imageNamed:imageString]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
