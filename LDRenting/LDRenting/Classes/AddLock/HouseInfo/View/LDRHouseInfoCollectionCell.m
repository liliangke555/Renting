//
//  LDRHouseInfoCollectionCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseInfoCollectionCell.h"

@interface LDRHouseInfoCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation LDRHouseInfoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.detailsLabel setTextColor:LDR_TextGrayColor];
    [self.backView.layer setCornerRadius:LDRRadius];
    
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titleLabel setText:title];
}
- (void)setDetails:(NSString *)details
{
    _details = details;
    [self.detailsLabel setText:details];
}
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self.bigImageView setImage:[UIImage imageNamed:imageUrl]];
}

@end
