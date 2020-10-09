//
//  LDRToIDCardCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRToIDCardCell.h"

@interface LDRToIDCardCell ()
@property (weak, nonatomic) IBOutlet UILabel *bigTItleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation LDRToIDCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bigTItleLabel setTextColor:LDR_TextBalckColor];
    [self.detailTextLabel setTextColor:LDR_TextGrayColor];
    [self.backView.layer setCornerRadius:LDRRadius];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
