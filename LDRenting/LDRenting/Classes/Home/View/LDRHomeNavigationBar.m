//
//  LDRHomeNavigationBar.m
//  LDRenting
//
//  Created by MAC on 2020/7/17.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomeNavigationBar.h"

@interface LDRHomeNavigationBar ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, strong) CAGradientLayer *gradient;
@end

@implementation LDRHomeNavigationBar

- (instancetype)initWithLogin:(BOOL)isLogin
{
    self = [super init];
    if (self) {
        UIButton *button = [UIButton buttonWithTarget:self action:@selector(leftButtonAction:)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).mas_offset(-8);
            make.left.equalTo(self.mas_left).mas_offset(LDRPadding);
            make.width.mas_equalTo(140);
            make.height.mas_equalTo(28);
        }];
        [button setImage:[UIImage imageNamed:@"no_login_header"] forState:UIControlStateNormal];
        [button.titleLabel setFont:LDRFont16];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.leftButton = button;
        
        
    }
    return self;
}
#pragma mark - IBAction
- (void)leftButtonAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(leftButtonDidClick)]) {
        [self.delegate leftButtonDidClick];
    }
}
- (void)rightButtonAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(rightButtonDidClick)]) {
        [self.delegate rightButtonDidClick];
    }
}
- (void)closeMessageAction:(UIButton *)sender
{
    self.messageView.hidden = YES;
    [self.messageView removeFromSuperview];
}
#pragma mark - Public
- (void)changeBackgroundColorWithContentoff:(CGPoint)content
{
    CGFloat y = content.y;
//    if (y > LDRHomeHeaderHeight + 1 || y < LDRHomeHeaderHeight - 10) {
//        return;
//    }
    if (!self.isLogin) {
        return;
    }
    if (y >= LDRHomeHeaderHeight) {
        self.gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0xFFFFFF] CGColor],nil];
        [self.leftButton setTitleColor:LDR_TextBalckColor forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"home_addlock_black"] forState:UIControlStateNormal];
    } else {
        
        self.gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x263345FF] CGColor], (id)[[UIColor colorWithHex:0x4F5D70FF] CGColor],nil];
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"home_add_clock"] forState:UIControlStateNormal];
    }
}

#pragma mark - Setter
- (void)setNameString:(NSString *)nameString
{
    _nameString = nameString;
    [self.leftButton setTitle:nameString forState:UIControlStateNormal];
}

- (void)setLogin:(BOOL)login
{
    _login = login;
    if (login) {
        [self messageView];
        self.rightButton.hidden = NO;
        self.messageView.hidden = NO;
        [self.leftButton setTitle:@" Hi 大菠萝" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x263345FF] CGColor], (id)[[UIColor colorWithHex:0x4F5D70FF] CGColor],nil];
    } else {
        [self.leftButton setTitle:@" 请先登录/注册" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:LDR_TextBalckColor forState:UIControlStateNormal];
        self.gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0xFFFFFF] CGColor],nil];
        self.messageView.hidden = YES;
        self.rightButton.hidden = YES;
    }
}
#pragma mark - Getter

- (CAGradientLayer *)gradient
{
    if (!_gradient) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
            //渐变色
    //    gradient.frame = self.bounds;
        gradient.startPoint = CGPointMake(0, 0.5);
        gradient.endPoint = CGPointMake(1, 0.5);
        [self.layer insertSublayer:gradient atIndex:0];
        _gradient = gradient;
    }
    return _gradient;
}
- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithTarget:self action:@selector(rightButtonAction:)];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).mas_offset(-8);
            make.right.equalTo(self.mas_right).mas_offset(-LDRPadding);
            make.height.width.mas_equalTo(28);
        }];
        [_rightButton setImage:[UIImage imageNamed:@"home_add_clock"] forState:UIControlStateNormal];
    }
    return _rightButton;
}

- (UIView *)messageView
{
    if (!_messageView) {
        _messageView = [[UIView alloc] init];
        [self addSubview:_messageView];
        [_messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rightButton);
            make.right.equalTo(self.rightButton.mas_left).mas_offset(-2);
        }];
        UIImageView *imageView = [[UIImageView alloc] init];
        [_messageView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_messageView).with.insets(UIEdgeInsetsZero);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(24);
        }];
        [imageView setImage:[UIImage imageNamed:@"home_addclock_mssage"]];
        UIButton *button = [UIButton buttonWithTarget:self action:@selector(closeMessageAction:)];
        [_messageView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_messageView);
            make.right.equalTo(_messageView.mas_right).mas_offset(-9);
            make.width.height.mas_equalTo(16);
        }];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button setImage:[UIImage imageNamed:@"home_close_message"] forState:UIControlStateNormal];
        
        UILabel *label = [[UILabel alloc] init];
        [_messageView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(_messageView);
            make.right.equalTo(button.mas_left);
        }];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:LDRFont12];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"点击这里快速添加门锁"];
        
        
    }
    return _messageView;
}
#pragma mark - Layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gradient.frame = self.bounds;
}

@end
