//
//  LDRSetVolumeTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSetVolumeTableCell.h"

@interface LDRSetVolumeTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *silence;
@property (weak, nonatomic) IBOutlet UILabel *weakLabel;
@property (weak, nonatomic) IBOutlet UILabel *midLabel;
@property (weak, nonatomic) IBOutlet UILabel *hightLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation LDRSetVolumeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.silence setTextColor:LDR_MainGreenColor];
    [self.weakLabel setTextColor:LDR_TextGrayColor];
    [self.midLabel setTextColor:LDR_TextGrayColor];
    [self.hightLabel setTextColor:LDR_TextGrayColor];
}
- (IBAction)slideChange:(UISlider *)sender
{
    [self.silence setTextColor:LDR_TextGrayColor];
    [self.weakLabel setTextColor:LDR_TextGrayColor];
    [self.midLabel setTextColor:LDR_TextGrayColor];
    [self.hightLabel setTextColor:LDR_TextGrayColor];
    if (sender.value < 0.3) {
        sender.value = 0.0;
        [self.silence setTextColor:LDR_MainGreenColor];
    } else if (sender.value >= 0.3 && sender.value < 0.6) {
        sender.value = 0.33;
        [self.weakLabel setTextColor:LDR_MainGreenColor];
    } else if (sender.value >= 0.6 && sender.value < 0.9 ){
        sender.value = 0.68;
        [self.midLabel setTextColor:LDR_MainGreenColor];
    } else {
        sender.value = 1;
        [self.hightLabel setTextColor:LDR_MainGreenColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
