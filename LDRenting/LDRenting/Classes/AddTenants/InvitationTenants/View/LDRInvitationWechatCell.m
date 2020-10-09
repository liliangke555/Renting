//
//  LDRInvitationWechatCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRInvitationWechatCell.h"

@interface LDRInvitationWechatCell ()
@property (weak, nonatomic) IBOutlet UIView *oneBackView;
@property (weak, nonatomic) IBOutlet UIView *twoBackView;
@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UILabel *wechatTitle;
@property (weak, nonatomic) IBOutlet UILabel *wechatDetail;
@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UILabel *messageDetail;

@end

@implementation LDRInvitationWechatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.oneBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickOneBackView:)]];
    [self.twoBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTwoBackView:)]];
    [self.oneBackView.layer setCornerRadius:LDRRadius];
    [self.twoBackView.layer setCornerRadius:LDRRadius];
    
    [self.oneBackView.layer setBorderColor:LDR_MainGreenColor.CGColor];
    [self.oneBackView.layer setBorderWidth:1.0f];
    [self.oneBackView setBackgroundColor:LDR_BackgroundColor];
    
    [self.twoBackView.layer setBorderWidth:1.0f];
    [self.twoBackView.layer setBorderColor:[UIColor colorWithHex:0xF4F5F6FF].CGColor];
    
    [self.messageTitle setTextColor:LDR_TextBalckColor];
    [self.messageDetail setTextColor:LDR_TextGrayColor];
    [self.twoImageView setImage:[UIImage imageNamed:@"circular_normal"]];
    
    [self.wechatTitle setTextColor:LDR_TextBalckColor];
    [self.wechatDetail setTextColor:LDR_TextBalckColor];
    [self.oneImageView setImage:[UIImage imageNamed:@"circular_selected"]];
}

- (void)didClickOneBackView:(UITapGestureRecognizer *)sender
{
    [self.twoBackView setBackgroundColor:[UIColor colorWithHex:0xF4F5F6FF]];
    [self.twoBackView.layer setBorderColor:[UIColor colorWithHex:0xF4F5F6FF].CGColor];
    [self.messageDetail setTextColor:LDR_TextGrayColor];
    [self.twoImageView setImage:[UIImage imageNamed:@"circular_normal"]];
    
    [self.wechatDetail setTextColor:LDR_TextBalckColor];
    [self.oneImageView setImage:[UIImage imageNamed:@"circular_selected"]];
    [self.oneBackView.layer setBorderColor:LDR_MainGreenColor.CGColor];
    [self.oneBackView setBackgroundColor:LDR_BackgroundColor];
}
- (void)didClickTwoBackView:(UITapGestureRecognizer *)sender
{
    [self.oneBackView setBackgroundColor:[UIColor colorWithHex:0xF4F5F6FF]];
    [self.oneBackView.layer setBorderColor:[UIColor colorWithHex:0xF4F5F6FF].CGColor];
    [self.wechatDetail setTextColor:LDR_TextGrayColor];
    [self.oneImageView setImage:[UIImage imageNamed:@"circular_normal"]];
    
    [self.messageDetail setTextColor:LDR_TextBalckColor];
    [self.twoImageView setImage:[UIImage imageNamed:@"circular_selected"]];
    [self.twoBackView.layer setBorderColor:LDR_MainGreenColor.CGColor];
    [self.twoBackView setBackgroundColor:LDR_BackgroundColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
