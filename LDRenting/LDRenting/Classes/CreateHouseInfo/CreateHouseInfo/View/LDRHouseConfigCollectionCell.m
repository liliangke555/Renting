//
//  LDRHouseConfigCollectionCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseConfigCollectionCell.h"

@interface LDRHouseConfigCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation LDRHouseConfigCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_TextDarkGrayColor];
    [self.backView.layer setCornerRadius:4.0f];
    [self.backView.layer setBorderWidth:1.0f];
    [self.backView.layer setBorderColor:LDR_TextLightGrayColor.CGColor];
    self.selectedImageView.hidden = YES;
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (!self.isCheck) {
        self.selectedImageView.hidden = !selected;
    }
    if (selected) {
        [self.backView.layer setBorderColor:LDR_MainGreenColor.CGColor];
        [self.headerImageView setTintColor:LDR_MainGreenColor];
    } else {
        [self.backView.layer setBorderColor:LDR_TextLightGrayColor.CGColor];
        [self.headerImageView setTintColor:LDR_TextLightGrayColor];
    }
}
- (void)setCheck:(BOOL)check
{
    _check = check;
}
@end
