//
//  LDRRenantsInfoHeaderCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/30.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRenantsInfoHeaderCell.h"

@interface LDRRenantsInfoHeaderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneRightLayout;
@property (weak, nonatomic) IBOutlet UIView *backGView;

@end

@implementation LDRRenantsInfoHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.backGView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.backGView.layer setShadowRadius:LDRShadowRadius];
    [self.backGView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backGView.layer setShadowOpacity:1.0f];
    [self.backGView.layer setCornerRadius:LDRRadius];
    
    
    [self.nameLabel setTextColor:LDR_TextBalckColor];
    [self.phoneLabel setTextColor:LDR_TextBalckColor];
    [self.changeButton.layer setCornerRadius:2];
    [self.changeButton.layer setBorderColor:LDR_MainGreenColor.CGColor];
    [self.changeButton.layer setBorderWidth:1.0f];
    [self.changeButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];

}
- (IBAction)changeButtonAction:(UIButton *)sender
{
    if (self.didClickChange) {
        self.didClickChange();
    }
}
- (void)layoutSubviews
{
    CGFloat originW = self.backGView.bounds.size.width;
    CGFloat originH = self.backGView.bounds.size.height;
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(-2, -2, originW +4,originH+2 )];
    self.backGView.layer.shadowPath = path.CGPath;
}
- (void)setDidClickChange:(void (^)(void))didClickChange
{
    _didClickChange = didClickChange;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
