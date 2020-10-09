//
//  LDRAddTenantsCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddTenantsCell.h"

@interface LDRAddTenantsCell ()
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation LDRAddTenantsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titlesLabel setTextColor:LDR_TextBalckColor];
    [self.detailsLabel setTextColor:LDR_TextGrayColor];
    
    [self.backView.layer setCornerRadius:LDRRadius];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titlesLabel.text = title;
}
- (void)setDetail:(NSString *)detail
{
    _detail = detail;
    self.detailsLabel.text = detail;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
