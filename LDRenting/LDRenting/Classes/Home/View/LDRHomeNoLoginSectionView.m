//
//  LDRHomeSectionView.m
//  LDRenting
//
//  Created by MAC on 2020/7/15.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomeNoLoginSectionView.h"

@implementation LDRHomeNoLoginSectionView

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    self = [super init];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(LDRPadding);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(28);
        }];
        [imageView setImage:[UIImage imageNamed:LDRNoLoginHeader]];
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).mas_offset(8);
            make.centerY.equalTo(imageView);
        }];
        [label setFont:LDRFont16];
        [label setTextColor:LDR_TextBalckColor];
        [label setText:LDRLoginOrRegist];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    }
    return self;
}

@end
