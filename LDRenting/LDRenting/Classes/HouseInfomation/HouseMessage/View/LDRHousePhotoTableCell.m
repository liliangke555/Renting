//
//  LDRHousePhotoTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/6.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHousePhotoTableCell.h"

@interface LDRHousePhotoTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *photoView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation LDRHousePhotoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_tableTitleColor];
    
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    
    self.photoView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596781554246&di=9fbf7a873fcf0cfab70dcf20cd044667&imgtype=0&src=http%3A%2F%2Fpic.baike.soso.com%2Fp%2F20131221%2F20131221120816-121424558.jpg",
    @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2210317415,4037005254&fm=26&gp=0.jpg",
    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596781628159&di=989d7349d90a6286a51abaaaa6353e66&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D12870093%2C1410645732%26fm%3D214%26gp%3D0.jpg"];
    self.photoView.infiniteLoop = YES;
    self.photoView.autoScroll = YES;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat originW = self.backView.bounds.size.width;
    CGFloat originH = self.backView.bounds.size.height;
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(-2, 0, originW +4,originH )];
    self.backView.layer.shadowPath = path.CGPath;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
