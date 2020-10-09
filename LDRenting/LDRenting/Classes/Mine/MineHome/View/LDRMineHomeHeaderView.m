//
//  LDRMineHomeHeaderView.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMineHomeHeaderView.h"
@interface LDRMineHomeHeaderView ()
@property (nonatomic, strong) UIButton *nameButton;
@property (nonatomic, strong) UILabel *phoneLabel;
@end
@implementation LDRMineHomeHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIImageView *backimageView = [[UIImageView alloc] init];
        [self addSubview:backimageView];
        [backimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        [backimageView setImage:[UIImage imageNamed:@"profit_header_background"]];
        
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(backimageView.mas_right);
                make.bottom.equalTo(backimageView.mas_bottom);
            }];
            [imageView setImage:[UIImage imageNamed:@"mine_header_icon"]];
        }
        
        UIImageView *headerImageView = [[UIImageView alloc] init];
        [self addSubview:headerImageView];
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(LDRPadding);
            make.bottom.equalTo(self.mas_bottom).mas_offset(-LDRPadding);
            make.width.height.mas_equalTo(56);
        }];
        [headerImageView setImage:[UIImage imageNamed:@"no_login_header"]];
        
        UIButton *button = [UIButton buttonWithTarget:self action:@selector(buttonAction:)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerImageView.mas_top);
            make.left.equalTo(headerImageView.mas_right).mas_offset(LDRPadding);
        }];
        [button.titleLabel setFont:LDRBoldFont18];
        [button setTitleColor:LDR_BackgroundColor forState:UIControlStateNormal];
        [button setTitle:@"立即登录" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"right_to_icon"] forState:UIControlStateNormal];
        [button setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        self.nameButton = button;
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerImageView.mas_right).mas_offset(LDRPadding);
            make.bottom.equalTo(headerImageView.mas_bottom);
        }];
        [label setFont:LDRFont13];
        [label setTextColor:LDR_TextGrayColor];
        [label setText:@"房屋出租就找360租房"];
        self.phoneLabel = label;
    }
    return self;
}
- (void)buttonAction:(UIButton *)sender
{
    if (!self.isLogin) {
        [[LDRRootConfig sharedRootConfig] toLogin];
    }
}
- (void)setName:(NSString *)name
{
    _name = name;
    [self.nameButton setTitle:name forState:UIControlStateNormal];
    [self.nameButton setTitle:name forState:UIControlStateSelected];
    [self.nameButton setImage:[UIImage imageNamed:@"mine_authenticate_no"] forState:UIControlStateNormal];
    [self.nameButton setImage:[UIImage imageNamed:@"mine_authenticate_yes"] forState:UIControlStateSelected];
}
- (void)setPhone:(NSString *)phone
{
    _phone =phone;
    [self.phoneLabel setText:phone];
}
- (void)setAuthentication:(BOOL)authentication
{
    _authentication = authentication;
    [self.nameButton setSelected:authentication];
}
- (void)setLogin:(BOOL)login
{
    _login = login;
    if (!login) {
        [self.nameButton setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.nameButton setTitle:@"立即登录" forState:UIControlStateSelected];
        [self.nameButton setImage:[UIImage imageNamed:@"right_to_icon"] forState:UIControlStateNormal];
        [self.nameButton setImage:[UIImage imageNamed:@"right_to_icon"] forState:UIControlStateSelected];
        [self.phoneLabel setText:@"房屋出租就找360租房"];
    }
}
@end
