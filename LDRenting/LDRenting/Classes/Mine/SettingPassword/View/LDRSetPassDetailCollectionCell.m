//
//  LDRSetPassDetailCollectionCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSetPassDetailCollectionCell.h"

@interface LDRSetPassDetailCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleCenterY;

@end

@implementation LDRSetPassDetailCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.detailLabel setTextColor:LDR_TextGrayColor];
    [self.layer setCornerRadius:4.0f];
    [self.layer setBorderWidth:1.0f];
    self.titleCenterY.constant = 0.0f;
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self.layer setBorderColor:LDR_MainGreenColor.CGColor];
        self.backgroundColor = LDR_BackgroundColor;
        [self.selectedImageView setImage:[UIImage imageNamed:@"circular_selected"]];
        [self.detailLabel setTextColor:LDR_TextBalckColor];
    } else {
        [self.layer setBorderColor:[UIColor colorWithHex:0xF4F5F6FF].CGColor];
        self.backgroundColor = [UIColor colorWithHex:0xF4F5F6FF];
        [self.selectedImageView setImage:[UIImage imageNamed:@"circular_normal"]];
        [self.detailLabel setTextColor:LDR_TextGrayColor];
    }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titleLabel setText:title];
}
- (void)setDetail:(NSString *)detail
{
    _detail = detail;
    if (detail.length > 0) {
        self.titleCenterY.constant = -10.0f;
        [self.detailLabel setText:detail];
    } else {
        self.titleCenterY.constant = 0.0f;
    }
}
@end
