//
//  LDRHouseInfomationHeader.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseInfomationHeader.h"
@interface LDRHouseInfomationHeader ()
@property (nonatomic, copy) void(^didClickLeft)(void);
@property (nonatomic, copy) void(^didClickRight)(void);
@end
@implementation LDRHouseInfomationHeader
- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail leftAction:(void(^)(void))leftAction rightAction:(void(^)(void))rightAction
{
    self = [super initWithTitle:title details:detail image:nil];
    if (self) {
        MASViewAttribute *lastAttr = self.mas_right;
        if (rightAction) {
            UIButton *right = [UIButton buttonWithTarget:self action:@selector(rightAction:)];
            [self addSubview:right];
            [right mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom).mas_offset(-bottomHeight-LDRPadding);
                make.right.equalTo(lastAttr).mas_offset(-LDRPadding);
                make.width.height.mas_equalTo(40);
            }];
            [right setImage:[UIImage imageNamed:@"houseInfo_setting"] forState:UIControlStateNormal];
            lastAttr = right.mas_left;
            self.didClickRight = rightAction;
        }
        
        if (leftAction) {
            UIButton *left = [UIButton buttonWithTarget:self action:@selector(leftAction:)];
            [self addSubview:left];
            [left mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom).mas_offset(-bottomHeight-LDRPadding);
                make.right.equalTo(lastAttr).mas_offset(-LDRPadding);
                make.width.height.mas_equalTo(40);
            }];
            [left setImage:[UIImage imageNamed:@"houseinfo_lock"] forState:UIControlStateNormal];
            self.didClickLeft = leftAction;
        }
    }
    return self;
}

- (void)rightAction:(UIButton *)sender
{
    if (self.didClickRight) {
        self.didClickRight();
    }
}
- (void)leftAction:(UIButton *)sender
{
    if (self.didClickLeft) {
        self.didClickLeft();
    }
}
@end
