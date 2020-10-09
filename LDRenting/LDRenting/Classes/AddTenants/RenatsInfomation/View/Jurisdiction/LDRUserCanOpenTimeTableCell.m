//
//  LDRUserCanOpenTimeTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRUserCanOpenTimeTableCell.h"

@interface LDRUserCanOpenTimeTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UIButton *toButton;

@end

@implementation LDRUserCanOpenTimeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.toButton setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    [self.toButton setTitleColor:LDR_TextGrayColor forState:UIControlStateNormal];
    [self.titlesLabel setTextColor:LDR_TextBalckColor];
    [self.detailsLabel setTextColor:LDR_TextGrayColor];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titlesLabel setText:title];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
