//
//  LDRSelectHouseTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/30.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSelectHouseTableCell.h"

@interface LDRSelectHouseTableCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *houseLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentingInfoLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *rentingInfoTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *lockIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaseTermLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentingNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *houseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

@implementation LDRSelectHouseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.typeLabel.hidden = YES;
    
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:4];
    [self.backView.layer setShadowColor:LDR_GrayColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    [self.backView.layer setCornerRadius:LDRRadius];
    
    [self.backView.layer setBorderWidth:1.0f];
    [self.backView.layer setBorderColor:LDR_BackgroundColor.CGColor];
    
    [self.houseLabel setTextColor:LDR_TextBalckColor];
    [self.addressLabel setTextColor:LDR_TextBalckColor];
    [self.typeLabel setTextColor:LDR_TextBalckColor];
    [self.typeLabel setBackgroundColor:[UIColor colorWithHex:0x21C7671A]];
    [self.typeLabel.layer setCornerRadius:2.0f];
    [self.typeLabel setClipsToBounds:YES];
    
    [self.rentingInfoLabel setTextColor:LDR_TextLightGrayColor];
    [self.lockIDLabel setTextColor:LDR_TextDarkGrayColor];
    [self.rentingNumberLabel setTextColor:LDR_TextDarkGrayColor];
    [self.leaseTermLabel setTextColor:LDR_TextDarkGrayColor];
}
- (void)setModel:(LDRRentHouseModel *)model
{
    _model = model;
    if (model) {
        [self.houseLabel setText:model.houseName];
        [self.addressLabel setText:[NSString stringWithFormat:@"地址：%@",model.address]];
        [self.lockIDLabel setText:[NSString stringWithFormat:@"门锁型号：%@",model.lockType]];
        [self.rentingNumberLabel setText:[NSString stringWithFormat:@"租客人数：%ld人",model.rentedCount]];
        [self.leaseTermLabel setText:[NSString stringWithFormat:@"租约到期时间：%@",model.expTime]];
        [self.houseImageView sd_setImageWithURL:[NSURL URLWithString:model.path1] placeholderImage:[UIImage imageNamed:@"empty_house_image"]];
        NSMutableString *string = [NSMutableString string];
        if (model.roomNum > 0) {
            [string appendFormat:@"%ld室",model.roomNum];
        }
        if (model.hallNum > 0) {
            [string appendFormat:@"%ld厅",model.hallNum];
        }
        if (model.bathroomNum > 0) {
            [string appendFormat:@"%ld卫",model.bathroomNum];
        }
        if (model.rentPayInfo.length > 0) {
            [self.rentingInfoTwoLabel setText:model.rentPayInfo];
            self.rentingInfoTwoLabel.hidden = NO;
        } else {
            self.rentingInfoTwoLabel.hidden = YES;
        }
        if (string.length > 0) {
            [self.rentingInfoLabel setText:string];
            [self.rentingInfoLabel setTextColor:[UIColor colorWithHex:0xFD942DFF]];
        } else {
            [self.rentingInfoLabel setTextColor:LDR_TextGrayColor];
        }
        if (model.rentPayInfo.length <= 0 && string.length <= 0) {
            [self.rentingInfoLabel setText:@"房屋信息待完善"];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.backView.layer setBorderColor:LDR_MainGreenColor.CGColor];
        [self.selectedImageView setImage:[UIImage imageNamed:@"select_house_selected"]];
    } else {
        [self.backView.layer setBorderColor:LDR_BackgroundColor.CGColor];
        [self.selectedImageView setImage:[UIImage imageNamed:@"select_house_normal"]];
    }
    // Configure the view for the selected state
}

@end
