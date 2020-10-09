//
//  LDRAddFlagCollectionReusableView.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddFlagCollectionReusableView.h"
@interface LDRAddFlagCollectionReusableView ()

@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UIButton *moreButton;

@end
@implementation LDRAddFlagCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *title = [[UILabel alloc] init];
        [self addSubview:title];
        [title setFont:LDRFont12];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self).insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding, LDRPadding));
        }];
        [title setTextColor:LDR_tableTitleColor];
        self.titleLabel = title;
    }
    return self;
}
#pragma mark - Setter

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.titleLabel.text = titleString;
}
@end
