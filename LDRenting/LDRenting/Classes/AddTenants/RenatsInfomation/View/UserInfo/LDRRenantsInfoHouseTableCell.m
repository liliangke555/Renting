//
//  LDRRenantsInfoHouseTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRenantsInfoHouseTableCell.h"

@interface LDRRenantsInfoHouseTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseTimeDetailLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation LDRRenantsInfoHouseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titlesLabel setTextColor:LDR_tableTitleColor];
    [self.houseLabel setTextColor:LDR_TextBalckColor];
    [self.houseTimeLabel setTextColor:LDR_TextBalckColor];
    [self.houseDetailLabel setTextColor:LDR_TextGrayColor];
    [self.houseTimeDetailLabel setTextColor:LDR_TextGrayColor];
    
    [self.backView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titlesLabel setText:title];
}
- (void)layoutSubviews
{
    CGFloat originY = 0;
    CGFloat originW = LDR_WIDTH - 32;
    CGFloat originH = self.backView.bounds.size.height;
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(-2, originY, originW +4,originH)];
    self.backView.layer.shadowPath = path.CGPath;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
