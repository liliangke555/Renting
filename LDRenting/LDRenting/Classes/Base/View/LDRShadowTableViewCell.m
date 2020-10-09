//
//  LDRShadowTableViewCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRShadowTableViewCell.h"

@implementation LDRShadowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.layer setShadowOffset:CGSizeZero];
    [self.layer setShadowRadius:10];
    [self.layer setShadowColor:LDR_shadowBottomColor.CGColor];
    [self.layer setShadowOpacity:1.0f];
}
//- (void)layoutSubviews
//{
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
