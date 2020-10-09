//
//  LDRUserCanOpenTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRUserCanOpenTableCell.h"

@interface LDRUserCanOpenTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UISwitch *selectorSwitch;


@end


@implementation LDRUserCanOpenTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titlesLabel setTextColor:LDR_TextBalckColor];
    [self.selectorSwitch setThumbTintColor:LDR_MainGreenColor];
    [self.selectorSwitch setOnTintColor:[UIColor colorWithHex:0xEEEEEECC]];
    
}
- (IBAction)changeSwitch:(UISwitch *)sender
{
    if (sender.on) {
        [self.selectorSwitch setThumbTintColor:LDR_MainGreenColor];
    } else {
        [self.selectorSwitch setThumbTintColor:[UIColor colorWithHex:0x62666488]];
    }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titlesLabel setText:title];
}

@end
