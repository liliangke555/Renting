//
//  LDRMyReningHeaderView.m
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMyReningHeaderView.h"

static CGFloat const bottomHeight = 24.0f;

@interface LDRMyReningHeaderView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation LDRMyReningHeaderView

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        UIImageView *backimageView = [[UIImageView alloc] init];
        [self addSubview:backimageView];
        [backimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        [backimageView setImage:[UIImage imageNamed:@"profit_header_background"]];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backimageView.mas_right).mas_offset(LDRPadding);
            make.bottom.equalTo(backimageView.mas_bottom).mas_offset(-45);
        }];
        [imageView setImage:[UIImage imageNamed:@"myrenting_header_icon"]];
    
//        UIView *view = [[UIView alloc] init];
//        [self addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.mas_bottom);
//            make.left.equalTo(self.mas_left);
//            make.right.equalTo(self.mas_right);
//            make.height.mas_equalTo(bottomHeight);
//        }];
//        [view setBackgroundColor:LDR_BackgroundColor];
//        self.bottomView = view;
        
        if (title.length > 0) {
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).mas_offset(LDRPadding);
                make.bottom.equalTo(self.mas_bottom).mas_offset(-100);
            }];
            [label setFont:LDRBoldFont24];
            [label setTextColor:LDR_BackgroundColor];
            [label setText:title];
//            self.titleLabel = label;
        }
        
        UIView *textBackView = [[UIView alloc] init];
        [self addSubview:textBackView];
        [textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).mas_offset(-49);
            make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(30);
        }];
        [textBackView setBackgroundColor:[UIColor colorWithHex:0x263345FF]];
        [textBackView.layer setCornerRadius:15];
        
        UITextField *textField = [[UITextField alloc] init];
        [textBackView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.equalTo(textBackView).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
        }];
        
        NSString *title = @"搜索姓名";
        NSDictionary *attributes = @{
            NSFontAttributeName:LDRFont14,
            NSForegroundColorAttributeName:LDR_TextGrayColor
        };
        [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
        
        [textField setLeftViewMode:UITextFieldViewModeAlways];
        UIImageView *textRightView = [[UIImageView alloc] init];
        [textField setLeftView:textRightView];
        [textRightView setImage:[UIImage imageNamed:@"myrenting_search_icon"]];
        textField.delegate = self;
        [textField setReturnKeyType:UIReturnKeySearch];
        [textField setTextColor:LDR_BackgroundColor];
        [textField setFont:LDRFont14];
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    if ([self.delegate respondsToSelector:@selector(didToSearchText:)]) {
        [self.delegate didToSearchText:textField.text];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    [self.bottomView clipCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:LDRControllerRadius];
}

@end
