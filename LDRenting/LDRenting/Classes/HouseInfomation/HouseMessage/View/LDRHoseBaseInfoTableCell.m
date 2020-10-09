//
//  LDRHoseBaseInfoTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/6.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHoseBaseInfoTableCell.h"

@interface LDRHoseBaseInfoTableCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleBale;
@property (weak, nonatomic) IBOutlet UILabel *houseTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseTypeDetail;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaDetail;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionDetail;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressDetail;
@property (weak, nonatomic) IBOutlet UILabel *rentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentDetail;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentDetail;

@end

@implementation LDRHoseBaseInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleBale setTextColor:LDR_tableTitleColor];
    [self.houseTypeLabel setTextColor:LDR_TextBalckColor];
    [self.areaLabel setTextColor:LDR_TextBalckColor];
    [self.directionLabel setTextColor:LDR_TextBalckColor];
    [self.addressLabel setTextColor:LDR_TextBalckColor];
    [self.rentLabel setTextColor:LDR_TextBalckColor];
    [self.paymentLabel setTextColor:LDR_TextBalckColor];
    
    [self.houseTypeDetail setTextColor:LDR_TextGrayColor];
    [self.areaDetail setTextColor:LDR_TextGrayColor];
    [self.directionDetail setTextColor:LDR_TextGrayColor];
    [self.addressDetail setTextColor:LDR_TextGrayColor];
    [self.rentDetail setTextColor:LDR_TextGrayColor];
    [self.paymentDetail setTextColor:LDR_TextGrayColor];
    
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    [self.backView.layer setCornerRadius:2];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat originW = self.backView.bounds.size.width;
    CGFloat originH = self.backView.bounds.size.height;
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(-2, -2, originW +4,originH+2 )];
    self.backView.layer.shadowPath = path.CGPath;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
