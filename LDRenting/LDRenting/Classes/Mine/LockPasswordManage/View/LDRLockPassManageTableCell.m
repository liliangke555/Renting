//
//  LDRLockPassManageTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLockPassManageTableCell.h"

@interface LDRLockPassManageTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIView *typePoint;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIView *checkCenterView;

@end

@implementation LDRLockPassManageTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.typeLabel setTextColor:LDR_TextGrayColor];
    
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    [self.backView.layer setCornerRadius:4];
}
- (IBAction)checkuttonAction:(id)sender {
    if (self.didClickCheck) {
        self.didClickCheck();
    }
}
- (IBAction)deleteButtonAction:(id)sender {
    if (self.didClickDelete) {
        self.didClickDelete();
    }
}
- (void)setOverstayed:(BOOL)overstayed
{
    _overstayed = overstayed;
    [self.typePoint setBackgroundColor:overstayed?LDR_TextGrayColor:LDR_MainGreenColor];
    [self.typeLabel setText:overstayed?@"已过期":@"生效中" ];
    self.checkButton.hidden = overstayed;
    self.checkCenterView.hidden = overstayed;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
