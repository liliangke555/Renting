//
//  LDRContractAddressTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRContractAddressTableCell.h"

@interface LDRContractAddressTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *contractTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contractTypeDetail;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressDetail;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaDetail;

@end

@implementation LDRContractAddressTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contractTypeLabel setTextColor:LDR_TextBalckColor];
    [self.addressLabel setTextColor:LDR_TextBalckColor];
    [self.areaLabel setTextColor:LDR_TextBalckColor];
    
    [self.contractTypeDetail setTextColor:LDR_TextGrayColor];
    [self.addressDetail setTextColor:LDR_TextGrayColor];
    [self.areaDetail setTextColor:LDR_TextGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
