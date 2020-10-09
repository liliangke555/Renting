//
//  LDRCallPoliceNoticeTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCallPoliceNoticeTableCell.h"

@interface LDRCallPoliceNoticeTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *timeBackView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTime;

@end

@implementation LDRCallPoliceNoticeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.timeBackView.layer setCornerRadius:4.0f];
    
    [self.backView.layer setCornerRadius:8.0f];
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowBottomColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    
    [self.subTitleLabel setTextColor:LDR_TextBalckColor];
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.detailLabel setTextColor:LDR_TextBalckColor];
    [self.detailTime setTextColor:LDR_TextGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
