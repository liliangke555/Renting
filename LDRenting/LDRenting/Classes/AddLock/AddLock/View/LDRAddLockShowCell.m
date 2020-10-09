//
//  LDRAddLockShowCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/20.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddLockShowCell.h"

@interface LDRAddLockShowCell ()
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end

@implementation LDRAddLockShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bigTitleLabel setTextColor:LDR_TextBalckColor];
    [self.detailLabel setTextColor:LDR_TextDarkGrayColor];
    [self.lineView setBackgroundColor:LDR_GrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
