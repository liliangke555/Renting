//
//  LDRSelectLocationCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSelectLocationCell.h"

@interface LDRSelectLocationCell ()
@property (weak, nonatomic) IBOutlet UILabel *bigTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@end

@implementation LDRSelectLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.bigTitleLabel setTextColor:LDR_TextBalckColor];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.bigTitleLabel.text = title;
}
- (void)setDetails:(NSString *)details
{
    _details = details;
    self.textField.text = details;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
