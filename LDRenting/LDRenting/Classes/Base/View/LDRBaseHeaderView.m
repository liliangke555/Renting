//
//  LDRBaseHeaderView.m
//  LDRenting
//
//  Created by MAC on 2020/7/28.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseHeaderView.h"


@interface LDRBaseHeaderView ()
//@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation LDRBaseHeaderView

- (instancetype)initWithTitle:(NSString *)title details:(NSString *)details image:(void(^)(UIImageView *image))setImage
{
    self = [super init];
    if (self) {
        
        UIImageView *backimageView = [[UIImageView alloc] init];
        [self addSubview:backimageView];
        [backimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        [backimageView setImage:[UIImage imageNamed:@"profit_header_background"]];
        
        if (setImage) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(backimageView.mas_right);
                make.bottom.equalTo(backimageView.mas_bottom);
            }];
            setImage(imageView);
        }
        
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
            }];
            [label setFont:LDRBoldFont24];
            [label setTextColor:LDR_BackgroundColor];
            [label setText:title];
            self.titleLabel = label;
        }
        if (details.length > 0) {
            [self.titleLabel setFont:LDRBoldFont18];
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).mas_offset(LDRPadding);
                make.bottom.equalTo(self.mas_bottom).mas_offset(-LDRPadding-bottomHeight);
            }];
            [label setFont:LDRFont12];
            [label setTextColor:LDR_BackgroundColor];
            [label setText:details];
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(label.mas_top).mas_offset(-8);
            }];
        } else {
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom).mas_offset(-24-bottomHeight);
            }];
        }
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    [self.bottomView clipCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:LDRControllerRadius];
}

@end
