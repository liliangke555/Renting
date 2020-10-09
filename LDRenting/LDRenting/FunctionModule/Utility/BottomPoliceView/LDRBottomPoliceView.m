//
//  LDRBottomPoliceView.m
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBottomPoliceView.h"
static CGFloat bottomImageHeight = 40;

@interface LDRBottomPoliceView ()
@property (nonatomic, copy)void(^didClickAction)(void);
@property (nonatomic, strong) UIButton *button;
@end
@implementation LDRBottomPoliceView

- (instancetype)initWithButtonTitle:(NSString *)title action:(void(^)(void))action
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = LDR_BackgroundColor;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(LDR_WIDTH);
        }];
        
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(buttonAction:)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self).insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
        }];
        [button setTitle:title forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenColor]
                          forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateDisabled];
        button.enabled = NO;
        self.button = button;
        
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(imageView.mas_bottom);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).mas_offset(-LDRPadding - KBottomSafeHeight);
        }];
        [label setText:@"由公安提供安全服务，保障您的租房安全"];
        [label setTextColor:LDR_TextGrayColor];
        [label setFont:LDRFont12];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label.mas_top);
            make.centerX.equalTo(self);
            make.width.height.mas_equalTo(bottomImageHeight);
        }];
        [imageView setImage:[UIImage imageNamed:@"police_badge"]];
        [imageView setContentMode:UIViewContentModeCenter];
        
        if (action) {
            self.didClickAction = action;
        }
    }
    return self;
}
- (void)buttonAction:(UIButton *)sender
{
    if (self.didClickAction) {
        self.didClickAction();
    }
}
- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    self.button.enabled = enable;
}
@end
