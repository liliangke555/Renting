//
//  LDRHomeHouseInfoCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/16.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomeHouseInfoCell.h"

@interface LDRHomeHouseInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *certifiedLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *retingTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *callRent;
@property (weak, nonatomic) IBOutlet UIView *retingTimeBackView;
@property (weak, nonatomic) IBOutlet UIView *bigBackView;

@end

@implementation LDRHomeHouseInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.oneTypeLabel clipCorners:UIRectCornerAllCorners radius:2.0f];
    [self.twoTypeLabel clipCorners:UIRectCornerAllCorners radius:2.0f];
    
    [self.certifiedLabel clipCorners:UIRectCornerBottomLeft |UIRectCornerTopRight radius:LDRRadius];
    [self.bigBackView.layer setCornerRadius:LDRRadius];
    [self.retingTimeBackView.layer setCornerRadius:12.0f];
    [self.callRent.layer setCornerRadius:12.0f];
    
    [self.nameLabel setTextColor:LDR_TextBalckColor];
    [self.addressLabel setTextColor:LDR_TextBalckColor];
    [self.retingTimeLabel setTextColor:LDR_TextDarkGrayColor];
    
    [self.bigBackView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.bigBackView.layer setShadowRadius:LDRShadowRadius];
    [self.bigBackView.layer setShadowColor:LDR_shadowBottomColor.CGColor];
    [self.bigBackView.layer setShadowOpacity:1.0f];

    
}
- (IBAction)callForRentButtonAction:(UIButton *)sender
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
