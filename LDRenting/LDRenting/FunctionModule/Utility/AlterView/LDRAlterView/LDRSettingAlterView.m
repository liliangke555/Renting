//
//  LDRSettingAlterView.m
//  LDRenting
//
//  Created by MAC on 2020/7/24.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSettingAlterView.h"

@interface LDRSettingAlterView ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, copy) MMPopupItemHandler cancelHandler;
@end

@implementation LDRSettingAlterView

- (instancetype)initWithTitle:(NSString *)title details:(NSString *)detail type:(NSString *)type loadImage:(void(^)(UIImageView *imageView))loadImage cancel:(MMPopupItemHandler)cancelHandler;
{
    self = [super init];
    if (self) {
        LDRAlertViewConfig *config = [LDRAlertViewConfig globalConfig];
        self.type = LDRPopupTypeSheet;
        
        self.layer.cornerRadius = config.cornerRadius;
        self.clipsToBounds = YES;
        self.backgroundColor = config.backgroundColor;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(config.width);
        }];
        MASViewAttribute *lastAttribute = self.mas_top;
        
        self.headerView = [[UIView alloc] init];
        [self addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute);
            make.left.right.equalTo(self);
        }];
        [self.headerView setBackgroundColor:config.headerBackgroundColor];
        lastAttribute = self.headerView.mas_top;
        
        if (title.length > 0) {
            
            UILabel *label = [[UILabel alloc] init];
            [self.headerView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).mas_offset(config.topInnerMargin);
                make.centerX.equalTo(self);
            }];
            [label setFont:[UIFont systemFontOfSize:config.titleFontSize]];
            [label setTextColor:config.titleColor];
            [label setText:title];
            lastAttribute = label.mas_bottom;
        }
        if (detail.length > 0) {
            
//            UIView *lineView = [[UIView alloc] init];
//            [self.headerView addSubview:lineView];
//            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(lastAttribute).mas_offset(config.topInnerMargin);
//                make.left.right.equalTo(self.headerView).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
//                make.height.mas_equalTo(0.5f);
//            }];
//            [lineView setBackgroundColor:config.detailColor];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).mas_offset(config.topInnerMargin);
                make.left.right.equalTo(self.headerView).insets(UIEdgeInsetsMake(0, config.topInnerMargin, 0, config.topInnerMargin));
                make.height.mas_equalTo(0.5f);
            }];
            [imageView setImage:[UIImage imageNamed:@"setting_alter_line"]];
            lastAttribute = imageView.mas_bottom;
            
            
            UILabel *label = [[UILabel alloc] init];
            [self.headerView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(imageView);
                make.bottom.equalTo(self.headerView.mas_bottom).mas_equalTo(-config.topInnerMargin);
            }];
            [label setFont:[UIFont systemFontOfSize:config.detailFontSize]];
            [label setTextColor:config.detailColor];
            [label setBackgroundColor:config.headerBackgroundColor];
            [label setText:detail];
            lastAttribute = label.mas_bottom;
        }
        lastAttribute = self.headerView.mas_bottom;
        
        if (loadImage) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).mas_offset(60);
                make.centerX.equalTo(self);
            }];
            loadImage(imageView);
            lastAttribute = imageView.mas_bottom;
            self.imageView = imageView;
        }
        if (type.length > 0) {
            UILabel *label = [[UILabel alloc] init];
            [self.headerView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).mas_offset(config.innerMargin * 2);
                make.centerX.equalTo(self);
            }];
            [label setFont:[UIFont systemFontOfSize:config.buttonFontSize]];
            [label setTextColor:config.typeColor];
            [label setText:type];
            lastAttribute = label.mas_bottom;
            self.typeLabel = label;
        }
        
        if (cancelHandler) {
            self.cancelHandler = cancelHandler;
        }
        
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(actionButton:)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).mas_offset(config.innerMargin * 2);
            make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
            make.height.mas_equalTo(config.buttonHeight);
        }];
        [button setTitle:config.defaultTextCancel forState:UIControlStateNormal];
        [button setTitleColor:LDR_MainGreenColor forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage ldr_imageWithColor:LDR_GrayColor] forState:UIControlStateSelected];
        button.selected = YES;
        lastAttribute = button.mas_bottom;
        self.button = button;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(lastAttribute).mas_offset(LDRPadding);
            
        }];
    }
    return self;
}
#pragma mark - IBAction
- (void)actionButton:(UIButton*)sender
{
    if (sender.isSelected) {
        if (self.cancelHandler) {
            self.cancelHandler(0);
        }
        [self hide];
    } else {
        [self hide];
    }
}
#pragma mark - Setter
- (void)setTypeString:(NSString *)typeString
{
    _typeString = typeString;
    [self.typeLabel setText:typeString];
}
- (void)setIsCompletion:(BOOL)isCompletion
{
    _isCompletion = isCompletion;
    LDRAlertViewConfig *config = [LDRAlertViewConfig globalConfig];
    self.button.selected = !isCompletion;
    [self.button setTitle:config.defaultTextConfirm forState:UIControlStateNormal];
}
- (void)setCompletionImage:(NSString *)completionImage
{
    _completionImage = completionImage;
    [self.imageView setImage:[UIImage imageNamed:completionImage]];
}
@end

@interface LDRAlertViewConfig()

@end

@implementation LDRAlertViewConfig

+ (LDRAlertViewConfig *)globalConfig
{
    static LDRAlertViewConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [LDRAlertViewConfig new];
        
    });
    
    return config;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.topInnerMargin = 25.0f;
        self.width          = LDR_WIDTH - 2 * LDRPadding;
        self.buttonHeight   = LDRButtonHeight;
        self.innerMargin    = LDRPadding;
        self.cornerRadius   = LDRRadius;

        self.titleFontSize  = 17.0f;
        self.detailFontSize = 14.0f;
        self.buttonFontSize = 16.0f;
        
        self.backgroundColor    = MMHexColor(0xFFFFFFFF);
        self.headerBackgroundColor = MMHexColor(0x4F5D70FF);
        self.titleColor         = MMHexColor(0xFFFFFFFF);
        self.detailColor        = MMHexColor(0xFFFFFFFF);
        self.typeColor         = LDR_TextBalckColor;

        self.itemNormalColor    = MMHexColor(0x626664FF);
        self.itemHighlightColor = MMHexColor(0xE76153FF);
        self.itemPressedColor   = MMHexColor(0xEFEDE7FF);
        
        self.defaultTextCancel  = @"取消";
        self.defaultTextConfirm = @"完成";
    }
    
    return self;
}

@end
