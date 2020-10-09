//
//  LDRMineHomeTableViewCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMineHomeTableViewCell.h"

@implementation LDRMineHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.numberBackView.layer setCornerRadius:8];
    [self.numberBackView setClipsToBounds:YES];
    
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    self.numberBackView.hidden = YES;
}
- (void)setNumberBage:(NSInteger)numberBage
{
    _numberBage = numberBage;
    if (numberBage > 0) {
        self.numberBackView.hidden = NO;
        [self.numberLabel setText:[NSString stringWithFormat:@"%ld",numberBage]];
    } else {
        self.numberBackView.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
