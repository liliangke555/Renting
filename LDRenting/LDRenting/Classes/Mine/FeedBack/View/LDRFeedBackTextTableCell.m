//
//  LDRFeedBackTextTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRFeedBackTextTableCell.h"

@interface LDRFeedBackTextTableCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pleceholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation LDRFeedBackTextTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.pleceholderLabel setTextColor:LDR_TextGrayColor];
    [self.textView setTextColor:LDR_TextBalckColor];
    self.textView.delegate = self;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        self.pleceholderLabel.hidden = YES;
    }
    if (textView.text.length <= 0) {
        self.pleceholderLabel.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
