//
//  LDRBaseTableViewCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/23.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

@implementation LDRBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}
- (void)addSubview:(UIView *)view
{
    if (![view isKindOfClass:[NSClassFromString(@"_UITableViewCellSeparatorView") class]] && view)
        [super addSubview:view];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
