//
//  LDRHouseInfoEmptyView.m
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseInfoEmptyView.h"

@interface LDRHouseInfoEmptyView ()
@property (nonatomic, copy) void(^didClickButton)(void);
@end

@implementation LDRHouseInfoEmptyView

- (instancetype)initWithTitle:(NSString *)title setImage:( void(^ _Nullable)(UIImageView *imageView))setImage buttonTitle:(NSString * _Nullable)buttonTitle buttonAction:(void(^ _Nullable)(void))buttonAction
{
    self = [super init];
    if (self) {
        MASViewAttribute *lasterAttribute = self.mas_top;
        if (setImage) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lasterAttribute).mas_offset(LDRPadding);
                make.centerX.equalTo(self);
            }];
            setImage(imageView);
            lasterAttribute = imageView.mas_bottom;
        }
        if (title.length > 0) {
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lasterAttribute).mas_offset(LDRPadding);
                make.centerX.equalTo(self);
            }];
            [label setTextColor:LDR_TextGrayColor];
            [label setFont:LDRFont16];
            [label setText:title];
            lasterAttribute = label.mas_bottom;
        }
        if (buttonAction) {
            UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(buttonAction:)];
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lasterAttribute).mas_offset(2*LDRPadding);
                make.centerX.equalTo(self);
                make.height.mas_equalTo(LDRButtonHeight);
                make.width.mas_equalTo(160);
            }];
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            lasterAttribute = button.mas_bottom;
            self.didClickButton = buttonAction;
        }
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lasterAttribute).mas_offset(LDRPadding);
        }];
    }
    return self;
}
- (void)buttonAction:(UIButton *)sender
{
    if (self.didClickButton) {
        self.didClickButton();
    }
}
- (void)setDidClickButton:(void (^)(void))didClickButton
{
    _didClickButton = didClickButton;
}
@end
