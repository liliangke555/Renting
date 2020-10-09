//
//  LDRRenantsFlagCollectionViewCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRenantsFlagCollectionViewCell.h"

@interface LDRRenantsFlagCollectionViewCell ()


@end

@implementation LDRRenantsFlagCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.textLabel.layer setCornerRadius:2.0f];
    [self.textLabel setClipsToBounds:YES];
}

- (void)setFlagType:(LDRFlagType)flagType
{
    _flagType = flagType;
    if (flagType == LDRFlagTypeGood) {
        [self.textLabel setTextColor:LDR_MainGreenColor];
        [self.textLabel setBackgroundColor:[UIColor colorWithRed:33/255.0f green:199/255.0f blue:103/255.0f alpha:0.1]];
    } else if (flagType == LDRFlagTypeWarning) {
        [self.textLabel setTextColor:[UIColor colorWithHex:0xFD9515FF]];
        [self.textLabel setBackgroundColor:[UIColor colorWithRed:253/255.0f green:149/255.0f blue:21/255.0f alpha:0.1]];
    } else {
        [self.textLabel setTextColor:[UIColor colorWithHex:0xF25441FF]];
        [self.textLabel setBackgroundColor:[UIColor colorWithRed:242/255.0f green:84/255.0f blue:65/255.0f alpha:0.1]];
    }
}

@end
