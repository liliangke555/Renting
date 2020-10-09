//
//  LDRProfitBonusHeader.m
//  LDRenting
//
//  Created by MAC on 2020/7/27.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRProfitBonusHeader.h"
#import "LDRExplainAlertView.h"

static CGFloat bottomHeight = 24;
@interface LDRProfitBonusHeader ()
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation LDRProfitBonusHeader
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
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backimageView.mas_right);
            make.bottom.equalTo(backimageView.mas_bottom);
        }];
        [imageView setImage:[UIImage imageNamed:@"profit_header_icon"]];
        
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
        
        UIButton *button = [UIButton buttonWithTarget:self action:@selector(buttonAction:)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.mas_bottom).mas_offset(-48.0f);
                    make.left.equalTo(self.mas_left).mas_offset(LDRPadding);
        }];
        [button.titleLabel setFont:LDRBoldFont24];
        [button setTitle:@"我的收益 " forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"profit_header_help"] forState:UIControlStateNormal];
        [button setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    }
    return self;
}
- (void)buttonAction:(UIButton *)sender
{
    if (self.didClickHelp) {
        self.didClickHelp();
    }
   
}
- (void)setDidClickHelp:(void (^)(void))didClickHelp
{
    _didClickHelp = didClickHelp;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
//    [self.bottomView clipCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:LDRControllerRadius];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
