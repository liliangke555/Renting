//
//  LDRMineRemindView.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMineRemindView.h"

@implementation LDRMineRemindView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(12);
            make.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(8, 0, 8, 0));
            make.width.mas_equalTo(36);
        }];
        [imageView setImage:[UIImage imageNamed:@"login_header"]];
        [imageView.layer setCornerRadius:4.0f];
        [imageView setClipsToBounds:YES];
        
        UIButton *close = [UIButton buttonWithTarget:self action:@selector(closeButtonAction)];
        [self addSubview:close];
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_offset(-LDRPadding);
            make.centerY.equalTo(self);
        }];
        [close setImage:[UIImage imageNamed:@"home_close_message"] forState:UIControlStateNormal];
        
        UIButton *toButton = [UIButton buttonWithTarget:self action:@selector(toButtonAction)];
        [self addSubview:toButton];
        [toButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(close.mas_left).mas_offset(-18);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(24);
        }];
        [toButton setTitle:@"  去关注  " forState:UIControlStateNormal];
        [toButton.titleLabel setFont:LDRFont12];
        [toButton setTitleColor:[UIColor colorWithHex:0x333333FF] forState:UIControlStateNormal];
        [toButton setBackgroundImage:[UIImage ldr_imageWithColor:LDR_BackgroundColor] forState:UIControlStateNormal];
        [toButton.layer setCornerRadius:12.0f];
        [toButton setClipsToBounds:YES];
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).mas_offset(12);
            make.centerY.equalTo(self);
            make.right.equalTo(toButton.mas_left).mas_equalTo(-LDRPadding);
        }];
        [label setFont:LDRFont15];
        [label setTextColor:LDR_BackgroundColor];
        [label setNumberOfLines:0];
        [label setText:@"关注360租房公众号，获取消息通知更方便"];
        
        
    }
    return self;
}
- (void)closeButtonAction
{
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:LDRMineRemindState];
    [self removeFromSuperview];
}
-(void)toButtonAction
{
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:LDRMineRemindState];
}
@end
