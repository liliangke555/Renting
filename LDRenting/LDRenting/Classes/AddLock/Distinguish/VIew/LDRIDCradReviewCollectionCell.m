//
//  LDRIDCradReviewCollectionCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/23.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRIDCradReviewCollectionCell.h"

@interface LDRIDCradReviewCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LDRIDCradReviewCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:[UIColor colorWithHex:0x858B9CFF]];
}

- (void)setBigImageString:(NSString *)bigImageString
{
    _bigImageString = bigImageString;
    [self.bigImageView setImage:[UIImage imageNamed:bigImageString]];
}
- (void)setTypeImageString:(NSString *)typeImageString
{
    _typeImageString = typeImageString;
    [self.typeImageView setImage:[UIImage imageNamed:typeImageString]];
}
- (void)setTitleS:(NSString *)titleS
{
    _titleS = titleS;
    [self.titleLabel setText:titleS];
}

@end
