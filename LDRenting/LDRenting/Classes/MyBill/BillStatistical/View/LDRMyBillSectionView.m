//
//  LDRMyBillSectionView.m
//  LDRenting
//
//  Created by MAC on 2020/7/27.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMyBillSectionView.h"

@interface LDRMyBillSectionView ()

@end

@implementation LDRMyBillSectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = LDR_BackgroundColor;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(LDRPadding);
            make.centerY.equalTo(self);
            make.height.width.mas_equalTo(18);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).mas_offset(10);
            make.centerY.equalTo(imageView);
        }];
        [label setFont:LDRFont14];
        [label setTextColor:LDR_TextGrayColor];
        
        self.titleLabel = label;
        self.imageView = imageView;
    }
    return self;
}



@end
