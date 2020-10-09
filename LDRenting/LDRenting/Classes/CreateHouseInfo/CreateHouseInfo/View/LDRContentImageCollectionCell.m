//
//  LDRContentImageCollectionCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRContentImageCollectionCell.h"
@interface LDRContentImageCollectionCell ()

@end

@implementation LDRContentImageCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)deleteButtonAction:(UIButton *)sender
{
    if (self.didDelete) {
        self.didDelete();
    }
}
- (void)setDidDelete:(void (^)(void))didDelete
{
    _didDelete = didDelete;
}
@end
