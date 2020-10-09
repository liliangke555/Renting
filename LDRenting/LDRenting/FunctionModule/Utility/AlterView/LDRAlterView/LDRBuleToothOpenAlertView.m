//
//  LDRBuleToothOpenAlertView.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBuleToothOpenAlertView.h"
@interface LDRBuleToothOpenAlertView ()
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation LDRBuleToothOpenAlertView

- (instancetype)initWithTitle:(NSString *)title;
{
    self = [super init];
    if (self) {
        
        self.type = LDRPopupTypeAlert;
        self.layer.cornerRadius = 12.0f;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor colorWithHex:0x3864D0FF];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(LDR_WIDTH - LDRPadding * 2);
        }];
        
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).mas_offset(LDRPadding);
            make.centerX.equalTo(self);
        }];
        [imageView setImage:[UIImage imageNamed:@"bule_openning"]];
        self.imageView= imageView;
        lastAttribute = imageView.mas_bottom;
        
        UILabel *typeLabel = [[UILabel alloc] init];
        [self addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).mas_offset(LDRPadding);
            make.centerX.equalTo(imageView);
        }];
        [typeLabel setFont:LDRFont16];
        [typeLabel setTextColor:LDR_BackgroundColor];
        [typeLabel setText:@"蓝牙开门中"];
        self.typeLabel = typeLabel;
        lastAttribute = typeLabel.mas_bottom;
        
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).mas_offset(LDRPadding);
            make.left.right.bottom.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        [bottomView setBackgroundColor:LDR_BackgroundColor];
        
        lastAttribute = bottomView.mas_bottom;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [bottomView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(bottomView).insets(UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding, LDRPadding));
        }];
        [titleLabel setFont:LDRFont16];
        [titleLabel setTextColor:LDR_TextDarkGrayColor];
        [titleLabel setText:title];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastAttribute);
        }];
    }
    return self;
}
- (void)setOpenType:(LDRBuleToothOpenType)openType
{
    _openType = openType;
    if (openType == LDRBuleToothOpening) {
        [self.imageView setImage:[UIImage imageNamed:@"bule_openning"]];
        [self.typeLabel setText:@"蓝牙开门中"];
    } else if (openType == LDRBuleToothOpenSuccesse) {
        [self.imageView setImage:[UIImage imageNamed:@"bule_open_success"]];
        [self.typeLabel setText:@"蓝牙开门成功（3s）"];
        self.backgroundColor = LDR_MainGreenColor;
        [self setTime];
    } else {
        [self.imageView setImage:[UIImage imageNamed:@"bule_open_failure"]];
        [self.typeLabel setText:@"蓝牙开门失败（3s）"];
        self.backgroundColor = LDR_TextGrayColor;
        [self setTime];
    }
}

- (void)setTime
{
    LDRWeakify(self);
    __block  int i = 3;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        i--;
        if (i < 0) {
            //计时器取消
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf hide];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.openType == LDRBuleToothOpenSuccesse) {
                    [weakSelf.typeLabel setText:[NSString stringWithFormat:@"蓝牙开门成功（%ds）",i]];
                } else {
                    [weakSelf.typeLabel setText:[NSString stringWithFormat:@"蓝牙开门失败（%ds）",i]];
                }
            });
        }
    });
    dispatch_resume(timer);
}
//- hid
@end
