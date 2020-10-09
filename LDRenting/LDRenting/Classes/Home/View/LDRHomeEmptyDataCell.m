//
//  LDRHomeEmptyDataCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/15.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomeEmptyDataCell.h"

@interface LDRHomeEmptyDataCell ()
@property (weak, nonatomic) IBOutlet UIImageView *dataImageView;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end

@implementation LDRHomeEmptyDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.dataLabel setTextColor:LDR_TextGrayColor];
    [self.dataLabel setText:@"暂无房屋动态"];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
