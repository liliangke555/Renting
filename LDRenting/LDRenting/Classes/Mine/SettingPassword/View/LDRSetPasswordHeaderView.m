//
//  LDRSetPasswordHeaderView.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSetPasswordHeaderView.h"

@interface LDRSetPasswordHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *passTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *passDetail;

@end

@implementation LDRSetPasswordHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.passTotalLabel setTextColor:LDR_TextDarkGrayColor];
    [self.passDetail setTextColor:LDR_TextDarkGrayColor];
}
- (IBAction)buttonAction:(id)sender {
    if (self.didClickButton) {
        self.didClickButton();
    }
}
- (void)setDidClickButton:(void (^)(void))didClickButton
{
    _didClickButton = didClickButton;
}
@end
