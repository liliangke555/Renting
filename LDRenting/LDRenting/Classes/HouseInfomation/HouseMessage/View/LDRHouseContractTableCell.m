//
//  LDRHouseContractTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/6.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseContractTableCell.h"

@interface LDRHouseContractTableCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation LDRHouseContractTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLable setTextColor:LDR_tableTitleColor];
    [self.typeLabel setTextColor:[UIColor colorWithHex:0xFD942DFF]];
    
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    [self.backView.layer setCornerRadius:2];
}
- (void)setSignUp:(BOOL)signUp
{
    _signUp = signUp;
    if (signUp) {
        [self.typeLabel setTextColor:LDR_TextBalckColor];
        [self.typeLabel setText:@"查看合同"];
    } else {
        [self.typeLabel setTextColor:[UIColor colorWithHex:0xFD942DFF]];
        [self.typeLabel setText:@"未签约"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
