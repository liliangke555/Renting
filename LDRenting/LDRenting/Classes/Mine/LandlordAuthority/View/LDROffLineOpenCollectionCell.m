//
//  LDROffLineOpenCollectionCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDROffLineOpenCollectionCell.h"

@interface LDROffLineOpenCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *pointView;

@end

@implementation LDROffLineOpenCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.subTitleLabel setTextColor:LDR_TextGrayColor];
    
    [self.layer setShadowOffset:CGSizeZero];
    [self.layer setShadowRadius:LDRShadowBottomRaius];
    [self.layer setShadowColor:LDR_shadowBottomColor.CGColor];
    [self.layer setShadowOpacity:1.0f];
    self.layer.masksToBounds =NO;
    
    
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    [self.backView.layer setCornerRadius:LDRRadius];
}
- (void)setOpenType:(LDROffLineOpenType)openType
{
    _openType = openType;
    if (openType == LDROffLineOpenTypeFinger) {
        [self.headerImageView setImage:[UIImage imageNamed:@"fingerprint_open"]];
        [self.titleLabel setText:@"指纹开门"];
        [self.subTitleLabel setText:@"指纹管理"];
    } else if (openType == LDROffLineOpenTypeICCard) {
        [self.headerImageView setImage:[UIImage imageNamed:@"iccard_open"]];
        [self.titleLabel setText:@"IC卡"];
        [self.subTitleLabel setText:@"IC卡管理"];
    } else {
        [self.headerImageView setImage:[UIImage imageNamed:@"password_open"]];
        [self.titleLabel setText:@"密码开门"];
        [self.subTitleLabel setText:@"本地密码管理"];
    }
}
@end
