//
//  LDRRemindView.m
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRemindView.h"

@interface LDRRemindView ()
@property (nonatomic, copy) void(^didClickButton)(void);
@end

@implementation LDRRemindView

- (instancetype)initWithTitle:(NSString *)title setImage:(void(^)(UIImageView *imageView))setImage close:(void(^)(void))didClose
{
    self = [super init];
    if (self) {
        if (setImage) {
            UIImageView *backImageView = [[UIImageView alloc] init];
            [self addSubview:backImageView];
            [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.right.equalTo(self).insets(UIEdgeInsetsZero);
            }];
            setImage(backImageView);
        }
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(LDRPadding/2.0f);
            make.centerY.equalTo(self);
        }];
        [label setFont:LDRFont12];
        [label setTextColor:LDR_BackgroundColor];
        [label setText:title];
        
        UIButton *button = [UIButton buttonWithTarget:self action:@selector(buttonAction:)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_offset(-LDRPadding /2.0f);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(12);
            make.left.equalTo(label.mas_right);
        }];
        [button setImage:[UIImage imageNamed:@"home_close_message"] forState:UIControlStateNormal];
        
        if (didClose) {
            self.didClickButton = didClose;
        }
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender
{
    if (self.didClickButton) {
        self.didClickButton();
    }
    [self removeFromSuperview];
}

@end
