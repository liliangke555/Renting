//
//  LDRLandlordOpenDoorHeaderView.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLandlordOpenDoorHeaderView.h"

@interface LDRLandlordOpenDoorHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *selectSwitch;
@end

@implementation LDRLandlordOpenDoorHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:0xF4F5F6FF];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(LDRPadding);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(32);
        }];
        self.imageView = imageView;
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).mas_offset(LDRPadding);
            make.centerY.equalTo(self);
        }];
        [label setFont:LDRBoldFont16];
//        [label setText:title];
        [label setTextColor:LDR_TextBalckColor];
        self.titleLabel = label;
        
        UISwitch *selectSwitch = [[UISwitch alloc] init];
        [self addSubview:selectSwitch];
        [selectSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_offset(-LDRPadding);
            make.centerY.equalTo(self);
        }];
        [selectSwitch addTarget:self action:@selector(selectSwitchAction:) forControlEvents:UIControlEventValueChanged];
        [selectSwitch setThumbTintColor:LDR_MainGreenColor];
        [selectSwitch setOnTintColor:[UIColor colorWithHex:0xFFFFFFFF]];
        self.selectSwitch = selectSwitch;
    }
    return self;
}
#pragma mark - IBAction
- (void)selectSwitchAction:(UISwitch *)sender
{
    if (sender.on) {
        [sender setThumbTintColor:LDR_MainGreenColor];
    } else {
        [sender setThumbTintColor:[UIColor colorWithHex:0x62666488]];
    }
}
#pragma mark - Setter
- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    [self.titleLabel setText:titleString];
}
- (void)setOpen:(BOOL)open
{
    _open = open;
    self.selectSwitch.on = open;
}
@end
