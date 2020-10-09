//
//  LDRMyBillEmptyCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/27.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMyBillEmptyCell.h"

@interface LDRMyBillEmptyCell ()

@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;
@end

@implementation LDRMyBillEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.emptyLabel setTextColor:LDR_TextGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
