//
//  LDRRenatsInfoBottomCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRenatsInfoBottomCell.h"

@interface LDRRenatsInfoBottomCell ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UIView *backGView;

@end

@implementation LDRRenatsInfoBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self.button setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    [self.button setTitleColor:LDR_TextBalckColor forState:UIControlStateNormal];
    [self.button setTitleColor:LDR_TextBalckColor forState:UIControlStateSelected];
    [self.button setTitle:@"收起" forState:UIControlStateSelected];
    [self.button setTitle:@"更多信息" forState:UIControlStateNormal];
    self.button.userInteractionEnabled = NO;
    
    
    [self.backGView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.backGView.layer setShadowRadius:LDRShadowRadius];
    [self.backGView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backGView.layer setShadowOpacity:1.0f];
    [self.backGView.layer setCornerRadius:LDRRadius];
}
- (void)setOpen:(BOOL)open
{
    _open = open;
    self.button.selected = open;
}

- (void)layoutSubviews
{
    CGFloat originW = LDR_WIDTH - 32;
    CGFloat originH = self.backGView.bounds.size.height;
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(-2, 0, originW +4,originH + 2 )];
    self.backGView.layer.shadowPath = path.CGPath;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
