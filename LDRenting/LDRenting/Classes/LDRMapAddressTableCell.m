//
//  LDRMapAddressTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/20.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMapAddressTableCell.h"

@interface LDRMapAddressTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *roadLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

@implementation LDRMapAddressTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.addressLabel setTextColor:LDR_TextBalckColor];
    [self.distanceLabel setTextColor:LDR_TextGrayColor];
    [self.roadLabel setTextColor:LDR_TextGrayColor];
}
- (void)setAddessString:(NSString *)addessString
{
    _addessString = addessString;
    [self.addressLabel setText:addessString];
}
- (void)setDistance:(CGFloat)distance
{
    _distance = distance;
    NSString *string = @"";
    if (distance > 1000) {
        string = [NSString stringWithFormat:@"%.0fkm内",distance / 1000];
    } else {
        string = [NSString stringWithFormat:@"%.0fm内",distance];
    }
    [self.distanceLabel setText:string];
}
- (void)setRoad:(NSString *)road
{
    _road = road;
    [self.roadLabel setText:road];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.selectedImageView setImage:[UIImage imageNamed:@"map_selected"]];
    } else {
        [self.selectedImageView setImage:[UIImage new]];
    }
}

@end
