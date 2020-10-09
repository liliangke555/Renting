//
//  LDRSuccessHouseCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/23.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSuccessHouseCell.h"

@interface LDRSuccessHouseCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;

@end

@implementation LDRSuccessHouseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titlesLabel setTextColor:LDR_TextBalckColor];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.backView.layer setCornerRadius:LDRRadius];
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_GrayColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
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
