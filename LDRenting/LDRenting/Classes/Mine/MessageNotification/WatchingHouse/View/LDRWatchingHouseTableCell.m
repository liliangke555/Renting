//
//  LDRWatchingHouseTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRWatchingHouseTableCell.h"
@interface LDRWatchingHouseTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *noticeDetailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *noticeDetailBackImageView;
@property (weak, nonatomic) IBOutlet UIButton *refuseButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIView *timeBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
@implementation LDRWatchingHouseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    UIImage *detailImage = [UIImage imageNamed:@"notice_pop"];
//    [detailImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
//    [self.noticeDetailBackImageView setImage:detailImage];
    
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.subTitleLabel setTextColor:LDR_TextBalckColor];
    [self.nameLabel setTextColor:LDR_TextBalckColor];
    [self.noticeDetailLabel setTextColor:LDR_TextDarkGrayColor];
    
    [self.headerImageView.layer setCornerRadius:LDRRadius];
    
    [self.refuseButton setBackgroundImage:[UIImage ldr_imageWithColor:[UIColor colorWithHex:0xEDEDEDFF]] forState:UIControlStateNormal];
    [self.refuseButton setTitleColor:[UIColor colorWithHex:0xF25441FF] forState:UIControlStateNormal];
    [self.refuseButton.layer setCornerRadius:4.0f];
    [self.refuseButton setClipsToBounds:YES];
    
    [self.agreeButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenColor] forState:UIControlStateNormal];
    [self.agreeButton setTitleColor:LDR_BackgroundColor forState:UIControlStateNormal];
    [self.agreeButton.layer setCornerRadius:4.0f];
    [self.agreeButton setClipsToBounds:YES];
    
    [self.timeBackView.layer setCornerRadius:4.0f];
    [self.backView.layer setCornerRadius:8.0f];
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowBottomColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
}
- (IBAction)refuseButtonAction:(id)sender
{
}
- (IBAction)agreeButtonAction:(id)sender
{
}
- (void)setNoticeType:(LDRWatchingHouseType)noticeType
{
    _noticeType = noticeType;
    if (noticeType == LDRWatchingHouseNormal) {
        self.typeLabel.hidden = YES;
        self.agreeButton.hidden = NO;
        self.refuseButton.hidden = NO;
        self.bottomLayout.constant = 56;
    } else if (noticeType == LDRWatchingHouseAgree) {
        self.typeLabel.hidden = NO;
        [self.typeLabel setTextColor:[UIColor colorWithHex:0x21C767FF]];
        [self.typeLabel setText:@"已同意"];
        self.agreeButton.hidden = YES;
        self.refuseButton.hidden = YES;
        self.bottomLayout.constant = 12;
    } else {
        self.typeLabel.hidden = NO;
        [self.typeLabel setTextColor:[UIColor colorWithHex:0xF25441FF]];
        [self.typeLabel setText:@"已拒绝"];
        self.agreeButton.hidden = YES;
        self.refuseButton.hidden = YES;
        self.bottomLayout.constant = 12;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
