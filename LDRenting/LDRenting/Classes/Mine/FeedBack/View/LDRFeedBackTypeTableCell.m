//
//  LDRFeedBackTypeTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRFeedBackTypeTableCell.h"

@interface LDRFeedBackTypeTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

@implementation LDRFeedBackTypeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.typeLabel setTextColor:LDR_TextGrayColor];
}
- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    [self.titleLabel setText:titleString];
}
- (void)setTypeString:(NSString *)typeString{
    _typeString = typeString;
    [self.typeLabel setText:typeString];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        [self.selectedImageView setImage:[UIImage imageNamed:@"circular_selected"]];
    } else {
        [self.selectedImageView setImage:[UIImage imageNamed:@"circular_normal"]];
    }
}

@end
