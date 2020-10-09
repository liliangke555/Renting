//
//  LDRContractLandlordTableViewCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRContractLandlordTableViewCell.h"

@interface LDRContractLandlordTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *landlordName;
@property (weak, nonatomic) IBOutlet UILabel *landlordDetail;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneDetail;

@end

@implementation LDRContractLandlordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.landlordName setTextColor:LDR_TextBalckColor];
    [self.phoneLabel setTextColor:LDR_TextBalckColor];
    [self.landlordDetail setTextColor:LDR_TextGrayColor];
    [self.phoneDetail setTextColor:LDR_TextGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
