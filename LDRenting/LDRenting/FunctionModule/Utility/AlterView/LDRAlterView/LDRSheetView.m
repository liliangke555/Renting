//
//  LDRSheetView.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSheetView.h"
@interface LDRSheetView ()
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIView      *titleView;
@property (nonatomic, strong) UIView      *buttonView;
@property (nonatomic, strong) UIButton    *cancelButton;

@property (nonatomic, strong) NSArray     *actionItems;
@end
@implementation LDRSheetView

- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items
{
    self = [super init];
    if (self) {
        self.type = MMPopupTypeSheet;
        self.actionItems = items;
        self.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(LDR_WIDTH);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        if ( title.length > 0 )
        {
            self.titleView = [UIView new];
            [self addSubview:self.titleView];
            [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self);
            }];
            self.titleView.backgroundColor = LDR_BackgroundColor;
            
            self.titleLabel = [UILabel new];
            [self.titleView addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.titleView).insets(UIEdgeInsetsMake(24, 24, 24, 24));
            }];
            self.titleLabel.textColor = LDR_TextGrayColor;
            self.titleLabel.font = LDRFont16;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.text = title;
            
            lastAttribute = self.titleView.mas_bottom;
        }
        self.buttonView = [UIView new];
        [self addSubview:self.buttonView];
        [self.buttonView setBackgroundColor:LDR_BackgroundColor];
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(lastAttribute).mas_offset(0.5f);
        }];
        
        __block UIButton *firstButton = nil;
        __block UIButton *lastButton = nil;
        for ( NSInteger i = 0 ; i < items.count; ++i )
        {
            MMPopupItem *item = items[i];
            
            UIButton *btn = [UIButton mm_buttonWithTarget:self action:@selector(actionButton:)];
            [self.buttonView addSubview:btn];
            btn.tag = i;
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.equalTo(self.buttonView).insets(UIEdgeInsetsMake(0, -MM_SPLIT_WIDTH, 0, -MM_SPLIT_WIDTH));
                make.height.mas_equalTo(56);
                
                if ( !firstButton )
                {
                    firstButton = btn;
                    make.top.equalTo(self.buttonView.mas_top);
                }
                else
                {
                    make.top.equalTo(lastButton.mas_bottom);
                    make.height.equalTo(firstButton);
                }
                
                lastButton = btn;
            }];
            [btn setBackgroundImage:[UIImage mm_imageWithColor:LDR_BackgroundColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage mm_imageWithColor:LDR_TextLightGrayColor] forState:UIControlStateHighlighted];
            [btn setTitle:item.title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHex:0xF25441FF] forState:UIControlStateNormal];
            btn.titleLabel.font = LDRFont18;
            btn.enabled = !item.disabled;
        }
        [lastButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.buttonView.mas_bottom);
        }];
        
        self.cancelButton = [UIButton mm_buttonWithTarget:self action:@selector(actionCancel)];
        [self addSubview:self.cancelButton];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.buttonView);
            make.height.mas_equalTo(LDRButtonHeight);
            make.top.equalTo(self.buttonView.mas_bottom).offset(8);
        }];
        self.cancelButton.titleLabel.font = LDRFont18;
        [self.cancelButton setBackgroundImage:[UIImage mm_imageWithColor:LDR_BackgroundColor] forState:UIControlStateNormal];
        [self.cancelButton setBackgroundImage:[UIImage mm_imageWithColor:LDR_TextLightGrayColor] forState:UIControlStateHighlighted];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:LDR_TextGrayColor forState:UIControlStateNormal];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cancelButton.mas_bottom).mas_offset(KBottomSafeHeight);
        }];
    }
    return self;
}
- (void)actionButton:(UIButton*)btn
{
    MMPopupItem *item = self.actionItems[btn.tag];
    
    [self hide];
    
    if ( item.handler )
    {
        item.handler(btn.tag);
    }
}
- (void)actionCancel
{
    [self hide];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self clipCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:LDRControllerRadius];
}
@end
