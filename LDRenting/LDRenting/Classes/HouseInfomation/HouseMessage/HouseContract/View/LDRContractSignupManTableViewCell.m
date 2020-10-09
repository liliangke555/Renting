//
//  LDRContractSignupManTableViewCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRContractSignupManTableViewCell.h"

@interface LDRContractSignupManTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonRightLayout;

@end

@implementation LDRContractSignupManTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    [self.backView.layer setCornerRadius:2];
    
    [self.nameLabel setTextColor:LDR_TextBalckColor];
    [self.phoneLabel setTextColor:LDR_TextGrayColor];
    [self.changeButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    [self.changeButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    [self.changeButton setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
}
- (IBAction)changeButtonAction:(UIButton *)sender
{
}
- (void)setSignupMan:(BOOL)signupMan
{
    _signupMan = signupMan;
    if (signupMan) {
        self.headerImageView.hidden = NO;
        self.nameLabel.hidden = NO;
        self.phoneLabel.hidden = NO;
        [self.changeButton setTitle:@"更换" forState:UIControlStateNormal];
        self.buttonRightLayout.constant = LDRPadding;
    } else {
        self.headerImageView.hidden = YES;
        self.nameLabel.hidden = YES;
        self.phoneLabel.hidden = YES;
        [self.changeButton setTitle:@"请选择租客" forState:UIControlStateNormal];
        self.buttonRightLayout.constant = LDR_WIDTH / 2.0f - LDRPadding - CGRectGetWidth(self.changeButton.frame)/ 2.0f;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
